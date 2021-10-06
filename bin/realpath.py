#!/usr/bin/env python3
from os.path import realpath
from sys import argv


name, *args = argv

if not args:
    raise SystemExit(f"{name}: missing operand")

if any(arg.startswith('-') for arg in args):
    raise SystemExit(f"{name}: args not supported")

for arg in args:
    print(realpath(arg))
