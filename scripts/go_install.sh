#!/bin/bash


sudo apt-get update
# First remove any existing old Go installation
sudo rm -rf /usr/local/go

# Install correct Go version

curl https://dl.google.com/go/go1.17.2.linux-amd64.tar.gz | sudo tar -C /usr/local -zxvf -

# Update environment variables to include go
cat <<'EOF' >>$HOME/.profile
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
EOF

source $HOME/.profile
go version
go version go1.17.2 linux/amd64

