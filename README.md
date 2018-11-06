# Bash configuration

Any reasonably complex bash setup is guaranteed to be a big, hairy mess. This
one is no exception, but we can at least put a little product in it.


## Setup

To use this repo, clone it into your home directory, back up and remove any
existing .bash_profile and .bashrc, and run the following commands:

    echo 'source ~/.bashrc' >> ~/.bash_profile
    echo 'source ~/profile/__main__.sh' >> ~/.bashrc

You might need to upgrade bash in order to use options like `shopt -s autocd`. To do this on macOS:

    brew install bash
    sudo nano /etc/shells
    # Add /usr/local/bin/bash to the end of the list
    chsh -s /usr/local/bin/bash $USER


## Additional setup notes

Run `touch ~/.hushlogin` to disable the `Last login: <date> on ttys001` startup message.


## Style guide

https://google.github.io/styleguide/shell


## TODO

- Create a `use` command to toggle `nvm`, `pyenv`, etc
