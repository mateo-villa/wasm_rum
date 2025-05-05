use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = window)]
    fn logWasmError(msg: &str);
}

#[wasm_bindgen]
pub fn trigger_error() {
    logWasmError("This is a test error from Rust via Wasm!");
}
