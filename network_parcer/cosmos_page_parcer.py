import requests
from bs4 import BeautifulSoup


def get_list():
    response = requests.get('https://backend.tendermint.com/apps')
    json_response = response.json()
    records = json_response["records"]
    for record in records:
       fields = record["fields"]
       try:
          print(fields["name"] +"."+ fields["status"])
       except Exception :
          print("ignore")


if __name__ == '__main__':

    get_list()