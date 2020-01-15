# $PATH modifications

prohibit-subshells

path () {
    echo "$PATH" | tr -s ":" "\n"
}

use () {
    PATH="$(realpath "$1"/bin):$PATH"
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
