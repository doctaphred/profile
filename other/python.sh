export PYTHONSTARTUP=~/profile/python/startup.py

# Tell virtualenvs not to mess with my prompt.
export VIRTUAL_ENV_DISABLE_PROMPT=1

venv() {
    source venv/bin/activate
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

