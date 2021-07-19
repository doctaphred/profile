# https://docs.brew.sh/Manpage#environment
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_DISPLAY_INSTALL_TIMES=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1

# Prefer Homebrew openssl.
# use "/usr/local/opt/openssl@1.1"

# Make gcc use Homebrew openssl
if test -d /usr/local/opt/openssl; then
    export LDFLAGS=-L/usr/local/opt/openssl/lib
    export CFLAGS=-I/usr/local/opt/openssl/include
fi
