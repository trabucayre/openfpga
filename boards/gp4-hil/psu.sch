EESchema Schematic File Version 2
LIBS:analog-azonenberg
LIBS:cmos
LIBS:cypress-azonenberg
LIBS:hirose-azonenberg
LIBS:memory-azonenberg
LIBS:microchip-azonenberg
LIBS:osc-azonenberg
LIBS:passive-azonenberg
LIBS:power-azonenberg
LIBS:special-azonenberg
LIBS:xilinx-azonenberg
LIBS:conn
LIBS:device
LIBS:gp4-hil-cache
EELAYER 25 0
EELAYER END
$Descr A2 23386 16535
encoding utf-8
Sheet 2 7
Title "GreenPak Hardware-In-Loop Test Platform"
Date "2016-07-03"
Rev "0.1"
Comp "Andrew Zonenberg"
Comment1 "Power regulation"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 7200 2500 0    60   ~ 0
Low current rails:\n* 7V5 Vpp\n\nHigh current rails (LTC3374):\n* 3V3 DUT\n* 2V5 PHY analog\n* 1V8 FPGA VCCAUX/VCCXADC, PHY I/O, DUT\n* 1V2 PHY analog/digital core\n* 1V0 FPGA VCCINT/VCCBRAM\n\nVariable rails:\n* DUT_VDD1/DUT_VDD2 muxed from 1V8/3V3\n\nInput: Unregulated 5V DC
$Comp
L LTC3374-QFN U3
U 2 1 5732D550
P 3000 5100
F 0 "U3" H 3750 5050 60  0000 L CNN
F 1 "LTC3374-QFN" H 3000 5050 60  0000 L CNN
F 2 "azonenberg_pcb:QFN_38_0.5MM_5x7MM" H 3000 5100 60  0001 C CNN
F 3 "" H 3000 5100 60  0000 C CNN
	2    3000 5100
	-1   0    0    -1  
$EndComp
Text HLabel 14250 4550 2    60   Output ~ 0
DUT_VPP
Text HLabel 4550 9500 2    60   Output ~ 0
2V5
Text HLabel 4550 7600 2    60   Output ~ 0
1V2
Text HLabel 5250 4100 2    60   Output ~ 0
1V0
Text HLabel 900  2050 0    60   Output ~ 0
GND
Text HLabel 9400 7550 2    60   Output ~ 0
DUT_VDD1
Text HLabel 4550 10450 2    60   Output ~ 0
3V3
$Comp
L LTC3374-QFN U3
U 1 1 573BE214
P 3000 4250
F 0 "U3" H 3750 4200 60  0000 L CNN
F 1 "LTC3374-QFN" H 3000 4200 60  0000 L CNN
F 2 "azonenberg_pcb:QFN_38_0.5MM_5x7MM" H 3000 4250 60  0001 C CNN
F 3 "" H 3000 4250 60  0000 C CNN
	1    3000 4250
	-1   0    0    -1  
$EndComp
$Comp
L LTC3374-QFN U3
U 3 1 573BE269
P 3000 5950
F 0 "U3" H 3750 5900 60  0000 L CNN
F 1 "LTC3374-QFN" H 3000 5900 60  0000 L CNN
F 2 "azonenberg_pcb:QFN_38_0.5MM_5x7MM" H 3000 5950 60  0001 C CNN
F 3 "" H 3000 5950 60  0000 C CNN
	3    3000 5950
	-1   0    0    -1  
$EndComp
$Comp
L LTC3374-QFN U3
U 4 1 573BE2C2
P 3000 6800
F 0 "U3" H 3750 6750 60  0000 L CNN
F 1 "LTC3374-QFN" H 3000 6750 60  0000 L CNN
F 2 "azonenberg_pcb:QFN_38_0.5MM_5x7MM" H 3000 6800 60  0001 C CNN
F 3 "" H 3000 6800 60  0000 C CNN
	4    3000 6800
	-1   0    0    -1  
$EndComp
$Comp
L LTC3374-QFN U3
U 5 1 573BE337
P 3000 7750
F 0 "U3" H 3750 7700 60  0000 L CNN
F 1 "LTC3374-QFN" H 3000 7700 60  0000 L CNN
F 2 "azonenberg_pcb:QFN_38_0.5MM_5x7MM" H 3000 7750 60  0001 C CNN
F 3 "" H 3000 7750 60  0000 C CNN
	5    3000 7750
	-1   0    0    -1  
$EndComp
$Comp
L LTC3374-QFN U3
U 6 1 573BE3DA
P 3000 8700
F 0 "U3" H 3750 8650 60  0000 L CNN
F 1 "LTC3374-QFN" H 3000 8650 60  0000 L CNN
F 2 "azonenberg_pcb:QFN_38_0.5MM_5x7MM" H 3000 8700 60  0001 C CNN
F 3 "" H 3000 8700 60  0000 C CNN
	6    3000 8700
	-1   0    0    -1  
$EndComp
$Comp
L LTC3374-QFN U3
U 9 1 573BE573
P 2100 2100
F 0 "U3" H 2550 2803 60  0000 C CNN
F 1 "LTC3374-QFN" H 2550 2697 60  0000 C CNN
F 2 "azonenberg_pcb:QFN_38_0.5MM_5x7MM" H 2100 2100 60  0001 C CNN
F 3 "" H 2100 2100 60  0000 C CNN
	9    2100 2100
	1    0    0    -1  
$EndComp
Text Label 1850 15100 0    60   ~ 0
5V0_IN
Text Label 1850 15200 0    60   ~ 0
GND
NoConn ~ 1650 15300
Text Notes 1400 15450 0    60   ~ 0
Power inlet
$Comp
L CONN_3_PWROUT K1
U 1 1 573DEBE1
P 1300 15200
F 0 "K1" H 1428 15226 50  0000 L CNN
F 1 "CONN_3_PWROUT" H 1428 15141 40  0000 L CNN
F 2 "azonenberg_pcb:CONN_CUI_PJ-058BH_HIPWR_BARREL_NOSLOT" H 1300 15200 60  0001 C CNN
F 3 "" H 1300 15200 60  0000 C CNN
	1    1300 15200
	-1   0    0    -1  
$EndComp
Text Notes 10300 2500 0    60   ~ 0
Target loads:\n* 3V3 @ 1A\n* 2V5 @ 1A\n* 1V8 @ 1A\n* 1V2 @ 1A\n* 1V0 @ 4A\n\nFPGA:\n* 1V0 @ 1.25A\n* 1V8 @ 0.1A\n\nPHY:\n* 2V5 @ 0.1 A\n* 1V8 @ 0.1A\n* 1V2 @ 0.25 A
Text Label 900  1650 2    60   ~ 0
5V0
$Comp
L R R100
U 1 1 573EFCE7
P 4050 1600
F 0 "R100" V 3950 1600 50  0000 C CNN
F 1 "1K" V 4050 1600 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 3980 1600 30  0001 C CNN
F 3 "" H 4050 1600 30  0000 C CNN
	1    4050 1600
	-1   0    0    1   
