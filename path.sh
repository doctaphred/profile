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

# macOS applications
try use "/Library/Frameworks/Python.framework/Versions/3.8"
try use "/Applications/Visual Studio Code.app/Contents/Resources/app"

# GNU find, locate, updatedb, and xargs
# use /usr/local/opt/findutils/libexec gnubin

# Prefer Homebrew openssl.
# use "/usr/local/opt/openssl@1.1"

# Systemd shell executable directory
try use ~/.local

# My personal executables (nonstandard locations)
try use ~
try use ~/profile
# try use ~/stuff
