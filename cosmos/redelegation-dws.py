
import time
import pexpect
import schedule
import sys


def main(addr, wallet, project_command, password, denom,validator_addr):
   # addr = 'evmos144p4mlj9ju8rencusw2835cjmu9yf2v8h4h2k6'
   #  wallet = 'my_wallet'

    child = pexpect.spawn( f'{project_command} q bank balances {addr}'.format(project_command= project_command, addr= addr), encoding='utf-8')
    balance = child.read()
    sum = parceBalance(balance)
    # child.logfile = open("/tmp/mylog", "w")
    delegateCommand = generateDelegateCommand(sum,wallet,project_command,validator_addr,denom)
    print("send "+delegateCommand)
    child = pexpect.spawn( delegateCommand)
    child.logfile = sys.stdout.buffer
    child.expect([pexpect.TIMEOUT, "Enter keyring passphrase:"], timeout=900)
    child.sendline(password)

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


def generateDelegateCommand(sum,walet,project_name,validator_addr,denom):
    return f' { project_name } tx staking delegate {validator_addr} {sum} {denom} --gas auto  --from {walet} '.format(project_name =project_name,validator_addr= validator_addr,denom=denom,sum= sum,walet= walet)


if __name__ == '__main__':
    addr = 'deweb1deq0tdlv0rtt6e7646auzsul5mrn3dn07q2gdd'
    wallet = 'my_wallet'
    project_command = 'dewebd'
    password = "Misha1987+"
    denom = "udws"
    validator_addr = 'dewebvaloper1deq0tdlv0rtt6e7646auzsul5mrn3dn0d9m40w'

    main(addr,wallet, project_command,password,denom,validator_addr)
    schedule.every().minute.do(main)
    while True:
        schedule.run_pending()
        time.sleep(1)
