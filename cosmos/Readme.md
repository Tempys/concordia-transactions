==========================================
Main commands
==========================================
delegate
celestia-appd tx staking delegate celesvaloper1dj6anwwhw0r046676zpwl0u7q9dqzm99pdttxv 1000000celes --from=my_wallet --chain-id=devnet-2

unjail
dewebd tx slashing unjail  --fees 200udws --chain-id deweb-testnet-0 --from my_wallet




CELETIA
celesvaloper173evmj8dkx3mmakj8sgru0zzdx48yczyqeaxuz

delegate
celestia-appd tx staking delegate celesvaloper173evmj8dkx3mmakj8sgru0zzdx48yczyqeaxuz 1100000celes --from=my_wallet --chain-id=devnet-2


get balance
 celestia-appd q bank balances celes173evmj8dkx3mmakj8sgru0zzdx48yczy95jyt2 --keyring-backend=test
 celestia-appd q bank balances celes1p35tdf949qfjfpr3f9z4fse34kt2zt3lafydrm --keyring-backend=test

get address
 celestia-appd keys show my_wallet --bech val --keyring-backend=test


create validator

MONIKER="md_moniker"
node_name = "my_wallet"

celestia-appd tx staking create-validator \
 --amount=1000000celes \
 --pubkey=$(celestia-appd tendermint show-validator) \
 --moniker=$MONIKER \
 --chain-id=devnet-2 \
 --commission-rate=0.1 \
 --commission-max-rate=0.2 \
 --commission-max-change-rate=0.01 \
 --min-self-delegation=1000000 \
 --from=$node_name \
 --keyring-backend=test



celestia-appd q staking validators -o json --limit=1000 | jq '.validators[] | select(.status=="BOND_STATUS_BONDED")' | jq -r '.tokens + " - " + .description.moniker + " - " + .operator_address' | sort -gr | nl | grep md_moniker

create key
celestia-appd keys add tt3 --keyring-backend=test

send from 1 to other
celestia-appd tx bank send celes1lquu229mlnk9ypte85uqw3s7jj9w6kutdf0z27 celes173evmj8dkx3mmakj8sgru0zzdx48yczy95jyt2 1100000celes --chain-id=devnet-2 --keyring-backend test


evmosd keys add <wallet> --recover 



 Synced the node on a new server (while keeping the current one running)
 Stopped both nodes
 Restored the wallet on new server with evmosd keys add <wallet> --recover 
 Copied priv_validator_key.json from old node to new node  .evmosd/config/priv_validator_key.json
 Started new node
 
withdrow all rewards
======================


celestia-appd  query distribution rewards celes173evmj8dkx3mmakj8sgru0zzdx48yczy95jyt2 --chain-id=devnet-2
celestia-appd  tx distribution withdraw-all-rewards --from="my_wallet" --chain-id=evmos_9000-4


evmosd add-genesis-account $(evmosd keys show my_wallet -a) 5300353356890460000aevmos

evmosd gentx my_wallet 5300353356890460000aevmos \
  --chain-id=evmos_9001-1 \
  --moniker=md_moniker \
  --details="" \
  --commission-rate=0.05 \
  --commission-max-rate=0.2 \
  --commission-max-change-rate=0.01 \
  --gas-adjustment=1.5 \
  --pubkey $(evmosd tendermint show-validator) 



tx staking delegate celesvaloper173evmj8dkx3mmakj8sgru0zzdx48yczyqeaxuz 1100000celes --from=my_wallet --chain-id=devnet-2
evmosd tx slashing unjail  --gas=auto --chain-id evmos_9000-4 --from my_wallet
evmosd tx staking delegate evmosvaloper144p4mlj9ju8rencusw2835cjmu9yf2v86mc6h8 999999999999258atevmos --gas=auto --gas-adjustment=1.5   --from my_wallet --chain-id=evmos_9000-4


evmosd tx gov vote 14 yes --from my_wallet --chain-id evmos_9000-4