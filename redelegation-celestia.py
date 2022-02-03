
import time
import pexpect
import schedule
import sys


def main(addr, wallet, project_command, password, denom,validator_addr):
   # addr = 'evmos144p4mlj9ju8rencusw2835cjmu9yf2v8h4h2k6'
   #  wallet = 'my_wallet'
    balance =f'{project_command} q bank balances {addr}'.format(project_command= project_command, addr= addr)
    print(balance)

    # child = pexpect.spawn(balance , encoding='utf-8')
    # balance = child.read()
    # sum = parceBalance(balance)
    # # child.logfile = open("/tmp/mylog", "w")
    # delegateCommand = generateDelegateCommand(sum,wallet,project_command,validator_addr,denom)
    # print("send "+delegateCommand)
    # child = pexpect.spawn( delegateCommand)
    # child.logfile = sys.stdout.buffer
    # child.expect([pexpect.TIMEOUT, "Enter keyring passphrase:"], timeout=900)
    # child.sendline(password)
    #
    # child.expect([pexpect.TIMEOUT, ""], timeout=900)
    # child.sendline("y")
    # child.logfile = sys.stdout.buffer
    # child.expect(pexpect.EOF)
    # child.close()

    # child.expect(pexpect.EOF, timeout=600)
    print('finish delegation')



def parceBalance(text):
    sum =text.split('"')[1]
    return sum


def generateDelegateCommand(sum,walet,project_name,validator_addr,denom):
    command = f'{ project_name } tx staking delegate {validator_addr} {sum}{denom} --gas auto  --from {walet} '.format(project_name =project_name,validator_addr= validator_addr,denom=denom,sum= sum,walet= walet)
    print(command)
    return command


if __name__ == '__main__':
    addr = 'celes173evmj8dkx3mmakj8sgru0zzdx48yczy95jyt2'
    wallet = '' \
             ''
    project_command = 'celestia-appd'
    password = "Misha1987+"
    denom = "celes"
    validator_addr = 'celesvaloper173evmj8dkx3mmakj8sgru0zzdx48yczyqeaxuz'

    main(addr,wallet, project_command,password,denom,validator_addr)
    schedule.every().minute.do(main)
    while True:
        schedule.run_pending()
        time.sleep(1)
