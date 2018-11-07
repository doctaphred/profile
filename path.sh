# $PATH modifications

# Systemd shell executable directory
export PATH=~/.local/bin:$PATH

# # GNU coreutils
# PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# My personal executables (nonstandard locations)
export PATH=~/bin:~/profile/bin:$PATH

# Platform-specific executables (personal, nonstandard)
# ex: ~/bin/"$(uname -s)"-"$(uname -m)" => ~/bin/Darwin-x86_64
export PATH=~/bin/"$(uname -s)"-"$(uname -m)":~/bin/"$(uname -s)":$PATH

# Anaconda (anaconda.com)
# export PATH=/usr/local/anaconda3/bin:"$PATH"
