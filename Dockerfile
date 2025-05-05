# Stage 1: Build the Wasm module
FROM rust:1.86-slim AS builder

# Install wasm-pack
RUN cargo install wasm-pack

# Create app directory
WORKDIR /app

# Copy source code
COPY Cargo.toml .
COPY src ./src

# Build WebAssembly
RUN wasm-pack build --target web

# Stage 2: Serve using http-server
FROM node:23-alpine AS runner

# Install http-server
RUN npm install -g http-server

# Create working dir and copy build output
WORKDIR /app

# Copy static files and wasm output
COPY index.html .
COPY rum-bridge.js .
COPY --from=builder /app/pkg ./pkg

# Expose port and start server
EXPOSE 8080
CMD ["http-server", ".", "-p", "8080"]
