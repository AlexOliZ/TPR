import urllib.request
import ssl
import time
import random
import argparse

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('-t', '--time', nargs='?',required=True, help='periodic sleep time (seconds)')
    args=parser.parse_args()
    while(1):
        ssl._create_default_https_context = ssl._create_unverified_context
        r = urllib.request.urlopen('https://myproject.local/')
        print(r.read())
        print(r.status)
        time.sleep(args.time)

if __name__ == '__main__':
    main()