$EndComp
Text Label 3700 1850 0    60   ~ 0
GND
Text Label 3700 1950 0    60   ~ 0
5V0
Text Label 3700 1650 0    60   ~ 0
5V0
Text HLabel 3700 2050 2    60   Output ~ 0
PSU_VTEMP
Text Label 4050 1450 0    60   ~ 0
1V8
Text Label 3550 3800 0    60   ~ 0
5V0
Text Label 3200 4550 2    60   ~ 0
GND
Text Label 3200 5400 2    60   ~ 0
GND
Text Label 3200 6250 2    60   ~ 0
GND
Text Label 3400 4100 0    60   ~ 0
SW_1V0
Text Label 3500 4200 0    60   ~ 0
FB_1V0
$Comp
L INDUCTOR_PWROUT L6
U 1 1 573F8850
P 4200 4100
F 0 "L6" V 4250 4350 40  0000 C CNN
F 1 "2.2 uH 8.2A" V 4150 4100 40  0000 C CNN
F 2 "azonenberg_pcb:INDUCTOR_TDK_SPM6530" H 4200 4100 60  0001 C CNN
F 3 "" H 4200 4100 60  0000 C CNN
	1    4200 4100
	0    1    1    0   
$EndComp
$Comp
L C C122
U 1 1 573F8C81
P 4700 4250
F 0 "C122" H 4815 4296 50  0000 L CNN
F 1 "100 uF" H 4815 4204 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1210_CAP_NOSILK" H 4738 4100 30  0001 C CNN
F 3 "" H 4700 4250 60  0000 C CNN
	1    4700 4250
	1    0    0    -1  
$EndComp
Text Label 4600 4400 2    60   ~ 0
GND
$Comp
L R R101
U 1 1 573F957A
P 4100 4750
F 0 "R101" V 4050 4950 50  0000 C CNN
F 1 "2.55K" V 4000 4750 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 4030 4750 30  0001 C CNN
F 3 "" H 4100 4750 30  0000 C CNN
	1    4100 4750
	0    1    1    0   
$EndComp
$Comp
L R R102
U 1 1 573F9A0E
P 4100 4900
F 0 "R102" V 4050 5100 50  0000 C CNN
F 1 "10.2K" V 4200 4900 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 4030 4900 30  0001 C CNN
F 3 "" H 4100 4900 30  0000 C CNN
	1    4100 4900
	0    1    1    0   
$EndComp
Text Label 4500 4900 0    60   ~ 0
GND
$Comp
L R R103
U 1 1 573F9E7C
P 4850 4750
F 0 "R103" V 4800 4950 50  0000 C CNN
F 1 "0" V 4850 4750 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 4780 4750 30  0001 C CNN
F 3 "" H 4850 4750 30  0000 C CNN
	1    4850 4750
	0    1    1    0   
$EndComp
Text Label 4450 4650 0    60   ~ 0
1V0_VSENSE
Text Notes 5200 15550 0    60   ~ 0
SMPS input caps
$Comp
L C C116
U 1 1 573FAB2B
P 5250 15250
F 0 "C116" H 5365 15296 50  0000 L CNN
F 1 "22 uF" H 5365 15204 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 5288 15100 30  0001 C CNN
F 3 "" H 5250 15250 60  0000 C CNN
	1    5250 15250
	1    0    0    -1  
$EndComp
Text Label 5150 15100 2    60   ~ 0
5V0
Text Label 5150 15400 2    60   ~ 0
GND
$Comp
L C C117
U 1 1 573FAD1E
P 5700 15250
F 0 "C117" H 5815 15296 50  0000 L CNN
F 1 "22 uF" H 5815 15204 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 5738 15100 30  0001 C CNN
F 3 "" H 5700 15250 60  0000 C CNN
	1    5700 15250
	1    0    0    -1  
$EndComp
$Comp
L C C118
U 1 1 573FAD72
P 6150 15250
F 0 "C118" H 6265 15296 50  0000 L CNN
F 1 "22 uF" H 6265 15204 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 6188 15100 30  0001 C CNN
F 3 "" H 6150 15250 60  0000 C CNN
	1    6150 15250
	1    0    0    -1  
$EndComp
$Comp
L C C119
U 1 1 573FAE31
P 6600 15250
F 0 "C119" H 6715 15296 50  0000 L CNN
F 1 "22 uF" H 6715 15204 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 6638 15100 30  0001 C CNN
F 3 "" H 6600 15250 60  0000 C CNN
	1    6600 15250
	1    0    0    -1  
$EndComp
$Comp
L C C120
U 1 1 573FAE8F
P 7050 15250
F 0 "C120" H 7165 15296 50  0000 L CNN
F 1 "22 uF" H 7165 15204 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 7088 15100 30  0001 C CNN
F 3 "" H 7050 15250 60  0000 C CNN
	1    7050 15250
	1    0    0    -1  
$EndComp
$Comp
L C C121
U 1 1 573FAEF4
P 7500 15250
F 0 "C121" H 7615 15296 50  0000 L CNN
F 1 "22 uF" H 7615 15204 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 7538 15100 30  0001 C CNN
F 3 "" H 7500 15250 60  0000 C CNN
	1    7500 15250
	1    0    0    -1  
$EndComp
$Comp
L C C123
U 1 1 573FAF58
P 7950 15250
F 0 "C123" H 8065 15296 50  0000 L CNN
F 1 "22 uF" H 8065 15204 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 7988 15100 30  0001 C CNN
F 3 "" H 7950 15250 60  0000 C CNN
	1    7950 15250
	1    0    0    -1  
$EndComp
$Comp
L C C124
U 1 1 573FB037
P 8400 15250
F 0 "C124" H 8515 15296 50  0000 L CNN
F 1 "22 uF" H 8515 15204 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 8438 15100 30  0001 C CNN
F 3 "" H 8400 15250 60  0000 C CNN
	1    8400 15250
	1    0    0    -1  
$EndComp
Text Label 3350 7300 0    60   ~ 0
5V0
$Comp
L INDUCTOR_PWROUT L7
U 1 1 573FD81E
P 3950 7600
F 0 "L7" V 4000 7850 40  0000 C CNN
F 1 "2.2 uH 3.7A" V 3900 7600 40  0000 C CNN
F 2 "azonenberg_pcb:INDUCTOR_YUDEN_NR6028" H 3950 7600 60  0001 C CNN
F 3 "" H 3950 7600 60  0000 C CNN
	1    3950 7600
	0    1    1    0   
$EndComp
Text Label 3250 7600 0    60   ~ 0
SW_1V2
$Comp
L R R104
U 1 1 573FDD6F
P 3550 7700
F 0 "R104" V 3500 7500 50  0000 C CNN
F 1 "232K" V 3550 7700 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 3480 7700 30  0001 C CNN
F 3 "" H 3550 7700 30  0000 C CNN
	1    3550 7700
	0    1    1    0   
$EndComp
$Comp
L R R105
U 1 1 573FE09A
P 3550 7800
F 0 "R105" V 3500 8000 50  0000 C CNN
F 1 "464K" V 3550 7800 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 3480 7800 30  0001 C CNN
F 3 "" H 3550 7800 30  0000 C CNN
	1    3550 7800
	0    1    1    0   
$EndComp
Text Label 3950 7800 0    60   ~ 0
GND
Text Label 3350 7900 2    60   ~ 0
FB_1V2
$Comp
L INDUCTOR_PWROUT L8
U 1 1 57402179
P 3900 15100
F 0 "L8" V 3850 15350 40  0000 C CNN
F 1 "600R" V 3850 14900 40  0000 C CNN
F 2 "azonenberg_pcb:EIA_0603_INDUCTOR_NOSILK" H 3900 15100 60  0001 C CNN
F 3 "" H 3900 15100 60  0000 C CNN
	1    3900 15100
	0    1    1    0   
