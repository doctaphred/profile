prohibit-subshells


include() {
    # Source the file, if it exists
    test -f "$1" && source "$1"
}


include-all() {
    # Source all files in a directory
    # shopt -s nullglob
    for f in "$1"/*; do source "$f"; done
}


exists() {
    # Check if the command(s) exist(s)
    type $@ >/dev/null 2>&1
}


maybe() {
    # Execute the command, if it exists.
    exists "$1" && "$@"
}


take() {
    # mkdir, then cd into it. Surprisingly useful.
    mkdir -p $1
    cd $1
}

tktemp() {
    # Create a tempdir, then cd into it.
    name="${1:-temp}"
    now="$(date -u +%FT%TZ)"
    cd "$(mktemp -d "$name-$now-XXX")"
}


-() {
    # cd to previous directory
    cd -
}


# Make the `-` function work in a fresh shell.
# (This is usually what I want to do.)
OLDPWD=~


v() {
    # "View"
    less $@
}


vv() {
    # View the command's stdout and stderr in less.
    # Don't preprocess with pygmentize or other syntax highlighter,
    # since it will likely not work. (Also it's slow.)
    $@ 2>&1 | less --no-lessopen
}


lsd() {
    # List directories
    ls -F "$@" | grep \/$
}


mergeout() {
    # Run the command, merging stderr to stdout.
    # Also consider `|&` (pipe both stdout and stderr)
    # (bash only; not available in sh)
    "$@" 2>&1
}


background() {
    # Start a background process, ignoring stdout and stderr
    "$@" > /dev/null 2>&1 &
}


clean-shell() {
    # Open a subshell without inheriting env vars (-i),
    # and without sourcing .bashrc or .bash_profile.
    # Set TERM=xterm because programs like less complain if you don't.
    env -i TERM=xterm $SHELL --norc --noprofile
}
