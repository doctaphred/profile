# $PATH modifications

prohibit-subshells

path () {
    echo "$PATH" | tr -s ":" "\n"
}

_realpath() (
    # From http://stackoverflow.com/a/18443300/441757
    OURPWD=$PWD
    cd "$(dirname "$1")"
    LINK=$(readlink "$(basename "$1")")
    while [ "$LINK" ]; do
        cd "$(dirname "$LINK")"
        LINK=$(readlink "$(basename "$1")")
    done
    REALPATH="$PWD/$(basename "$1")"
    cd "$OURPWD"
    echo "$REALPATH"
)

use () {
    # Add a directory to $PATH.
    # TODO: MANPATH?
    dir="$1"
    bindir="${2-bin}"
    path="$(_realpath "$dir/$bindir")"
    PATH="$path:$PATH"
}

unuse () {
    PATH="${PATH#*:}"
}

# macOS applications
try use "/Applications/Visual Studio Code.app/Contents/Resources/app"

# GNU find, locate, updatedb, and xargs
# use /usr/local/opt/findutils/libexec gnubin

# use /usr/local/opt/make/libexec gnubin

# Systemd shell executable directory
try use ~/.local

# My personal executables (nonstandard locations)
try use ~
try use "$PROFILE"
# try use ~/stuff