$EndComp
Text Label 4450 15100 0    60   ~ 0
5V0
Text HLabel 4550 8550 2    60   Output ~ 0
1V8
Text Label 3350 8250 0    60   ~ 0
5V0
$Comp
L INDUCTOR_PWROUT L9
U 1 1 57402C80
P 3950 8550
F 0 "L9" V 4000 8800 40  0000 C CNN
F 1 "2.2 uH 3.7A" V 3900 8550 40  0000 C CNN
F 2 "azonenberg_pcb:INDUCTOR_YUDEN_NR6028" H 3950 8550 60  0001 C CNN
F 3 "" H 3950 8550 60  0000 C CNN
	1    3950 8550
	0    1    1    0   
$EndComp
Text Label 3250 8550 0    60   ~ 0
SW_1V8
$Comp
L R R106
U 1 1 57402C87
P 3550 8650
F 0 "R106" V 3500 8450 50  0000 C CNN
F 1 "806K" V 3550 8650 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 3480 8650 30  0001 C CNN
F 3 "" H 3550 8650 30  0000 C CNN
	1    3550 8650
	0    1    1    0   
$EndComp
$Comp
L R R107
U 1 1 57402C8D
P 3550 8750
F 0 "R107" V 3500 8950 50  0000 C CNN
F 1 "649K" V 3550 8750 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 3480 8750 30  0001 C CNN
F 3 "" H 3550 8750 30  0000 C CNN
	1    3550 8750
	0    1    1    0   
$EndComp
Text Label 3950 8750 0    60   ~ 0
GND
Text Label 3350 8850 2    60   ~ 0
FB_1V8
$Comp
L C C125
U 1 1 5740521F
P 4450 7750
F 0 "C125" H 4565 7796 50  0000 L CNN
F 1 "22 uF" H 4565 7704 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 4488 7600 30  0001 C CNN
F 3 "" H 4450 7750 60  0000 C CNN
	1    4450 7750
	1    0    0    -1  
$EndComp
$Comp
L C C126
U 1 1 574057D6
P 4450 8700
F 0 "C126" H 4565 8746 50  0000 L CNN
F 1 "22 uF" H 4565 8654 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 4488 8550 30  0001 C CNN
F 3 "" H 4450 8700 60  0000 C CNN
	1    4450 8700
	1    0    0    -1  
$EndComp
$Comp
L LTC3374-QFN U3
U 7 1 574069CD
P 3000 9650
F 0 "U3" H 3750 9600 60  0000 L CNN
F 1 "LTC3374-QFN" H 3000 9600 60  0000 L CNN
F 2 "azonenberg_pcb:QFN_38_0.5MM_5x7MM" H 3000 9650 60  0001 C CNN
F 3 "" H 3000 9650 60  0000 C CNN
	7    3000 9650
	-1   0    0    -1  
$EndComp
Text Label 3350 9200 0    60   ~ 0
5V0
$Comp
L INDUCTOR_PWROUT L10
U 1 1 574069D5
P 3950 9500
F 0 "L10" V 4000 9750 40  0000 C CNN
F 1 "2.2 uH 3.7A" V 3900 9500 40  0000 C CNN
F 2 "azonenberg_pcb:INDUCTOR_YUDEN_NR6028" H 3950 9500 60  0001 C CNN
F 3 "" H 3950 9500 60  0000 C CNN
	1    3950 9500
	0    1    1    0   
$EndComp
Text Label 3250 9500 0    60   ~ 0
SW_2V5
$Comp
L R R108
U 1 1 574069DC
P 3550 9600
F 0 "R108" V 3500 9400 50  0000 C CNN
F 1 "1.02M" V 3550 9600 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 3480 9600 30  0001 C CNN
F 3 "" H 3550 9600 30  0000 C CNN
	1    3550 9600
	0    1    1    0   
$EndComp
$Comp
L R R109
U 1 1 574069E2
P 3550 9700
F 0 "R109" V 3500 9900 50  0000 C CNN
F 1 "475K" V 3550 9700 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 3480 9700 30  0001 C CNN
F 3 "" H 3550 9700 30  0000 C CNN
	1    3550 9700
	0    1    1    0   
$EndComp
Text Label 3950 9700 0    60   ~ 0
GND
Text Label 3350 9800 2    60   ~ 0
FB_2V5
$Comp
L C C127
U 1 1 574069F8
P 4450 9650
F 0 "C127" H 4565 9696 50  0000 L CNN
F 1 "22 uF" H 4565 9604 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 4488 9500 30  0001 C CNN
F 3 "" H 4450 9650 60  0000 C CNN
	1    4450 9650
	1    0    0    -1  
$EndComp
$Comp
L LTC3374-QFN U3
U 8 1 57407671
P 3000 10600
F 0 "U3" H 3750 10550 60  0000 L CNN
F 1 "LTC3374-QFN" H 3000 10550 60  0000 L CNN
F 2 "azonenberg_pcb:QFN_38_0.5MM_5x7MM" H 3000 10600 60  0001 C CNN
F 3 "" H 3000 10600 60  0000 C CNN
	8    3000 10600
	-1   0    0    -1  
$EndComp
Text Label 3350 10150 0    60   ~ 0
5V0
$Comp
L INDUCTOR_PWROUT L11
U 1 1 57407678
P 3950 10450
F 0 "L11" V 4000 10700 40  0000 C CNN
F 1 "2.2 uH 3.7A" V 3900 10450 40  0000 C CNN
F 2 "azonenberg_pcb:INDUCTOR_YUDEN_NR6028" H 3950 10450 60  0001 C CNN
F 3 "" H 3950 10450 60  0000 C CNN
	1    3950 10450
	0    1    1    0   
$EndComp
Text Label 3250 10450 0    60   ~ 0
SW_3V3
$Comp
L R R110
U 1 1 5740767F
P 3550 10550
F 0 "R110" V 3500 10350 50  0000 C CNN
F 1 "1.02M" V 3550 10550 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 3480 10550 30  0001 C CNN
F 3 "" H 3550 10550 30  0000 C CNN
	1    3550 10550
	0    1    1    0   
$EndComp
$Comp
L R R111
U 1 1 57407685
P 3550 10650
F 0 "R111" V 3500 10850 50  0000 C CNN
F 1 "324K" V 3550 10650 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 3480 10650 30  0001 C CNN
F 3 "" H 3550 10650 30  0000 C CNN
	1    3550 10650
	0    1    1    0   
$EndComp
Text Label 3950 10650 0    60   ~ 0
GND
Text Label 3350 10750 2    60   ~ 0
FB_3V3
$Comp
L C C128
U 1 1 5740769B
P 4450 10600
F 0 "C128" H 4565 10646 50  0000 L CNN
F 1 "22 uF" H 4565 10554 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 4488 10450 30  0001 C CNN
F 3 "" H 4450 10600 60  0000 C CNN
	1    4450 10600
	1    0    0    -1  
$EndComp
$Comp
L MIC2288-DFN U1
U 1 1 57408F0A
P 7850 4800
F 0 "U1" H 7900 4750 60  0000 C CNN
F 1 "MIC2288-DFN" H 8450 4750 60  0000 C CNN
F 2 "azonenberg_pcb:DFN_8_0.5MM_2x2MM" H 7850 4800 60  0001 C CNN
F 3 "" H 7850 4800 60  0000 C CNN
	1    7850 4800
	1    0    0    -1  
