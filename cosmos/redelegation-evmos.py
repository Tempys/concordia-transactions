
import time
import pexpect
import schedule
import sys


def main():
    # addr = 'evmos1kwt67ugl7u8kuhu50dtfzdkstckrayn9f8p322'
    # wallet = 'sev_wallet'
    addr = 'evmos144p4mlj9ju8rencusw2835cjmu9yf2v8h4h2k6'
    wallet = 'my_wallet'

    child = pexpect.spawn( f'evmosd q bank balances {addr}'.format(addr= addr), encoding='utf-8')
    balance = child.read()
    sum = parceBalance(balance)
    # child.logfile = open("/tmp/mylog", "w")
    delegateCommand = generateDelegateCommand(sum,wallet)
    print("send "+delegateCommand)
    child = pexpect.spawn( delegateCommand)
    child.logfile = sys.stdout.buffer
    child.expect([pexpect.TIMEOUT, "Enter keyring passphrase:"], timeout=900)
    child.sendline("Misha1987+")

    child.expect([pexpect.TIMEOUT, ""], timeout=900)
    child.sendline("y")
    child.logfile = sys.stdout.buffer
    child.expect(pexpect.EOF)
    child.close()

    # child.expect(pexpect.EOF, timeout=600)
    print('finish delegation')



def parceBalance(text):
    sum =text.split('"')[1]
    return sum


def generateDelegateCommand(sum,walet):
    return 'evmosd tx staking delegate evmosvaloper144p4mlj9ju8rencusw2835cjmu9yf2v86mc6h8 '+sum+f'aevmos --gas=auto --gas-adjustment=1.5 --gas-prices 0.001aevmos  --from {walet} '.format(walet= walet)


if __name__ == '__main__':

    main()
    schedule.every().minute.do(main)
    while True:
        schedule.run_pending()
        time.sleep(1)
