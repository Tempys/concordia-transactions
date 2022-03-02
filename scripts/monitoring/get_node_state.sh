#!/bin/bash


curl -s --data-binary '{"jsonrpc": "2.0", "id":"documentation", "method": "getnodestate", "params": [] }' -H 'content-type: application/json' http://localhost:3032/ | jq '.result.status';