$EndComp
Text Label 7100 4450 2    60   ~ 0
GND
Text Label 7450 4250 2    60   ~ 0
5V0
Text Label 7100 4750 2    60   ~ 0
5V0
$Comp
L C C129
U 1 1 57409C80
P 7250 4600
F 0 "C129" H 7365 4646 50  0000 L CNN
F 1 "2.2 uF" H 7365 4554 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 7288 4450 30  0001 C CNN
F 3 "" H 7250 4600 60  0000 C CNN
	1    7250 4600
	1    0    0    -1  
$EndComp
$Comp
L INDUCTOR_PWROUT L12
U 1 1 5740B8A9
P 8150 4000
F 0 "L12" V 7992 4000 40  0000 C CNN
F 1 "10 uH" V 8070 4000 40  0000 C CNN
F 2 "azonenberg_pcb:EIA_1210_CAP_NOSILK" H 8150 4000 60  0001 C CNN
F 3 "" H 8150 4000 60  0000 C CNN
	1    8150 4000
	0    1    1    0   
$EndComp
$Comp
L D_Schottky D20
U 1 1 5740BB2E
P 8900 4000
F 0 "D20" H 8900 3783 50  0000 C CNN
F 1 "CDBQR0130L" H 8900 3875 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_LED" H 8900 4000 60  0001 C CNN
F 3 "" H 8900 4000 60  0000 C CNN
	1    8900 4000
	-1   0    0    1   
$EndComp
$Comp
L R R112
U 1 1 5740BF68
P 9200 4150
F 0 "R112" H 9270 4196 50  0000 L CNN
F 1 "24K 1%" H 9270 4104 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 9130 4150 30  0001 C CNN
F 3 "" H 9200 4150 30  0000 C CNN
	1    9200 4150
	1    0    0    -1  
$EndComp
$Comp
L R R113
U 1 1 5740C105
P 9200 4600
F 0 "R113" H 9270 4646 50  0000 L CNN
F 1 "4.7K 1%" H 9270 4554 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 9130 4600 30  0001 C CNN
F 3 "" H 9200 4600 30  0000 C CNN
	1    9200 4600
	1    0    0    -1  
$EndComp
Text Label 9050 4750 2    60   ~ 0
GND
$Comp
L C C130
U 1 1 5740C669
P 9650 4450
F 0 "C130" H 9765 4496 50  0000 L CNN
F 1 "10 uF 16V" H 9765 4404 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_1206_CAP_NOSILK" H 9688 4300 30  0001 C CNN
F 3 "" H 9650 4450 60  0000 C CNN
	1    9650 4450
	1    0    0    -1  
$EndComp
Text Notes 9150 5000 0    60   ~ 0
vout = 1.24 * (R1 / 4700 + 1)\nR1 = 24k
Text HLabel 4350 1750 2    60   Output ~ 0
PSU_PGOOD
Text Notes 7650 9800 0    60   ~ 0
Load switching for DUT_VDDx
Text Notes 7850 5000 0    60   ~ 0
Vpp generation
Text Notes 2100 11150 0    60   ~ 0
FPGA and DUT power conversion
$Comp
L SIP32408 U4
U 1 1 57412BC8
P 7700 8100
F 0 "U4" H 7750 8050 60  0000 C CNN
F 1 "SIP32408" H 8100 8050 60  0000 C CNN
F 2 "azonenberg_pcb:DFN_4_0.5MM_1.6x1.2MM" H 7700 8100 60  0001 C CNN
F 3 "" H 7700 8100 60  0000 C CNN
	1    7700 8100
	1    0    0    -1  
$EndComp
$Comp
L C C131
U 1 1 57412CAB
P 7200 7700
F 0 "C131" H 7315 7746 50  0000 L CNN
F 1 "4.7 uF" H 6850 7700 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0603_CAP_NOSILK" H 7238 7550 30  0001 C CNN
F 3 "" H 7200 7700 60  0000 C CNN
	1    7200 7700
	1    0    0    -1  
$EndComp
Text Label 7000 7850 2    60   ~ 0
GND
Text Label 7000 7550 2    60   ~ 0
3V3
$Comp
L C C134
U 1 1 574134E0
P 8700 7700
F 0 "C134" H 8850 7750 50  0000 L CNN
F 1 "0.47 uF" H 8850 7650 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_CAP_NOSILK" H 8738 7550 30  0001 C CNN
F 3 "" H 8700 7700 60  0000 C CNN
	1    8700 7700
	1    0    0    -1  
$EndComp
Text Label 8550 7850 2    60   ~ 0
GND
Text HLabel 7200 8050 0    60   Input ~ 0
VDD1_3V3_EN
$Comp
L SIP32408 U21
U 1 1 574146C8
P 7700 9600
F 0 "U21" H 7750 9550 60  0000 C CNN
F 1 "SIP32408" H 8100 9550 60  0000 C CNN
F 2 "azonenberg_pcb:DFN_4_0.5MM_1.6x1.2MM" H 7700 9600 60  0001 C CNN
F 3 "" H 7700 9600 60  0000 C CNN
	1    7700 9600
	1    0    0    -1  
$EndComp
$Comp
L C C133
U 1 1 574146CE
P 7200 9200
F 0 "C133" H 7315 9246 50  0000 L CNN
F 1 "4.7 uF" H 6850 9200 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0603_CAP_NOSILK" H 7238 9050 30  0001 C CNN
F 3 "" H 7200 9200 60  0000 C CNN
	1    7200 9200
	1    0    0    -1  
$EndComp
Text Label 7000 9350 2    60   ~ 0
GND
Text Label 7000 9050 2    60   ~ 0
1V8
$Comp
L C C136
U 1 1 574146D6
P 8700 9200
F 0 "C136" H 8850 9250 50  0000 L CNN
F 1 "0.47 uF" H 8850 9150 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_CAP_NOSILK" H 8738 9050 30  0001 C CNN
F 3 "" H 8700 9200 60  0000 C CNN
	1    8700 9200
	1    0    0    -1  
$EndComp
Text Label 8550 9350 2    60   ~ 0
GND
Text HLabel 7200 9550 0    60   Input ~ 0
VDD1_1V8_EN
$Comp
L SIP32408 U20
U 1 1 57414AD4
P 7700 8850
F 0 "U20" H 7750 8800 60  0000 C CNN
F 1 "SIP32408" H 8100 8800 60  0000 C CNN
F 2 "azonenberg_pcb:DFN_4_0.5MM_1.6x1.2MM" H 7700 8850 60  0001 C CNN
F 3 "" H 7700 8850 60  0000 C CNN
	1    7700 8850
	1    0    0    -1  
$EndComp
$Comp
L C C132
U 1 1 57414ADA
P 7200 8450
F 0 "C132" H 7315 8496 50  0000 L CNN
F 1 "4.7 uF" H 6850 8450 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0603_CAP_NOSILK" H 7238 8300 30  0001 C CNN
F 3 "" H 7200 8450 60  0000 C CNN
	1    7200 8450
	1    0    0    -1  
$EndComp
Text Label 7000 8600 2    60   ~ 0
GND
Text Label 7000 8300 2    60   ~ 0
2V5
$Comp
L C C135
U 1 1 57414AE2
P 8700 8450
F 0 "C135" H 8850 8500 50  0000 L CNN
F 1 "0.47 uF" H 8850 8400 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_CAP_NOSILK" H 8738 8300 30  0001 C CNN
F 3 "" H 8700 8450 60  0000 C CNN
	1    8700 8450
	1    0    0    -1  
