# Make gcc use Homebrew openssl
export LDFLAGS=-L/usr/local/opt/openssl/lib
export CFLAGS=-I/usr/local/opt/openssl/include
