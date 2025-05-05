# Datadog RUM + Web Assembly

This is a minimal WebAssembly (Rust) + JavaScript application that demonstrates how to integrate **Datadog RUM (Real User Monitoring)** into a web app that uses **WebAssembly via `wasm-bindgen`**.

When the user clicks a button on the page, a Rust function is invoked via WebAssembly, which sends an error message to JavaScript. That message is logged to **Datadog RUM** as a custom error event.

## Running with Docker

Build the container:

```bash
docker build -t wasm-rum-app .
```

Run it:

```bash
docker run -p 8080:8080 wasm-rum-app
```

Then visit: [http://localhost:8080](http://localhost:8080)

## Running Locally

### Prerequisites

- [Rust](https://www.rust-lang.org/tools/install)
- [wasm-pack](https://rustwasm.github.io/wasm-pack/installer/)
- [Node.js](https://nodejs.org/) (optional, for `http-server`)

### 🛠️ Step 1: Build WebAssembly

```bash
wasm-pack build --target web
```

This generates a `pkg/` folder with `wasm_rum.js` and `wasm_rum_bg.wasm`.

### 🌐 Step 2: Serve Locally

#### Option A: Python HTTP Server

```bash
python3 -m http.server
```

#### Option B: Node.js HTTP Server

```bash
npx http-server .
```

Visit [http://localhost:8000](http://localhost:8000) or [http://localhost:8080](http://localhost:8080).

## How It Works

- `lib.rs` defines a Rust function that uses `wasm-bindgen` to call a JavaScript function (`logWasmError`).
- In `index.html`, that JS function uses `window.DD_RUM.addError(...)` to log an error to Datadog.
- When the user clicks the button:
  - Rust → calls JS → JS logs to RUM.
  - The button label changes briefly to confirm the action.

## Customizing for Your Project

- Replace `<APPLICATION_ID>` and `<CLIENT_TOKEN>` in `index.html` with your actual Datadog RUM credentials.
- To log more events or actions from Rust, expose additional JS functions via `wasm-bindgen`.

## Resources

- [Datadog RUM Docs](https://docs.datadoghq.com/real_user_monitoring/)
- [wasm-bindgen Guide](https://rustwasm.github.io/docs/wasm-bindgen/)
- [wasm-pack](https://rustwasm.github.io/wasm-pack/)

## Clean Up

To remove build artifacts:

```bash
rm -rf pkg
```