$EndComp
Text Label 8550 8600 2    60   ~ 0
GND
Text HLabel 7200 8800 0    60   Input ~ 0
VDD1_2V5_EN
Text HLabel 14500 7550 2    60   Output ~ 0
DUT_VDD2
$Comp
L SIP32408 U22
U 1 1 57415A55
P 12800 8100
F 0 "U22" H 12850 8050 60  0000 C CNN
F 1 "SIP32408" H 13200 8050 60  0000 C CNN
F 2 "azonenberg_pcb:DFN_4_0.5MM_1.6x1.2MM" H 12800 8100 60  0001 C CNN
F 3 "" H 12800 8100 60  0000 C CNN
	1    12800 8100
	1    0    0    -1  
$EndComp
$Comp
L C C137
U 1 1 57415A5B
P 12300 7700
F 0 "C137" H 12415 7746 50  0000 L CNN
F 1 "4.7 uF" H 11950 7700 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0603_CAP_NOSILK" H 12338 7550 30  0001 C CNN
F 3 "" H 12300 7700 60  0000 C CNN
	1    12300 7700
	1    0    0    -1  
$EndComp
Text Label 12100 7850 2    60   ~ 0
GND
Text Label 12100 7550 2    60   ~ 0
3V3
$Comp
L C C140
U 1 1 57415A63
P 13800 7700
F 0 "C140" H 13950 7750 50  0000 L CNN
F 1 "0.47 uF" H 13950 7650 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_CAP_NOSILK" H 13838 7550 30  0001 C CNN
F 3 "" H 13800 7700 60  0000 C CNN
	1    13800 7700
	1    0    0    -1  
$EndComp
Text Label 13650 7850 2    60   ~ 0
GND
Text HLabel 12300 8050 0    60   Input ~ 0
VDD2_3V3_EN
$Comp
L SIP32408 U24
U 1 1 57415A75
P 12800 9600
F 0 "U24" H 12850 9550 60  0000 C CNN
F 1 "SIP32408" H 13200 9550 60  0000 C CNN
F 2 "azonenberg_pcb:DFN_4_0.5MM_1.6x1.2MM" H 12800 9600 60  0001 C CNN
F 3 "" H 12800 9600 60  0000 C CNN
	1    12800 9600
	1    0    0    -1  
$EndComp
$Comp
L C C139
U 1 1 57415A7B
P 12300 9200
F 0 "C139" H 12415 9246 50  0000 L CNN
F 1 "4.7 uF" H 11950 9200 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0603_CAP_NOSILK" H 12338 9050 30  0001 C CNN
F 3 "" H 12300 9200 60  0000 C CNN
	1    12300 9200
	1    0    0    -1  
$EndComp
Text Label 12100 9350 2    60   ~ 0
GND
Text Label 12100 9050 2    60   ~ 0
1V8
$Comp
L C C142
U 1 1 57415A83
P 13800 9200
F 0 "C142" H 13950 9250 50  0000 L CNN
F 1 "0.47 uF" H 13950 9150 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_CAP_NOSILK" H 13838 9050 30  0001 C CNN
F 3 "" H 13800 9200 60  0000 C CNN
	1    13800 9200
	1    0    0    -1  
$EndComp
Text Label 13650 9350 2    60   ~ 0
GND
Text HLabel 12300 9550 0    60   Input ~ 0
VDD2_1V8_EN
$Comp
L SIP32408 U23
U 1 1 57415A95
P 12800 8850
F 0 "U23" H 12850 8800 60  0000 C CNN
F 1 "SIP32408" H 13200 8800 60  0000 C CNN
F 2 "azonenberg_pcb:DFN_4_0.5MM_1.6x1.2MM" H 12800 8850 60  0001 C CNN
F 3 "" H 12800 8850 60  0000 C CNN
	1    12800 8850
	1    0    0    -1  
$EndComp
$Comp
L C C138
U 1 1 57415A9B
P 12300 8450
F 0 "C138" H 12415 8496 50  0000 L CNN
F 1 "4.7 uF" H 11950 8450 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0603_CAP_NOSILK" H 12338 8300 30  0001 C CNN
F 3 "" H 12300 8450 60  0000 C CNN
	1    12300 8450
	1    0    0    -1  
$EndComp
Text Label 12100 8600 2    60   ~ 0
GND
Text Label 12100 8300 2    60   ~ 0
2V5
$Comp
L C C141
U 1 1 57415AA3
P 13800 8450
F 0 "C141" H 13950 8500 50  0000 L CNN
F 1 "0.47 uF" H 13950 8400 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_CAP_NOSILK" H 13838 8300 30  0001 C CNN
F 3 "" H 13800 8450 60  0000 C CNN
	1    13800 8450
	1    0    0    -1  
$EndComp
Text Label 13650 8600 2    60   ~ 0
GND
Text HLabel 12300 8800 0    60   Input ~ 0
VDD2_2V5_EN
Text HLabel 10750 4600 0    60   Input ~ 0
VPP_EN
$Comp
L R R114
U 1 1 57423567
P 11450 4150
F 0 "R114" H 11520 4196 50  0000 L CNN
F 1 "1K" H 11520 4104 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 11380 4150 30  0001 C CNN
F 3 "" H 11450 4150 30  0000 C CNN
	1    11450 4150
	1    0    0    -1  
$EndComp
$Comp
L SSM6N58NU_DUAL_NMOS Q11
U 1 1 57421FB6
P 11350 4600
F 0 "Q11" H 11491 4653 60  0000 L CNN
F 1 "SSM6N58NU" H 11491 4547 60  0000 L CNN
F 2 "azonenberg_pcb:DFN_6_0.65MM_2x2MM_GDS" H 11350 4600 60  0001 C CNN
F 3 "" H 11350 4600 60  0000 C CNN
	1    11350 4600
	1    0    0    -1  
$EndComp
Text Label 11150 4800 2    60   ~ 0
GND
Text Label 11250 4350 2    60   ~ 0
VPP_EN_HV_N
$Comp
L Q_PMOS_GSD Q12
U 1 1 5742513F
P 12250 4350
F 0 "Q12" H 12444 4304 50  0000 L CNN
F 1 "DMP2069UFY4" H 12444 4396 50  0000 L CNN
F 2 "azonenberg_pcb:DFN_3_DIODES_X2DFN2015-3" H 12450 4450 29  0001 C CNN
F 3 "" H 12250 4350 60  0000 C CNN
	1    12250 4350
	1    0    0    1   
$EndComp
$Comp
L R R116
U 1 1 57457602
P 9300 8650
F 0 "R116" H 9370 8696 50  0000 L CNN
F 1 "0" H 9370 8604 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 9230 8650 30  0001 C CNN
F 3 "" H 9300 8650 30  0000 C CNN
	1    9300 8650
	1    0    0    -1  
$EndComp
$Comp
L R R115
U 1 1 574577CC
P 9300 7900
F 0 "R115" H 9370 7946 50  0000 L CNN
F 1 "0" H 9370 7854 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 9230 7900 30  0001 C CNN
F 3 "" H 9300 7900 30  0000 C CNN
	1    9300 7900
	1    0    0    -1  
$EndComp
Text Notes 7650 9900 0    60   ~ 0
0-ohm resistors are DRC workaround
$Comp
L R R117
U 1 1 574582F9
P 14400 7900
F 0 "R117" H 14470 7946 50  0000 L CNN
F 1 "0" H 14470 7854 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 14330 7900 30  0001 C CNN
F 3 "" H 14400 7900 30  0000 C CNN
	1    14400 7900
	1    0    0    -1  
