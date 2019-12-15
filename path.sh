# $PATH modifications

prohibit-subshells

path () {
    echo "$PATH" | tr -s ":" "\n"
}

use () {
    PATH="$(realpath "$1"):$PATH"
}

unuse () {
    PATH="${PATH#*:}"
}

# Systemd shell executable directory
use ~/.local/bin

# My personal executables (nonstandard locations)
use ~/bin
use ~/profile/bin
