/*
Copyright (c) 2018, Robert Ou <rqou@robertou.com> and contributors
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

use std::collections::{HashMap, HashSet};

extern crate xc2bit;
use self::xc2bit::*;

extern crate yosys_netlist_json;

use objpool::*;

#[derive(Clone, PartialEq, Eq, Hash, Debug, Serialize, Deserialize)]
pub enum IntermediateGraphNodeVariant {
    AndTerm {
        inputs_true: Vec<ObjPoolIndex<IntermediateGraphNet>>,
        inputs_comp: Vec<ObjPoolIndex<IntermediateGraphNet>>,
        output: ObjPoolIndex<IntermediateGraphNet>,
    },
    OrTerm {
        inputs: Vec<ObjPoolIndex<IntermediateGraphNet>>,
        output: ObjPoolIndex<IntermediateGraphNet>,
    },
    Xor {
        orterm_input: Option<ObjPoolIndex<IntermediateGraphNet>>,
        andterm_input: Option<ObjPoolIndex<IntermediateGraphNet>>,
        invert_out: bool,
        output: ObjPoolIndex<IntermediateGraphNet>,
    },
    Reg {
        mode: XC2MCRegMode,
        clkinv: bool,
        clkddr: bool,
        init_state: bool,
        set_input: Option<ObjPoolIndex<IntermediateGraphNet>>,
        reset_input: Option<ObjPoolIndex<IntermediateGraphNet>>,
        ce_input: Option<ObjPoolIndex<IntermediateGraphNet>>,
        dt_input: ObjPoolIndex<IntermediateGraphNet>,
        clk_input: ObjPoolIndex<IntermediateGraphNet>,
        output: ObjPoolIndex<IntermediateGraphNet>,
    },
    BufgClk {
        input: ObjPoolIndex<IntermediateGraphNet>,
        output: ObjPoolIndex<IntermediateGraphNet>,
    },
    BufgGTS {
        input: ObjPoolIndex<IntermediateGraphNet>,
        output: ObjPoolIndex<IntermediateGraphNet>,
        invert: bool,
    },
    BufgGSR {
        input: ObjPoolIndex<IntermediateGraphNet>,
        output: ObjPoolIndex<IntermediateGraphNet>,
        invert: bool,
    },
    IOBuf {
        input: Option<ObjPoolIndex<IntermediateGraphNet>>,
        oe: Option<ObjPoolIndex<IntermediateGraphNet>>,
        output: Option<ObjPoolIndex<IntermediateGraphNet>>,
        schmitt_trigger: bool,
        termination_enabled: bool,
        slew_is_fast: bool,
        uses_data_gate: bool,
    },
    InBuf {
        output: ObjPoolIndex<IntermediateGraphNet>,
        schmitt_trigger: bool,
        termination_enabled: bool,
        uses_data_gate: bool,
    },
}

#[derive(Clone, PartialEq, Eq, Hash, Debug, Serialize, Deserialize)]
pub struct IntermediateGraphNode {
    pub variant: IntermediateGraphNodeVariant,
    pub name: String,
    pub location: Option<RequestedLocation>,
}

#[derive(Clone, PartialEq, Eq, Hash, Debug, Serialize, Deserialize)]
pub struct IntermediateGraphNet {
    pub name: Option<String>,
    pub source: Option<ObjPoolIndex<IntermediateGraphNode>>,
    pub sinks: Vec<ObjPoolIndex<IntermediateGraphNode>>,
}

#[derive(Clone, PartialEq, Eq, Hash, Debug, Serialize, Deserialize)]
pub struct IntermediateGraph {
    pub nodes: ObjPool<IntermediateGraphNode>,
    pub nets: ObjPool<IntermediateGraphNet>,
    pub vdd_net: ObjPoolIndex<IntermediateGraphNet>,
    pub vss_net: ObjPoolIndex<IntermediateGraphNet>,
}

impl IntermediateGraph {
    pub fn from_yosys_netlist(yosys_net: &yosys_netlist_json::Netlist) -> Result<Self, &'static str> {
        let mut top_module_name = "";
        let mut top_module_found = false;
        for (module_name, module) in &yosys_net.modules {
            if let Some(top_attr) = module.attributes.get("top") {
                if let &yosys_netlist_json::AttributeVal::N(n) = top_attr {
                    if n != 0 {
                        // Claims to be a top-level module
                        if top_module_found {
                            return Err("Multiple top-level modules found in netlist");
                        }

                        top_module_found = true;
                        top_module_name = module_name;
                    }
                }
            }
        }

        if !top_module_found {
            return Err("No top-level modules found in netlist");
        }
        let top_module = yosys_net.modules.get(top_module_name).unwrap();

        // First, we must process all nets
        let mut nets = ObjPool::new();
        // These "magic" nets correspond to a constant 1/0 signal
        let vdd_net = nets.insert(IntermediateGraphNet {
            name: Some(String::from("<internal virtual Vdd net>")),
            source: None,
            sinks: Vec::new(),
        });
        let vss_net = nets.insert(IntermediateGraphNet {
            name: Some(String::from("<internal virtual Vss net>")),
            source: None,
            sinks: Vec::new(),
        });

        // This maps from a Yosys net number to an internal net number
        let mut net_map: HashMap<usize, ObjPoolIndex<IntermediateGraphNet>> = HashMap::new();

        // Keep track of module ports
        let mut module_ports = HashSet::new();
        for (_, port) in &top_module.ports {
            for yosys_edge_idx in &port.bits {
                if let &yosys_netlist_json::BitVal::N(n) = yosys_edge_idx {
                    module_ports.insert(n);
                }
            }
        }

        // Process in order so that the results do not differ across runs
        let mut cell_names = top_module.cells.keys().collect::<Vec<_>>();
        cell_names.sort();

        // Cells can refer to a net, so loop through these as well
        for &cell_name in &cell_names {
            let cell = &top_module.cells[cell_name];
            let mut connection_names = cell.connections.keys().collect::<Vec<_>>();
            connection_names.sort();
            for connection_name in connection_names {
                let connection_vec = &cell.connections[connection_name];
                for connection in connection_vec.iter() {
                    if let &yosys_netlist_json::BitVal::N(yosys_edge_idx) = connection {
                        // Don't create nets for the pad side of io buffers
                        if module_ports.contains(&yosys_edge_idx) {
                            continue;
                        }

                        if net_map.get(&yosys_edge_idx).is_none() {
                            // Need to add a new one
                            let our_edge_idx = nets.insert(IntermediateGraphNet {
                                name: None,
                                source: None,
                                sinks: Vec::new(),
                            });
                            net_map.insert(yosys_edge_idx, our_edge_idx);
                        }
                    }
                }
            }
        }

        // Now we want to loop through netnames and *) insert any new names (dangling?) and *) assign human-readable
        // net names
        let mut netname_names = top_module.netnames.keys().collect::<Vec<_>>();
        netname_names.sort();
        for netname_name in netname_names {
            let netname_obj = &top_module.netnames[netname_name];
            for yosys_edge_idx in &netname_obj.bits {
                if let &yosys_netlist_json::BitVal::N(yosys_edge_idx) = yosys_edge_idx {
                    // Don't create nets for the pad side of io buffers
                    if module_ports.contains(&yosys_edge_idx) {
                        continue;
                    }

                    if net_map.get(&yosys_edge_idx).is_none() {
                        // Need to add a new one
                        let our_edge_idx = nets.insert(IntermediateGraphNet {
                            name: Some(netname_name.to_owned()),
                            source: None,
                            sinks: Vec::new(),
                        });
                        net_map.insert(yosys_edge_idx, our_edge_idx);
                    } else {
                        // Naming an existing one
                        let existing_net_our_idx = net_map.get(&yosys_edge_idx).unwrap();
                        let existing_net = nets.get_mut(*existing_net_our_idx);
                        existing_net.name = Some(netname_name.to_owned());
                    }
                }
            }
        }

        // Now we can actually process objects
        let mut nodes = ObjPool::new();

        let bitval_to_net = |bitval| {
            match bitval {
                yosys_netlist_json::BitVal::N(n) => Ok(*net_map.get(&n).unwrap()),
                yosys_netlist_json::BitVal::S(yosys_netlist_json::SpecialBit::_0) => Ok(vss_net),
                yosys_netlist_json::BitVal::S(yosys_netlist_json::SpecialBit::_1) => Ok(vdd_net),
                // We should never see an x/z in our processing
                _ => Err("Illegal bit value in JSON"),
            }
        };

        // and finally process cells
        for &cell_name in &cell_names {
            let cell_obj = &top_module.cells[cell_name];

            // Helper to retrieve a parameter
            let numeric_param = |name: &str| {
                let param_option = cell_obj.parameters.get(name);
                if param_option.is_none() {
                    return Err("required cell parameter is missing");
                }
                if let &yosys_netlist_json::AttributeVal::N(n) = param_option.unwrap() {
                    return Ok(n)
                } else {
                    return Err("cell parameter is not a number");
                };
            };

            // Helper to retrieve an optional string attribute
            let optional_string_attrib = |name: &str| -> Result<Option<&str>, &'static str> {
                let param_option = cell_obj.attributes.get(name);
                if param_option.is_none() {
                    return Ok(None);
                }
                if let &yosys_netlist_json::AttributeVal::S(ref s) = param_option.unwrap() {
                    return Ok(Some(s))
                } else {
                    return Err("cell parameter is not a string");
                };
            };

            // Helper to retrieve an optional string attribute containing a boolean
            let optional_string_bool_attrib = |name: &str| -> Result<bool, &'static str> {
                let attrib = optional_string_attrib(name)?;
                Ok(if let Some(attrib) = attrib {
                    if attrib.eq_ignore_ascii_case("true") {
                        true
                    } else if attrib.eq_ignore_ascii_case("false") {
                        false
                    } else {
                        return Err("invalid attribute value");
                    }
                } else {
                    false   // TODO: Default should be?
                })
            };

            // Helper to retrieve a single net that is definitely required
            let single_required_connection = |name : &str| {
                let conn_obj = cell_obj.connections.get(name);
                if conn_obj.is_none() {
                    return Err("cell is missing required connection");
                }
                let conn_obj = conn_obj.unwrap();
                if conn_obj.len() != 1 {
                    return Err("cell connection has too many nets")
                }
                return Ok(bitval_to_net(conn_obj[0].clone())?);
            };

            // Helper to retrieve a single net that is optional
            let single_optional_connection = |name: &str| {
                let conn_obj = cell_obj.connections.get(name);
                if conn_obj.is_none() {
                    return Ok(None);
                }
                let conn_obj = conn_obj.unwrap();
                if conn_obj.len() != 1 {
                    return Err("cell connection has too many nets")
                }
                return Ok(Some(bitval_to_net(conn_obj[0].clone())?));
            };

            // Helper to retrieve an array of nets that is required
            let multiple_required_connection = |name : &str| {
                let conn_obj = cell_obj.connections.get(name);
                if conn_obj.is_none() {
                    return Err("cell is missing required connection");
                }
                let mut result = Vec::new();
                for x in conn_obj.unwrap() {
                    result.push(bitval_to_net(x.clone())?);
                }
                return Ok(result);
            };

            match cell_obj.cell_type.as_ref() {
                "IOBUFE"  => {
                    // FIXME: Check that IO goes to a module port

                    let slew_attrib = optional_string_attrib("SLEW")?;
                    let slew_is_fast = if let Some(attrib) = slew_attrib {
                        if attrib.eq_ignore_ascii_case("fast") {
                            true
                        } else if attrib.eq_ignore_ascii_case("slow") {
                            false
                        } else {
                            return Err("invalid attribute value");
                        }
                    } else {
                        false   // TODO: Default should be?
                    };

                    let uses_data_gate = optional_string_bool_attrib("DATA_GATE")?;
                    // FIXME: Check if this is requested on parts where this is not supported

                    nodes.insert(IntermediateGraphNode {
                        name: cell_name.to_owned(),
                        variant: IntermediateGraphNodeVariant::IOBuf {
                            input: single_optional_connection("I")?,
                            oe: single_optional_connection("E")?,
                            output: single_optional_connection("O")?,
                            schmitt_trigger: optional_string_bool_attrib("SCHMITT_TRIGGER")?,
                            termination_enabled: optional_string_bool_attrib("TERM")?,
                            slew_is_fast,
                            uses_data_gate,
                        },
                        location: RequestedLocation::parse_location(optional_string_attrib("LOC")?)?,
                    });
                },
                "IBUF" => {
                    // FIXME: Check that IO goes to a module port

                    let uses_data_gate = optional_string_bool_attrib("DATA_GATE")?;
                    // FIXME: Check if this is requested on parts where this is not supported

                    nodes.insert(IntermediateGraphNode {
                        name: cell_name.to_owned(),
                        variant: IntermediateGraphNodeVariant::InBuf {
                            output: single_required_connection("O")?,
                            schmitt_trigger: optional_string_bool_attrib("SCHMITT_TRIGGER")?,
                            termination_enabled: optional_string_bool_attrib("TERM")?,
                            uses_data_gate,
                        },
                        location: RequestedLocation::parse_location(optional_string_attrib("LOC")?)?,
                    });
                },
                "ANDTERM" => {
                    let num_true_inputs = numeric_param("TRUE_INP")?;
                    let num_comp_inputs = numeric_param("COMP_INP")?;

                    let inputs_true = multiple_required_connection("IN")?;
                    let inputs_comp = multiple_required_connection("IN_B")?;

                    if num_true_inputs != inputs_true.len() || num_comp_inputs != inputs_comp.len() {
                        return Err("ANDTERM cell has a mismatched number of inputs");
                    }

                    nodes.insert(IntermediateGraphNode {
                        name: cell_name.to_owned(),
                        variant: IntermediateGraphNodeVariant::AndTerm {
                            inputs_true,
                            inputs_comp,
                            output: single_required_connection("OUT")?,
                        },
                        location: RequestedLocation::parse_location(optional_string_attrib("LOC")?)?,
                    });
                },
                "ORTERM" => {
                    let num_inputs = numeric_param("WIDTH")?;

                    let inputs = multiple_required_connection("IN")?;

                    if num_inputs != inputs.len() {
                        return Err("ORTERM cell has a mismatched number of inputs");
                    }

                    nodes.insert(IntermediateGraphNode {
                        name: cell_name.to_owned(),
                        variant: IntermediateGraphNodeVariant::OrTerm {
                            inputs,
                            output: single_required_connection("OUT")?,
                        },
                        location: RequestedLocation::parse_location(optional_string_attrib("LOC")?)?,
                    });
                },
                "MACROCELL_XOR" => {
                    nodes.insert(IntermediateGraphNode {
                        name: cell_name.to_owned(),
                        variant: IntermediateGraphNodeVariant::Xor {
                            andterm_input: single_optional_connection("IN_PTC")?,
                            orterm_input: single_optional_connection("IN_ORTERM")?,
                            invert_out: numeric_param("INVERT_OUT")? != 0,
                            output: single_required_connection("OUT")?,
                        },
                        location: RequestedLocation::parse_location(optional_string_attrib("LOC")?)?,
                    });
                },
                "BUFG" => {
                    nodes.insert(IntermediateGraphNode {
                        name: cell_name.to_owned(),
                        variant: IntermediateGraphNodeVariant::BufgClk {
                            input: single_required_connection("I")?,
                            output: single_required_connection("O")?,
                        },
                        location: RequestedLocation::parse_location(optional_string_attrib("LOC")?)?,
                    });
                },
                "BUFGTS" => {
                    nodes.insert(IntermediateGraphNode {
                        name: cell_name.to_owned(),
                        variant: IntermediateGraphNodeVariant::BufgGTS {
                            input: single_required_connection("I")?,
                            output: single_required_connection("O")?,
                            invert: numeric_param("INVERT")? != 0,
                        },
                        location: RequestedLocation::parse_location(optional_string_attrib("LOC")?)?,
                    });
                },
                "BUFGSR" => {
                    nodes.insert(IntermediateGraphNode {
                        name: cell_name.to_owned(),
                        variant: IntermediateGraphNodeVariant::BufgGSR {
                            input: single_required_connection("I")?,
                            output: single_required_connection("O")?,
                            invert: numeric_param("INVERT")? != 0,
                        },
                        location: RequestedLocation::parse_location(optional_string_attrib("LOC")?)?,
                    });
                },
                "FDCP" | "FDCP_N" | "FDDCP" |
                "LDCP" | "LDCP_N" |
                "FTCP" | "FTCP_N" | "FTDCP" |
                "FDCPE" | "FDCPE_N" | "FDDCPE" => {
                    let mode = match cell_obj.cell_type.as_ref() {
                        "FDCP" | "FDCP_N" | "FDDCP"     => XC2MCRegMode::DFF,
                        "LDCP" | "LDCP_N"               => XC2MCRegMode::LATCH,
                        "FTCP" | "FTCP_N" | "FTDCP"     => XC2MCRegMode::TFF,
                        "FDCPE" | "FDCPE_N" | "FDDCPE"  => XC2MCRegMode::DFFCE,
                        _ => unreachable!()
                    };

                    let clkinv = match cell_obj.cell_type.as_ref() {
                        "FDCP_N" | "LDCP_N" | "FTCP_N" | "FDCPE_N" => true,
                        _ => false,
                    };

                    let clkddr = match cell_obj.cell_type.as_ref() {
                        "FDDCP" | "FTDCP" | "FDDCPE" => true,
                        _ => false,
                    };

                    let mut ce_input = None;
                    if mode == XC2MCRegMode::DFFCE {
                        ce_input = Some(single_required_connection("CE")?);
                    }

                    let dt_name = if mode == XC2MCRegMode::TFF {"T"} else {"D"};
                    let clk_name = if mode == XC2MCRegMode::LATCH {"G"} else {"C"};

                    nodes.insert(IntermediateGraphNode {
                        name: cell_name.to_owned(),
                        variant: IntermediateGraphNodeVariant::Reg {
                            mode,
                            clkinv,
                            clkddr,
                            init_state: numeric_param("INIT")? != 0,
                            set_input: single_optional_connection("PRE")?,
                            reset_input: single_optional_connection("CLR")?,
                            ce_input,
                            dt_input: single_required_connection(dt_name)?,
                            clk_input: single_required_connection(clk_name)?,
                            output: single_required_connection("Q")?,
                        },
                        location: RequestedLocation::parse_location(optional_string_attrib("LOC")?)?,
                    });
                }
                _ => return Err("unsupported cell type")
            }
        }

        // Now that we are done processing, hook up sources/sinks in the edges

        // This helper is used to check if a net already has a source and raise an error if it does
        let set_net_source = |nets: &mut ObjPool<IntermediateGraphNet>, output, x| {
            let output_net = nets.get_mut(output);
            if output_net.source.is_some() {
                return Err("multiple drivers for net");
            }
            output_net.source = Some(x);
            Ok(())
        };

        for node_idx in nodes.iter_idx() {
            let node = nodes.get(node_idx);
            match node.variant {
                IntermediateGraphNodeVariant::AndTerm{ref inputs_true, ref inputs_comp, output} => {
                    for &input in inputs_true {
                        nets.get_mut(input).sinks.push(node_idx);
                    }
                    for &input in inputs_comp {
                        nets.get_mut(input).sinks.push(node_idx);
                    }
                    set_net_source(&mut nets, output, node_idx)?;
                },
                IntermediateGraphNodeVariant::OrTerm{ref inputs, output} => {
                    for &input in inputs {
                        nets.get_mut(input).sinks.push(node_idx);
                    }
                    set_net_source(&mut nets, output, node_idx)?;
                },
                IntermediateGraphNodeVariant::Xor{orterm_input, andterm_input, output, ..} => {
                    if orterm_input.is_some() {
                        nets.get_mut(orterm_input.unwrap()).sinks.push(node_idx);
                    }
                    if andterm_input.is_some() {
                        nets.get_mut(andterm_input.unwrap()).sinks.push(node_idx);
                    }
                    set_net_source(&mut nets, output, node_idx)?;
                },
                IntermediateGraphNodeVariant::Reg{set_input, reset_input, ce_input, dt_input, clk_input, output, ..} => {
                    if set_input.is_some() {
                        nets.get_mut(set_input.unwrap()).sinks.push(node_idx);
                    }
                    if reset_input.is_some() {
                        nets.get_mut(reset_input.unwrap()).sinks.push(node_idx);
                    }
                    if ce_input.is_some() {
                        nets.get_mut(ce_input.unwrap()).sinks.push(node_idx);
                    }
                    nets.get_mut(dt_input).sinks.push(node_idx);
                    nets.get_mut(clk_input).sinks.push(node_idx);
                    set_net_source(&mut nets, output, node_idx)?;
                },
                IntermediateGraphNodeVariant::BufgClk{input, output, ..} |
                IntermediateGraphNodeVariant::BufgGTS{input, output, ..} |
                IntermediateGraphNodeVariant::BufgGSR{input, output, ..} => {
                    nets.get_mut(input).sinks.push(node_idx);
                    set_net_source(&mut nets, output, node_idx)?;
                },
                IntermediateGraphNodeVariant::IOBuf{input, oe, output, ..} => {
                    if input.is_some() {
                        nets.get_mut(input.unwrap()).sinks.push(node_idx);
                    }
                    if oe.is_some() {
                        nets.get_mut(oe.unwrap()).sinks.push(node_idx);
                    }
                    if output.is_some() {
                        set_net_source(&mut nets, output.unwrap(), node_idx)?;
                    }
                },
                IntermediateGraphNodeVariant::InBuf{output, ..} => {
                    set_net_source(&mut nets, output, node_idx)?;
                },
            }
        }

        // Check for undriven nets
        for net_idx in nets.iter_idx() {
            if net_idx == vdd_net || net_idx == vss_net {
                continue;
            }

            let net = nets.get(net_idx);
            if net.source.is_none() {
                return Err("net without driver");
            }
        }

        Ok(Self {
            nodes,
            nets,
            vdd_net,
            vss_net,
        })
    }

    pub fn gather_macrocells(&self) -> Vec<ObjPoolIndex<IntermediateGraphNode>> {
        let mut ret = Vec::new();
        let mut encountered_xors = HashSet::new();

        // XXX note: The types of macrocells _must_ be searched in this order (or at least unregistered IBUFs must be
        // last). This property is relied on by the greedy initial placement algorithm.

        // First iteration: Find IOBUFE
        for node_idx in self.nodes.iter_idx() {
            let node = self.nodes.get(node_idx);

            if let IntermediateGraphNodeVariant::IOBuf{input, ..} = node.variant {
                ret.push(node_idx);

                if input.is_some() {
                    let input = input.unwrap();

                    let source_node_idx = self.nets.get(input).source.unwrap();
                    let source_node = self.nodes.get(source_node_idx);
                    if let IntermediateGraphNodeVariant::Xor{..} = source_node.variant {
                        // Combinatorial output
                        encountered_xors.insert(source_node_idx);
                    } else if let IntermediateGraphNodeVariant::Reg{dt_input, ..} = source_node.variant {
                        // Registered output, look at the input into the register
                        let source_node_idx = self.nets.get(dt_input).source.unwrap();
                        let source_node = self.nodes.get(source_node_idx);
                        if let IntermediateGraphNodeVariant::Xor{..} = source_node.variant {
                            encountered_xors.insert(source_node_idx);
                        } else if let IntermediateGraphNodeVariant::IOBuf{..} = source_node.variant {
                            if node_idx != source_node_idx {
                                // Trying to go from a different pin into the direct input path of this pin
                                panic!("mismatched graph node types");
                            }
                            // Otherwise ignore this for now. This is a bit strange, but possible.
                        } else {
                            panic!("mismatched graph node types");
                        }
                    } else {
                        panic!("mismatched graph node types");
                    }
                }
            }
        }

        // Second iteration: Find buried macrocells
        for node_idx in self.nodes.iter_idx() {
            let node = self.nodes.get(node_idx);

            if let IntermediateGraphNodeVariant::Xor{output, ..} = node.variant {
                if encountered_xors.contains(&node_idx) {
                    continue;
                }

                let mut maybe_reg_index = None;
                for &sink_node_idx in &self.nets.get(output).sinks {
                    let sink_node = self.nodes.get(sink_node_idx);

                    if let IntermediateGraphNodeVariant::Reg{..} = sink_node.variant {
                        maybe_reg_index = Some(sink_node_idx);
                    }
                }

                if maybe_reg_index.is_none() {
                    // Buried combinatorial
                    ret.push(node_idx);
                } else {
                    // Buried register
                    ret.push(maybe_reg_index.unwrap());
                }
            }
        }

        // Third iteration: Find registered IBUF
        for node_idx in self.nodes.iter_idx() {
            let node = self.nodes.get(node_idx);

            if let IntermediateGraphNodeVariant::InBuf{output, ..} = node.variant {
                let mut maybe_reg_index = None;
                for &sink_node_idx in &self.nets.get(output).sinks {
                    let sink_node = self.nodes.get(sink_node_idx);

                    if let IntermediateGraphNodeVariant::Reg{..} = sink_node.variant {
                        maybe_reg_index = Some(sink_node_idx);
                    }
                }

                if maybe_reg_index.is_some() {
                    ret.push(node_idx);
                }
            }
        }

        // Fourth iteration: Find unregistered IBUF
        for node_idx in self.nodes.iter_idx() {
            let node = self.nodes.get(node_idx);

            if let IntermediateGraphNodeVariant::InBuf{output, ..} = node.variant {
                let mut maybe_reg_index = None;
                for &sink_node_idx in &self.nets.get(output).sinks {
                    let sink_node = self.nodes.get(sink_node_idx);

                    if let IntermediateGraphNodeVariant::Reg{..} = sink_node.variant {
                        maybe_reg_index = Some(sink_node_idx);
                    }
                }

                if maybe_reg_index.is_none() {
                    ret.push(node_idx);
                }
            }
        }

        ret
    }
}

#[derive(Copy, Clone, PartialEq, Eq, Hash, Debug, Serialize, Deserialize)]
pub struct RequestedLocation {
    pub fb: u32,
    pub i: Option<u32>,
}

impl RequestedLocation {
    fn parse_location(loc: Option<&str>) -> Result<Option<Self>, &'static str> {
        if loc.is_none() {
            return Ok(None);
        }

        let loc = loc.unwrap();

        if loc.starts_with("FB") {
            let loc_fb_i = loc.split("_").collect::<Vec<_>>();
            if loc_fb_i.len() == 1 {
                // FBn
                Ok(Some(RequestedLocation {
                    fb: loc_fb_i[0][2..].parse::<u32>().unwrap() - 1,
                    i: None,
                }))
            } else if loc_fb_i.len() == 2 {
                if !loc_fb_i[1].starts_with("P") {
                    // FBn_i
                    Ok(Some(RequestedLocation {
                        fb: loc_fb_i[0][2..].parse::<u32>().unwrap() - 1,
                        i: Some(loc_fb_i[1].parse::<u32>().unwrap() - 1),
                    }))
                } else {
                    // FBn_Pi
                    Ok(Some(RequestedLocation {
                        fb: loc_fb_i[0][2..].parse::<u32>().unwrap() - 1,
                        i: Some(loc_fb_i[1][1..].parse::<u32>().unwrap()),
                    }))
                }
            } else {
                Err("Malformed LOC constraint")
            }
        } else {
            // TODO: Pin names
            Err("Malformed LOC constraint")
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    use std;
    use std::fs::File;
    use std::io::Read;

    extern crate serde_json;

    fn run_one_reftest(input_filename: &'static str) {
        // Read original json
        let input_path = std::path::Path::new(input_filename);
        let mut input_data = Vec::new();
        File::open(&input_path).unwrap().read_to_end(&mut input_data).unwrap();
        let yosys_netlist = yosys_netlist_json::Netlist::from_slice(&input_data).unwrap();
        // This is what we get
        let our_data_structure = IntermediateGraph::from_yosys_netlist(&yosys_netlist).unwrap();

        // Read reference json
        let mut output_path = input_path.to_path_buf();
        output_path.set_extension("out");
        let mut output_data = Vec::new();
        File::open(&output_path).unwrap().read_to_end(&mut output_data).unwrap();
        let reference_data_structure = serde_json::from_slice(&output_data).unwrap();

        assert_eq!(our_data_structure, reference_data_structure);
    }

    // Include list of actual tests to run
    include!(concat!(env!("OUT_DIR"), "/frontend-reftests.rs"));
}
