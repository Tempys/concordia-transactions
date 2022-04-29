# stop
sudo systemctl stop evmosd

# rm
cd $HOME
rm -rf evmos
rm $(which evmosd)

# build
git clone https://github.com/tharsis/evmos
cd evmos
git checkout v3.0.0
make install
evmosd version

# config
peers="d8ac979da3dbe2f796e2344616096160dc5cfdc1@164.92.191.127:26656,d5d418256279900c3d1fbf2137ce7142d6f6c682@65.108.139.20:26656,1915b0217865b968646768e2761a8669d5e24bd5@65.108.44.149:26656,1a7bee67d6337d09380b824b952872bdc5dca86f@38.242.194.56:26656,b02259a11e4ee46b29668cfc957e530022a3fca1@62.171.142.145:26656,cc321917ce82b6c541c687420ad5ae0b4b5e055a@144.76.224.246:26656,6ab587b638fa58b638c882731e1a27f39207c528@34.220.177.42:30758,c130c7ec8f901f86fd5eca910ccb94ca008f6f2f@65.108.135.140:26656,8336788E5AE5DC5650F21734AD8093AFA376B84B@65.108.43.26:26656,7aa31684d201f8ebc0b1e832d90d7490345d77ee@52.10.99.253:26656,68463241c325da80baac51dc7ca342aed9c871bc@35.162.50.97:26656,906840c2f447915f3d0e37bc68221f5494f541db@3.39.58.32:26656,ae024b54cc16dd7f33e83550c150796b2cd7450b@95.214.55.43:26656,59fc2c53623cf8a2f4109af68371c25d822de3e6@157.90.169.110:22356,9ff4b21aaebd1235fb7bf4fbf31bf9b74f1af862@194.163.172.168:26656"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.evmosd/config/config.toml

# clear old seeds
seeds="40f4fac63da8b1ce8f850b0fa0f79b2699d2ce72@seed.evmos.jerrychong.com:26656"
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" $HOME/.evmosd/config/config.toml


# download genesis
cd $HOME
wget https://github.com/tharsis/mainnet/raw/main/evmos_9001-2/genesis.json.zip
unzip genesis.json.zip
mv genesis.json $HOME/.evmosd/config/

sha256sum $HOME/.evmosd/config/genesis.json
# 87e0e45b4f5278556af7cf31e6d856aa418dc883ffc7c80066a78b356c309dc6

EVMOS_CHAIN="evmos_9001-2"
evmosd config chain-id $EVMOS_CHAIN

# reset
evmosd tendermint unsafe-reset-all

# start
sudo systemctl start evmosd && journalctl -u evmosd -f -o cat