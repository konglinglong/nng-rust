# Non-terminating errors fail the script immediately
$ErrorActionPreference = "Stop"

if ($IsMacOS) {
    $env:PATH += [IO.Path]::PathSeparator + "$env:HOME/.cargo/bin"
}

# Can remove this once https://github.com/jeikabu/nng-rust/issues/23 is merged to master
if ($env:imageName -like '*2019*') {
    cargo test --features cmake-vs2019  
} else {
    cargo fmt --all -- --check
    if ($IsWindows) {
        cargo test
    } elseif ($IsMacOS) {
        cargo test --features build-bindgen
        cargo build --features source-update-bindings
    } else {
        cargo test
    }
}