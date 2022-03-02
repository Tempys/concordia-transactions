#!/bin/bash




cd $HOME
echo "[Unit]
    Description=Evmos Node
    After=network-online.target
    [Service]
    User=${USER}
    ExecStart=$(which evmosd) start
    Restart=always
    RestartSec=3
    LimitNOFILE=4096
    [Install]
    WantedBy=multi-user.target
    " >evmosd.service

sudo mv evmosd.service /lib/systemd/system/
sudo systemctl enable evmosd.service && sudo systemctl start evmosd.service