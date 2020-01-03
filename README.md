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


## Useful info

From `man bash`:

        When  bash is invoked as an interactive login shell, or as a non-inter-
        active shell with the --login option, it first reads and executes  com-
        mands  from  the file /etc/profile, if that file exists.  After reading
        that file, it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile,
        in  that order, and reads and executes commands from the first one that
        exists and is readable.  The --noprofile option may be  used  when  the
        shell is started to inhibit this behavior.

        When an interactive login shell exits, or a non-interactive login shell
        executes the exit builtin command, bash  reads  and  executes  commands
        from the file ~/.bash_logout, if it exists.

        When  an  interactive  shell that is not a login shell is started, bash
        reads and executes commands from ~/.bashrc, if that file exists.   This
        may  be inhibited by using the --norc option.  The --rcfile file option
        will force bash to read and  execute  commands  from  file  instead  of
        ~/.bashrc.

        When  bash  is  started  non-interactively,  to run a shell script, for
        example, it looks for the variable BASH_ENV in the environment, expands
        its  value if it appears there, and uses the expanded value as the name
        of a file to read and execute.  Bash behaves as if the  following  com-
        mand were executed:
            if [ -n "$BASH_ENV" ]; then . "$BASH_ENV"; fi
        but  the value of the PATH variable is not used to search for the file-
        name.

Also from `man bash`:

        BUGS

            It's too big and too slow.


## Style guide

https://google.github.io/styleguide/shell


## TODO

- Create a `use` command to toggle `nvm`, `pyenv`, etc
