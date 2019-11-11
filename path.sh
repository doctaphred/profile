# $PATH modifications

use () {
    export PATH="$(realpath "$1"):$PATH"
}

# Systemd shell executable directory
use ~/.local/bin

# My personal executables (nonstandard locations)
use ~/bin
use ~/profile/bin
