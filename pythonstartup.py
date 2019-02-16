"""
This file is meant to be executed on REPL startup.

See https://docs.python.org/3/using/cmdline.html#envvar-PYTHONSTARTUP
"""
from __future__ import absolute_import, print_function

from datetime import datetime as dt
start = dt.now()

from collections import *
from contextlib import *
from functools import *
from itertools import *
from traceback import *

import collections
import contextlib
import functools
import itertools
import json
import os
import random
import re
import sys
import time
import traceback
import traceback as tb
from datetime import datetime, timedelta
from pprint import pprint

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
    from django.conf import settings
except ImportError:
    pass


finish = dt.now()

print("Imports took ", finish - start)

# Path to executable
# e.g.: /usr/local/opt/python3/bin/python3.7
print(sys.executable)
