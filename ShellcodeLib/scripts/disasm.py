#!/usr/bin/python3
from pwn import *
import argparse
parser = argparse.ArgumentParser()

parser.add_argument("path", help="path to bin to disassemble")
parser.add_argument("-a", "--arch", help="architecture", default="amd64")
args = parser.parse_args()
context.arch = args.arch

with open(args.path, "rb") as f:
    data = f.read()

print("data length: %d" % len(data))
print(disasm(data))
