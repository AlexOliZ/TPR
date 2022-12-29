import urllib.request
import ssl
import time
import random
import argparse

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('-t', '--time', nargs='?',required=True, help='periodic sleep time (seconds)')
    args=parser.parse_args()
    ssl._create_default_https_context = ssl._create_unverified_context
    while(1):
        r = urllib.request.urlopen('https://myproject.local/ok/')
        print(r.read())
        print(r.status)
        time.sleep(args.time)

if __name__ == '__main__':
    main()