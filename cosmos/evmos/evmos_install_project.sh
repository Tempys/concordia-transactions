#!/bin/bash

git clone https://github.com/tharsis/evmos
cd evmos && git checkout tags/v1.0.0-beta1
make install

evmosd init centry --chain-id=evmos_9001-1
