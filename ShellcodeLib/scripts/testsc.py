#!/usr/bin/python3
from pwn import *
from time import sleep
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("binpath", help="path to file containing shellcode")
parser.add_argument("-o", "--outpath", default="/dev/fd/1", help="path to dump output of shellcode to")
parser.add_argument("-t", "--time", default=3, help="time to wait before reading output")
args = parser.parse_args()

context.arch = 'amd64'

with open(args.binpath, "rb") as f:
    raw_shellcode = f.read()

p = run_shellcode(raw_shellcode)

sleep(args.time)

if args.outpath is not None:
    with open(args.outpath, "wb") as f:
        while p.can_read():
            try:
                f.write(p.read())
                sleep(1)
            except EOFError:
                break

