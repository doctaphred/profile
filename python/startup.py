"""
This file is meant to be executed on REPL startup.

See https://docs.python.org/3/using/cmdline.html#envvar-PYTHONSTARTUP
"""
from datetime import datetime as dt
start = dt.now()

from collections import *
from contextlib import *
from functools import *
from itertools import *
from math import *  # Includes nan
from operator import *
from traceback import *
from urllib import *
from urllib.parse import *

import array
import ast
import bisect
import collections
import contextlib
import copy
import csv
import decimal
import difflib
import functools
import fractions
import glob
import hashlib
import heapq
import inspect
import importlib
import io
import itertools
import json
import logging
import operator
import os
import pdb
import pickle
import random
import re
import shutil
import string
import sys
import time
import timeit
import traceback
import traceback as tb
import unicodedata
import urllib
import urllib.parse
import weakref
import zipfile
from datetime import datetime, timedelta
from dis import dis
from os import path
from pprint import pprint
from zipfile import ZipFile

try:
    import abc
    import builtins
    import enum
    import statistics
except ImportError:
    pass

try:
    from pathlib import Path
except ImportError:
    pass

try:
    import numpy as np
except ImportError:
    pass

try:
    import pandas as pd
except ImportError:
    pass
else:
    DF = pd.DataFrame

try:
    import pp
except ImportError:
    pp = pprint

try:
    import yaml
except ImportError:
    pass

try:
    import dataset
except ImportError:
    pass

try:
    import requests
except ImportError:
    pass

try:
    from tqdm import tqdm
except ImportError:
    pass

try:
    from django.conf import settings
except ImportError:
    pass


finish = dt.now()

print("Imports took {}".format(finish - start))


# Path to executable
# e.g.: /usr/local/opt/python3/bin/python3.7
print(sys.executable)