$EndComp
$Comp
L R R118
U 1 1 5745846F
P 14400 8650
F 0 "R118" H 14470 8696 50  0000 L CNN
F 1 "0" H 14470 8604 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 14330 8650 30  0001 C CNN
F 3 "" H 14400 8650 30  0000 C CNN
	1    14400 8650
	1    0    0    -1  
$EndComp
$Comp
L C C172
U 1 1 5753265C
P 1600 1800
F 0 "C172" H 1715 1846 50  0000 L CNN
F 1 "0.47 uF" H 1715 1754 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_CAP_NOSILK" H 1638 1650 30  0001 C CNN
F 3 "" H 1600 1800 60  0000 C CNN
	1    1600 1800
	1    0    0    -1  
$EndComp
$Comp
L C C171
U 1 1 57532AC4
P 1050 1800
F 0 "C171" H 1165 1846 50  0000 L CNN
F 1 "4.7 uF" H 1165 1754 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0603_CAP_NOSILK" H 1088 1650 30  0001 C CNN
F 3 "" H 1050 1800 60  0000 C CNN
	1    1050 1800
	1    0    0    -1  
$EndComp
Text HLabel 12600 4000 2    60   Output ~ 0
DUT_VPP_RAW
$Comp
L CONN_01X01 TP24
U 1 1 57555F4E
P 21500 1350
F 0 "TP24" H 21578 1388 50  0000 L CNN
F 1 "TESTPOINT" H 21578 1296 50  0000 L CNN
F 2 "azonenberg_pcb:TESTPOINT_SMT_KEYSTONE_5016" H 21500 1350 60  0001 C CNN
F 3 "" H 21500 1350 60  0000 C CNN
	1    21500 1350
	1    0    0    -1  
$EndComp
Text Label 21050 1350 2    60   ~ 0
GND
$Comp
L CONN_01X01 TP25
U 1 1 575560E7
P 21500 1650
F 0 "TP25" H 21578 1688 50  0000 L CNN
F 1 "TESTPOINT" H 21578 1596 50  0000 L CNN
F 2 "azonenberg_pcb:TESTPOINT_SMT_KEYSTONE_5016" H 21500 1650 60  0001 C CNN
F 3 "" H 21500 1650 60  0000 C CNN
	1    21500 1650
	1    0    0    -1  
$EndComp
Text Label 21050 1650 2    60   ~ 0
1V0
$Comp
L CONN_01X01 TP26
U 1 1 57556285
P 21500 1950
F 0 "TP26" H 21578 1988 50  0000 L CNN
F 1 "TESTPOINT" H 21578 1896 50  0000 L CNN
F 2 "azonenberg_pcb:TESTPOINT_SMT_KEYSTONE_5016" H 21500 1950 60  0001 C CNN
F 3 "" H 21500 1950 60  0000 C CNN
	1    21500 1950
	1    0    0    -1  
$EndComp
Text Label 21050 1950 2    60   ~ 0
1V2
$Comp
L CONN_01X01 TP27
U 1 1 5755650C
P 21500 2250
F 0 "TP27" H 21578 2288 50  0000 L CNN
F 1 "TESTPOINT" H 21578 2196 50  0000 L CNN
F 2 "azonenberg_pcb:TESTPOINT_SMT_KEYSTONE_5016" H 21500 2250 60  0001 C CNN
F 3 "" H 21500 2250 60  0000 C CNN
	1    21500 2250
	1    0    0    -1  
$EndComp
Text Label 21050 2250 2    60   ~ 0
1V8
$Comp
L CONN_01X01 TP28
U 1 1 5755670D
P 21500 2550
F 0 "TP28" H 21578 2588 50  0000 L CNN
F 1 "TESTPOINT" H 21578 2496 50  0000 L CNN
F 2 "azonenberg_pcb:TESTPOINT_SMT_KEYSTONE_5016" H 21500 2550 60  0001 C CNN
F 3 "" H 21500 2550 60  0000 C CNN
	1    21500 2550
	1    0    0    -1  
$EndComp
Text Label 21050 2550 2    60   ~ 0
2V5
$Comp
L CONN_01X01 TP29
U 1 1 575569AA
P 21500 2850
F 0 "TP29" H 21578 2888 50  0000 L CNN
F 1 "TESTPOINT" H 21578 2796 50  0000 L CNN
F 2 "azonenberg_pcb:TESTPOINT_SMT_KEYSTONE_5016" H 21500 2850 60  0001 C CNN
F 3 "" H 21500 2850 60  0000 C CNN
	1    21500 2850
	1    0    0    -1  
$EndComp
Text Label 21050 2850 2    60   ~ 0
3V3
$Comp
L CONN_01X01 TP30
U 1 1 57557165
P 21500 3150
F 0 "TP30" H 21578 3188 50  0000 L CNN
F 1 "TESTPOINT" H 21578 3096 50  0000 L CNN
F 2 "azonenberg_pcb:TESTPOINT_SMT_KEYSTONE_5016" H 21500 3150 60  0001 C CNN
F 3 "" H 21500 3150 60  0000 C CNN
	1    21500 3150
	1    0    0    -1  
$EndComp
Text Label 21050 3150 2    60   ~ 0
DUT_VPP_RAW
$Comp
L CONN_01X01 TP31
U 1 1 57557CCF
P 21500 3450
F 0 "TP31" H 21578 3488 50  0000 L CNN
F 1 "TESTPOINT" H 21578 3396 50  0000 L CNN
F 2 "azonenberg_pcb:TESTPOINT_SMT_KEYSTONE_5016" H 21500 3450 60  0001 C CNN
F 3 "" H 21500 3450 60  0000 C CNN
	1    21500 3450
	1    0    0    -1  
$EndComp
Text Label 21050 3450 2    60   ~ 0
PSU_PGOOD
$Comp
L CONN_01X01 TP32
U 1 1 57558505
P 21500 3750
F 0 "TP32" H 21578 3788 50  0000 L CNN
F 1 "TESTPOINT" H 21578 3696 50  0000 L CNN
F 2 "azonenberg_pcb:TESTPOINT_SMT_KEYSTONE_5016" H 21500 3750 60  0001 C CNN
F 3 "" H 21500 3750 60  0000 C CNN
	1    21500 3750
	1    0    0    -1  
$EndComp
Text Label 21050 3750 2    60   ~ 0
PSU_VTEMP
$Comp
L FUSE F1
U 1 1 5764BE84
P 2550 15100
F 0 "F1" H 2550 15341 50  0000 C CNN
F 1 "2A fast" H 2550 15249 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" H 2550 15100 60  0001 C CNN
F 3 "" H 2550 15100 60  0000 C CNN
	1    2550 15100
	1    0    0    -1  
$EndComp
$Comp
L Q_PMOS_GSD Q22
U 1 1 5764DB2D
P 3200 15200
F 0 "Q22" V 3200 15000 50  0000 C CNN
F 1 "DMP2069UFY4" V 3100 14800 50  0000 C CNN
F 2 "azonenberg_pcb:DFN_3_DIODES_X2DFN2015-3" H 3400 15300 29  0001 C CNN
F 3 "" H 3200 15200 60  0000 C CNN
	1    3200 15200
	0    -1   -1   0   
$EndComp
Text Label 2950 14950 0    60   ~ 0
5V0_FUSED
Text Label 3050 15400 2    60   ~ 0
GND
Text Label 3550 14950 0    60   ~ 0
5V0_RPROT
$Comp
L LED D39
U 1 1 576523BE
P 4400 15750
F 0 "D39" V 4446 15642 50  0000 R CNN
F 1 "GREEN" V 4354 15642 50  0000 R CNN
F 2 "azonenberg_pcb:EIA_0603_LED" H 4400 15750 60  0001 C CNN
F 3 "" H 4400 15750 60  0000 C CNN
	1    4400 15750
	0    -1   -1   0   
