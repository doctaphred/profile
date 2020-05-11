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
    path="$(realpath "$dir/$bindir")"
    PATH="$path:$PATH"
}

unuse () {
    PATH="${PATH#*:}"
}

# GNU find, locate, updatedb, and xargs
# use /usr/local/opt/findutils/libexec gnubin

# Prefer Homebrew openssl.
use "/usr/local/opt/openssl@1.1"

# Systemd shell executable directory
use ~/.local

# My personal executables (nonstandard locations)
use ~
use ~/profile
use ~/stuff
