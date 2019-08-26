# Make gcc use Homebrew openssl
export LDFLAGS=-L/usr/local/opt/openssl/lib
export CFLAGS=-I/usr/local/opt/openssl/include

# XXX: Don't do this: way too many projects assume that if you're using
# macOS, you're using clang.
#
# # Use gcc by default
# export CC=gcc-8
# export CXX=g++-8

# TODO: combine this with the above CFLAGS?
# # Compile for this specific architecture (performance optimization)
# export CFLAGS="-march=native"