$EndComp
$Comp
L R R177
U 1 1 57652BD8
P 4400 15350
F 0 "R177" H 4470 15396 50  0000 L CNN
F 1 "470" H 4470 15304 50  0000 L CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 4330 15350 30  0001 C CNN
F 3 "" H 4400 15350 30  0000 C CNN
	1    4400 15350
	1    0    0    -1  
$EndComp
Text Label 4200 15950 2    60   ~ 0
GND
Wire Wire Line
	1650 15100 2300 15100
Wire Wire Line
	1850 15200 1650 15200
Wire Wire Line
	900  1650 1900 1650
Wire Wire Line
	900  2050 1900 2050
Wire Wire Line
	3200 1750 4350 1750
Wire Wire Line
	3700 1850 3200 1850
Wire Wire Line
	3700 1950 3200 1950
Wire Wire Line
	3700 1650 3200 1650
Wire Wire Line
	3700 2050 3200 2050
Connection ~ 4050 1750
Wire Wire Line
	3550 3800 3200 3800
Wire Wire Line
	3300 3800 3300 6750
Wire Wire Line
	3300 3900 3200 3900
Connection ~ 3300 3800
Wire Wire Line
	3300 4750 3200 4750
Connection ~ 3300 3900
Wire Wire Line
	3300 5600 3200 5600
Connection ~ 3300 4750
Wire Wire Line
	3300 6450 3200 6450
Connection ~ 3300 5600
Wire Wire Line
	3200 4550 3200 4650
Wire Wire Line
	3200 5400 3200 5500
Wire Wire Line
	3200 6250 3200 6350
Wire Wire Line
	3200 5050 3300 5050
Connection ~ 3300 5050
Wire Wire Line
	3200 5900 3300 5900
Connection ~ 3300 5900
Wire Wire Line
	3300 6750 3200 6750
Connection ~ 3300 6450
Wire Wire Line
	3200 4100 3900 4100
Wire Wire Line
	3400 4100 3400 6650
Wire Wire Line
	3400 4950 3200 4950
Wire Wire Line
	3400 5800 3200 5800
Connection ~ 3400 4950
Wire Wire Line
	3400 6650 3200 6650
Connection ~ 3400 5800
Wire Wire Line
	3500 4200 3200 4200
Connection ~ 3400 4100
Wire Wire Line
	4500 4100 5250 4100
Connection ~ 4700 4100
Wire Wire Line
	4600 4400 4700 4400
Wire Wire Line
	3500 4200 3500 4750
Wire Wire Line
	3500 4750 3950 4750
Wire Wire Line
	3900 4750 3900 4900
Wire Wire Line
	3900 4900 3950 4900
Connection ~ 3900 4750
Wire Wire Line
	4500 4900 4250 4900
Wire Wire Line
	5150 4100 5150 4750
Wire Wire Line
	5150 4750 5000 4750
Connection ~ 5150 4100
Wire Wire Line
	4700 4750 4250 4750
Wire Wire Line
	4450 4650 4450 4750
Connection ~ 4450 4750
Wire Wire Line
	5150 15400 8400 15400
Wire Wire Line
	5150 15100 8400 15100
Connection ~ 5250 15100
Connection ~ 5700 15100
Connection ~ 6150 15100
Connection ~ 6600 15100
Connection ~ 7050 15100
Connection ~ 7500 15100
Connection ~ 7950 15100
Connection ~ 7950 15400
Connection ~ 7500 15400
Connection ~ 7050 15400
Connection ~ 6600 15400
Connection ~ 6150 15400
Connection ~ 5250 15400
Connection ~ 5700 15400
Wire Wire Line
	3350 7300 3200 7300
Wire Wire Line
	3200 7400 3300 7400
Wire Wire Line
	3300 7400 3300 7300
Connection ~ 3300 7300
Wire Wire Line
	3200 7600 3650 7600
Wire Wire Line
	3700 7700 4250 7700
Wire Wire Line
	4250 7700 4250 7600
Wire Wire Line
	4250 7600 4550 7600
Wire Wire Line
	3950 7800 3700 7800
Wire Wire Line
	3200 7700 3400 7700
Wire Wire Line
	3350 7700 3350 7900
Connection ~ 3350 7700
Wire Wire Line
	3400 7800 3350 7800
Connection ~ 3350 7800
Wire Wire Line
	4200 15100 4450 15100
Wire Wire Line
	3350 8250 3200 8250
Wire Wire Line
	3200 8350 3300 8350
Wire Wire Line
	3300 8350 3300 8250
Connection ~ 3300 8250
Wire Wire Line
	3200 8550 3650 8550
Wire Wire Line
	3700 8650 4250 8650
Wire Wire Line
	4250 8650 4250 8550
Wire Wire Line
	4250 8550 4550 8550
Wire Wire Line
	3950 8750 3700 8750
Wire Wire Line
	3200 8650 3400 8650
Wire Wire Line
	3350 8650 3350 8850
Connection ~ 3350 8650
Wire Wire Line
	3400 8750 3350 8750
Connection ~ 3350 8750
Connection ~ 4450 7600
Connection ~ 4450 8550
Wire Wire Line
	4450 7900 3950 7900
Wire Wire Line
	3950 7900 3950 7800
Wire Wire Line
	4450 8850 3950 8850
Wire Wire Line
	3950 8850 3950 8750
Wire Wire Line
	3350 9200 3200 9200
Wire Wire Line
	3200 9300 3300 9300
Wire Wire Line
	3300 9300 3300 9200
Connection ~ 3300 9200
Wire Wire Line
	3200 9500 3650 9500
Wire Wire Line
	3700 9600 4250 9600
Wire Wire Line
	4250 9600 4250 9500
Wire Wire Line
	4250 9500 4550 9500
Wire Wire Line
	3950 9700 3700 9700
Wire Wire Line
	3200 9600 3400 9600
Wire Wire Line
	3350 9600 3350 9800
Connection ~ 3350 9600
Wire Wire Line
	3400 9700 3350 9700
Connection ~ 3350 9700
Connection ~ 4450 9500
Wire Wire Line
	4450 9800 3950 9800
Wire Wire Line
	3950 9800 3950 9700
Wire Wire Line
	3350 10150 3200 10150
Wire Wire Line
	3200 10250 3300 10250
Wire Wire Line
	3300 10250 3300 10150
Connection ~ 3300 10150
Wire Wire Line
	3200 10450 3650 10450
Wire Wire Line
	3700 10550 4250 10550
Wire Wire Line
	4250 10550 4250 10450
Wire Wire Line
	4250 10450 4550 10450
Wire Wire Line
	3950 10650 3700 10650
Wire Wire Line
	3200 10550 3400 10550
Wire Wire Line
	3350 10550 3350 10750
Connection ~ 3350 10550
Wire Wire Line
	3400 10650 3350 10650
Connection ~ 3350 10650
Connection ~ 4450 10450
Wire Wire Line
	4450 10750 3950 10750
Wire Wire Line
	3950 10750 3950 10650
Wire Wire Line
	7550 4550 7650 4550
Connection ~ 7550 4450
Wire Wire Line
	7450 4250 7650 4250
Wire Wire Line
	7650 4350 7550 4350
