import requests
#import ssl
import time
import random
import argparse

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('-l', '--lower', type=int, nargs='?',required=True, help='time lower limit (seconds)')
    parser.add_argument('-u', '--upper', type=int, nargs='?',required=True, help='time upper limit (seconds)')
    args=parser.parse_args()
    print(args.lower)
    print(args.upper)
    #ssl._create_default_https_context = ssl._create_unverified_context
    while(1):    
        numChars = random.randint(100,800000)
        r = requests.get("https://myproject.local/data/"+str(numChars),verify=False)
        print(r.status_code,r.content)
        print(r.content)
        print(r.status_code)
        print(numChars)
        t = random.randint(args.lower,args.upper)
        print(t)
        time.sleep(t)

if __name__ == '__main__':
    main()