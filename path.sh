# $PATH modifications

prohibit-subshells

path () {
    echo "$PATH" | tr -s ":" "\n"
}

use () {
    # Add a directory to $PATH.
    # TODO: MANPATH?
    dir="$1"
    bindir="${2-bin}"
    PATH="$(realpath "$dir/$bindir"):$PATH"
}

unuse () {
    PATH="${PATH#*:}"
}

# Systemd shell executable directory
use ~/.local

# My personal executables (nonstandard locations)
use ~
use ~/profile
use ~/stuff