Wire Wire Line
	7550 4350 7550 4550
Connection ~ 7250 4750
Connection ~ 7250 4450
Wire Wire Line
	7100 4450 7650 4450
Wire Wire Line
	7100 4750 7650 4750
Wire Wire Line
	7550 4250 7550 4000
Wire Wire Line
	7550 4000 7850 4000
Connection ~ 7550 4250
Wire Wire Line
	8450 4000 8750 4000
Wire Wire Line
	8700 4000 8700 4250
Connection ~ 8700 4000
Wire Wire Line
	8700 4350 9050 4350
Wire Wire Line
	9050 4350 9050 4000
Wire Wire Line
	9050 4000 12600 4000
Wire Wire Line
	8700 4450 9200 4450
Wire Wire Line
	9200 4450 9200 4300
Wire Wire Line
	9050 4750 9650 4750
Connection ~ 9200 4000
Wire Wire Line
	9650 4300 9650 4000
Connection ~ 9650 4000
Wire Wire Line
	9650 4750 9650 4600
Connection ~ 9200 4750
Wire Wire Line
	7000 7550 7500 7550
Wire Wire Line
	7000 7850 7500 7850
Wire Wire Line
	7500 7750 7400 7750
Wire Wire Line
	7400 7750 7400 7850
Connection ~ 7400 7850
Connection ~ 7200 7850
Connection ~ 7200 7550
Wire Wire Line
	8500 7550 9400 7550
Wire Wire Line
	8550 7850 8700 7850
Wire Wire Line
	7200 8050 7500 8050
Wire Wire Line
	7000 9050 7500 9050
Wire Wire Line
	7000 9350 7500 9350
Wire Wire Line
	7500 9250 7400 9250
Wire Wire Line
	7400 9250 7400 9350
Connection ~ 7400 9350
Connection ~ 7200 9350
Connection ~ 7200 9050
Wire Wire Line
	9300 9050 8500 9050
Wire Wire Line
	8550 9350 8700 9350
Wire Wire Line
	7200 9550 7500 9550
Wire Wire Line
	7000 8300 7500 8300
Wire Wire Line
	7000 8600 7500 8600
Wire Wire Line
	7500 8500 7400 8500
Wire Wire Line
	7400 8500 7400 8600
Connection ~ 7400 8600
Connection ~ 7200 8600
Connection ~ 7200 8300
Wire Wire Line
	8500 8300 9300 8300
Wire Wire Line
	8550 8600 8700 8600
Wire Wire Line
	7200 8800 7500 8800
Connection ~ 8700 7550
Connection ~ 9300 7550
Connection ~ 8700 8300
Connection ~ 9300 8300
Connection ~ 8700 9050
Wire Wire Line
	12100 7550 12600 7550
Wire Wire Line
	12100 7850 12600 7850
Wire Wire Line
	12600 7750 12500 7750
Wire Wire Line
	12500 7750 12500 7850
Connection ~ 12500 7850
Connection ~ 12300 7850
Connection ~ 12300 7550
Wire Wire Line
	13600 7550 14500 7550
Wire Wire Line
	13650 7850 13800 7850
Wire Wire Line
	12300 8050 12600 8050
Wire Wire Line
	12100 9050 12600 9050
Wire Wire Line
	12100 9350 12600 9350
Wire Wire Line
	12600 9250 12500 9250
Wire Wire Line
	12500 9250 12500 9350
Connection ~ 12500 9350
Connection ~ 12300 9350
Connection ~ 12300 9050
Wire Wire Line
	14400 9050 13600 9050
Wire Wire Line
	13650 9350 13800 9350
Wire Wire Line
	12300 9550 12600 9550
Wire Wire Line
	12100 8300 12600 8300
Wire Wire Line
	12100 8600 12600 8600
Wire Wire Line
	12600 8500 12500 8500
Wire Wire Line
	12500 8500 12500 8600
Connection ~ 12500 8600
Connection ~ 12300 8600
Connection ~ 12300 8300
Wire Wire Line
	13600 8300 14400 8300
Wire Wire Line
	13650 8600 13800 8600
Wire Wire Line
	12300 8800 12600 8800
Connection ~ 13800 7550
Connection ~ 14400 7550
Connection ~ 13800 8300
Connection ~ 14400 8300
Connection ~ 13800 9050
Wire Wire Line
	11450 4300 11450 4400
Wire Wire Line
	11250 4350 12050 4350
Connection ~ 11450 4350
Wire Wire Line
	12350 4000 12350 4150
Connection ~ 11450 4000
Wire Wire Line
	12350 4550 13550 4550
Wire Wire Line
	9300 9050 9300 8800
Wire Wire Line
	9300 8050 9300 8500
Wire Wire Line
	9300 7750 9300 7550
Wire Wire Line
	9300 7550 9250 7550
Connection ~ 9250 7550
Wire Wire Line
	14400 9050 14400 8800
Wire Wire Line
	14400 8050 14400 8500
Wire Wire Line
	14400 7550 14400 7750
Connection ~ 1600 1650
Connection ~ 1050 1650
Wire Wire Line
	1050 1950 1050 2050
Connection ~ 1050 2050
Wire Wire Line
	1600 1950 1600 2050
Connection ~ 1600 2050
Connection ~ 12350 4000
Wire Wire Line
	21300 1350 21050 1350
Wire Wire Line
	21300 1650 21050 1650
Wire Wire Line
	21300 1950 21050 1950
Wire Wire Line
	21300 2250 21050 2250
Wire Wire Line
	21300 2550 21050 2550
Wire Wire Line
	21300 2850 21050 2850
Wire Wire Line
	21300 3150 21050 3150
Wire Wire Line
	21300 3450 21050 3450
Wire Wire Line
	21300 3750 21050 3750
Wire Wire Line
	11150 4800 11450 4800
Wire Wire Line
	10750 4600 11150 4600
Wire Wire Line
	2800 15100 3000 15100
Wire Wire Line
	2950 14950 2950 15100
Connection ~ 2950 15100
Wire Wire Line
	3050 15400 3200 15400
Wire Wire Line
	3600 15100 3400 15100
Wire Wire Line
	3550 14950 3550 15100
Connection ~ 3550 15100
Wire Wire Line
	4400 15100 4400 15200
Connection ~ 4400 15100
Wire Wire Line
	4400 15500 4400 15550
Wire Wire Line
	4200 15950 4400 15950
Wire Wire Line
	13850 4550 14250 4550
Text Notes 13600 4400 0    60   ~ 0
1 mA = 100 uV\nWith gain of 100, 10 mV out per mA\n\nFull scale = 1.0V, 0.976 mV/LSB\nFull scale = 100 mA so 97 uA / LSB
$Comp
L R R179
U 1 1 57690956
P 13700 4550
F 0 "R179" V 13650 4750 50  0000 C CNN
F 1 "0.1" V 13700 4550 50  0000 C CNN
F 2 "azonenberg_pcb:EIA_0402_RES_NOSILK" V 13630 4550 30  0001 C CNN
F 3 "" H 13700 4550 30  0000 C CNN
	1    13700 4550
	0    1    1    0   
$EndComp
Text HLabel 13500 4800 0    60   Output ~ 0
VPP_SHUNT_HI
Text HLabel 14000 4800 2    60   Output ~ 0
VPP_SHUNT_LO
Wire Wire Line
	14000 4800 14000 4550
Connection ~ 14000 4550
Wire Wire Line
	13500 4800 13500 4550
Connection ~ 13500 4550
$EndSCHEMATC
