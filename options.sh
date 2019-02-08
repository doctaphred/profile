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

# Stop accidentally closing shells with ctrl+d
set -o ignoreeof

# Disable caching, 'cause it sucks
# https://twitter.com/doctaphred/status/721423180414480384
set +h

# cd by typing a directory's name
shopt -s autocd

# ls-after-cd, inspired by http://pastebin.com/VBSQJyeA
# Insert into PROMPT_COMMAND
__prev_wd=$PWD
_ls_new_wd() {
    [[ $__prev_wd != $PWD ]] && ls
    __prev_wd=$PWD
}

PROMPT_COMMAND="_ls_new_wd; $PROMPT_COMMAND"

# Better history management, from http://unix.stackexchange.com/a/48113/134011
HISTCONTROL=ignoreboth:erasedups  # Erase duplicates when writing the history file
HISTSIZE=100000  # Size of history in memory
HISTFILESIZE=100000  # Size of history file
shopt -s histappend  # Append to history, don't overwrite it

HISTTIMEFORMAT="%F %T "

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -n; history -a; $PROMPT_COMMAND"

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
