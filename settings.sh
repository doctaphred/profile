prohibit-subshells

# Better history management, from http://unix.stackexchange.com/a/48113/134011
HISTCONTROL=ignoreboth:erasedups  # Erase duplicates when writing the history file
HISTSIZE=100000000000  # Size of history in memory
HISTFILESIZE=100000000000  # Size of history file
shopt -s histappend  # Append to history, don't overwrite it

HISTTIMEFORMAT="%F %T "


editor () {
    if exists code; then
        echo 'code'
    elif exists subl; then
        echo 'subl --new-window'
    elif exists rmate; then
        echo 'rmate'
    else
        echo 'nano'  # Don't @ me.
    fi
}

edit () {
    $(editor) "$@"
}
alias e=edit

export EDITOR="vim"
export VISUAL="$(editor)"

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

# TODO:
#
# --quit-if-one-screen \
# --no-init \
#
# The second disables mouse scrolling.
# The first without the second outputs nothing if the file fits on one page.
# TODO: use `most`?

# TODO: Use XDG config? (Does enough stuff actually support it?)
# # https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# export XDG_CONFIG_HOME="$HOME/.config"
# export XDG_CACHE_HOME=
