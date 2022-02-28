sudo apt-get update
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
cargo clean & cargo update
rustc --version