use std::io::Write;

fn main() {
    let out_dir = std::env::var("OUT_DIR").unwrap();
    let destination = std::path::Path::new(&out_dir).join("reftests.rs");
    let mut f = std::fs::File::create(&destination).unwrap();

    let files = std::fs::read_dir("../../tests/xc2bit/reftests").unwrap();

    for file in files {
        let path = file.expect("failed to get path").path();
        if path.extension().expect("bogus reftest filename (doesn't have extension)") == "jed" {
            let path = path.canonicalize().unwrap();

            let id_string = path.file_name().unwrap().to_str().unwrap().chars().map(|x| match x {
                'A'...'Z' | 'a'...'z' | '0'...'9' => x,
                _ => '_',
            }).collect::<String>();

            write!(f, r#"
                #[test]
                fn reftest_{}() {{
                    run_one_reftest("{}");
                }}
                "#, id_string, path.to_str().unwrap()).unwrap();
        }
    }
}
