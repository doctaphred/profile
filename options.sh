# See http://tldp.org/LDP/abs/html/options.html
# See https://sipb.mit.edu/doc/safe-shell/

# Abort at first error, when a command exits with non-zero status.
# set -e

# Treat undefined variables as an error.
# set -u

# Treat globs that don't get expanded as an error.
# shopt -s failglob

# Cause a pipeline to produce a failure return code if any command errors.
set -o pipefail

# Disable caching, 'cause it sucks
# https://twitter.com/doctaphred/status/721423180414480384
set +h

# cd by typing a directory's name
shopt -s autocd

# ls-after-cd, from http://pastebin.com/VBSQJyeA
PROMPT_COMMAND='[[ ${__new_wd:=$PWD} != $PWD ]] && ls; __new_wd=$PWD'

# Better history management, from http://unix.stackexchange.com/a/48113/134011
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export VISUAL='subl --new-window --wait'
# TODO: rmate if remote and available
export EDITOR="$VISUAL"

# Enable ls colors
export CLICOLOR=1
# Improve ls colors
export LSCOLORS=ExFxBxDxCxegedabagacad

export LESS="\
--chop-long-lines \
--HILITE-UNREAD \
--ignore-case \
--LONG-PROMPT \
--RAW-CONTROL-CHARS \
"
