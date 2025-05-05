// rum-bridge.js
export function logWasmError(msg) {
  window.DD_RUM.addError(new Error("Wasm Error: " + msg));
}
