#!/bin/sh

rustup toolchain install nightly
rustup default nightly
rustup target add wasm32-unknown-unknown
cargo install leptos

