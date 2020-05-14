# Shell options.

# See http://tldp.org/LDP/abs/html/options.html
# See https://sipb.mit.edu/doc/safe-shell/

prohibit-subshells

# Abort at first error, when a command exits with non-zero status.
# set -e

# Treat undefined variables as an error.
# set -u

# Treat globs that don't get expanded as an error.
# shopt -s failglob

# Cause a pipeline to produce a failure return code if any command errors.
set -o pipefail

# Stop accidentally closing shells with ctrl+d
set -o ignoreeof

# Disable caching, 'cause it sucks
# https://twitter.com/doctaphred/status/721423180414480384
set +h

# cd by typing a directory's name
shopt -s autocd
