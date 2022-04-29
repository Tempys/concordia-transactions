#!/bin/bash

git clone https://github.com/tharsis/evmos
cd evmos && git checkout tags/v3.0.0-beta1
make install

evmosd init md_moniker --chain-id=evmos_9001-4

SEEDS=`curl -sL https://raw.githubusercontent.com/tharsis/testnets/main/evmos_9000-4/seeds.txt | awk '{print $1}' | paste -s -d, -`
sed -i.bak -e "s/^seeds =.*/seeds = \"$SEEDS\"/" ~/.evmosd/config/config.toml

PEERS=`curl -sL https://raw.githubusercontent.com/tharsis/testnets/main/evmos_9000-4/peers.txt | sort -R | head -n 10 | awk '{print $1}' | paste -s -d, -`
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" ~/.evmosd/config/config.toml


 wget https://archive.evmos.org/genesis/genesis_58699.zip
unzip genesis_58699.zip
mv genesis.json $HOME/.evmosd/config/
rm genesis_58699.zip


