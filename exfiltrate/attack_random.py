import urllib.request
import ssl
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
    
    while(1):
        ssl._create_default_https_context = ssl._create_unverified_context
        r = urllib.request.urlopen('https://myproject.local/')
        print(r.read())
        print(r.status)
        t = random.randint(args.lower,args.upper)
        print(t)
        time.sleep(t)

if __name__ == '__main__':
    main()