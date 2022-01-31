#!/bin/bash

cd $HOME
wget https://github.com/deweb-services/deweb/releases/download/v1.0/dewebd
chmod +x dewebd
sudo mv dewebd /usr/local/bin/

dewebd config chain-id deweb-testnet-0
dewebd init md_moniker --chain-id deweb-testnet-0

cd $HOME
curl -s https://raw.githubusercontent.com/deweb-services/deweb/main/genesis.json > ~/.deweb/config/genesis.json

sed -E -i 's/seeds = \".*\"/seeds = \"31e5b459d7a3e5a94c71416e836899e5fa3b0050@seed1.deweb.services:26656,bdaba548379ab5103a1236f55ba82710d1d0024c@seed2.deweb.services:26656,2e354bbfdd7ed425827f73b537d41c57a9b43a02@185.216.203.24:26656,ee8a9199c862027036eec013ba058015783d4da2@161.97.111.217:26656,e620e369f38efd67b602c8d7f65fe65465460a86@37.201.192.255:26656,15bac261f435ca71aade5b6795318c6cdb33b4c0@195.90.211.18:26656,ca95fb9853e2f08dc8cf7d5b43e4746de7fd462c@65.21.132.226:26656\"/' $HOME/.deweb/config/config.toml

sed -E -i 's/minimum-gas-prices = \".*\"/minimum-gas-prices = \"0.001udws\"/' $HOME/.deweb/config/app.toml

cd $HOME
echo "[Unit]
    Description=DWS Node
    After=network-online.target
    [Service]
    User=${USER}
    ExecStart=$(which dewebd) start
    Restart=always
    RestartSec=3
    LimitNOFILE=4096
    [Install]
    WantedBy=multi-user.target
    " >dewebd.service

sudo mv dewebd.service /lib/systemd/system/
sudo systemctl enable dewebd.service && sudo systemctl start dewebd.service