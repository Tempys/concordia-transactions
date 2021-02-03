#!/bin/bash
receiver="2ygGR8bngPdKAHBRcK8tpLRSdwhGRURbev8cdYfcWYTF9JsYAk"
sender="4BnxBUzU5VmAhuWFKKuvsS5v3vtmj6MzTkxssy1xWjWNWfdvCB"
pass="181987\r\n"

for i in {1..1}
do
echo "RUN $i" > tx-out.log
set timeout -1
spawn  /tmp/concordium-software/concordium-client transaction send-gtu --sender "$sender" --receiver "$receiver" --amount 0.0001 --no-confirm
expect "Enter password for signing key:"
send -- $pass

done

cat tx-out.log | grep "Transaction is finalized into block" > blocks.log
cat tx-out.log | grep "Transaction '" > txs.log

