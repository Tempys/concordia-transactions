#!/usr/bin/env python3

import logging
import sys
import pexpect
import getpass
import time
from datetime import datetime
import schedule

count =0

def transaction(j):

    #password = getpass.getpass("181987")
    child = pexpect.spawn('/tmp/concordium-software/concordium-client --grpc-ip  127.0.0.01 --grpc-port 10000 transaction send-gtu-encrypted  --amount 0.0001 --sender 4BnxBUzU5VmAhuWFKKuvsS5v3vtmj6MzTkxssy1xWjWNWfdvCB --receiver 2ygGR8bngPdKAHBRcK8tpLRSdwhGRURbev8cdYfcWYTF9JsYAk  --no-confirm')
    i = child.expect([pexpect.TIMEOUT, "Enter password for signing key:"], timeout=10)
    if i == 0:
        print("Got unexpected output: %s %s" % (child.before, child.after))
        sys.exit()
    else:
        child.sendline("181987")
        log = child.read()
        print(log)
        global count
        count+=1
        a_logger.info(log)
        a_logger.info(count)


def job():
    for i in range(100):
        try:
          transaction(i)
          time.sleep(2)
        except Exception as e:
            time.sleep(10)
            transaction(i)


def hours_per_day():
    for hour in range(5):
        job()
        time.sleep(60*60)


logging.Formatter("%(asctime)s;%(levelname)s;%(message)s",
                              "%Y-%m-%d %H:%M:%S")
a_logger = logging.getLogger()

a_logger.setLevel(logging.INFO)
output_file_handler = logging.FileHandler("/tmp/concordium-software/output.log")
stdout_handler = logging.StreamHandler(sys.stdout)
a_logger.addHandler(output_file_handler)
a_logger.addHandler(stdout_handler)

hours_per_day()
