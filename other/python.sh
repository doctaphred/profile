export PYTHONSTARTUP=~/profile/python/startup.py
# YES I UNDERSTAND THAT PYTHON 2.7 WILL REACH THE END OF ITS LIFE ON
# JANUARY 1ST, 2020 THANK YOU FOR CONTINUALLY INFORMING ME
export PYTHONWARNINGS='ignore:DEPRECATION::pip._internal.cli.base_command:'
# Format is `action:message:category:module:line`. The `warnings` module
# parses this value by just splitting it on ':', so we can't spell out
# the full message, which includes a colon (ಠ_ಠ). To avoid accidentally
# silencing other [less obnoxious and more helpful] warnings which also
# happen to start with 'DEPRECATION', specify the module as well.


# Tell virtualenvs not to mess with my prompt.
export VIRTUAL_ENV_DISABLE_PROMPT=1

venv() {
    source venv/bin/activate
}

newvenv() {
    name="${1-venv-$RANDOM}"
    shift
    python3 -m venv "$name" "$@"
    use "$name"
}

alias ip='python -m IPython'
alias ip3='python3 -m IPython'
alias ip2='python2 -m IPython'

alias pycharm='open -a "PyCharm CE"'

# Install libraries I use for development in most projects.
alias pipdev='pip install -r ~/profile/python/requirements-dev.in'
alias pyformat='python -c "help(\"FORMATTING\")"'

alias pdb='python -m pdb -c continue'
alias pdbm='python -m pdb -c continue -m'

