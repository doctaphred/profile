direnv-python2() {
    echo 'layout python' >> .envrc
    direnv allow
}

direnv-python3() {
    echo 'layout python3' >> .envrc
    direnv allow
}
