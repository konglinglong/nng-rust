# Non-terminating errors fail the script immediately
$ErrorActionPreference = "Stop"

if ($IsWindows) {
    cargo test
} elseif ($IsMacOS) {
    $env:PATH += [IO.Path]::PathSeparator + "$env:HOME/.cargo/bin"
    cargo test --features build-bindgen
    cargo build --features source-update-bindings
} else {
    cargo test
}