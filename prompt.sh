reset='\[\e[0m\]'
bold='\[\e[1m\]'
black='\[\e[0;30m\]'
bold_black='\[\e[01;30m\]'
red='\[\e[0;31m\]'
bold_red='\[\e[01;31m\]'
green='\[\e[0;32m\]'
bold_green='\[\e[01;32m\]'
yellow='\[\e[0;33m\]'
yellow='\[\e[01;33m\]'
blue='\[\e[0;34m\]'
bold_blue='\[\e[01;34m\]'
purple='\[\e[0;35m\]'
bold_purple='\[\e[01;35m\]'
cyan='\[\e[0;36m\]'
bold_cyan='\[\e[01;36m\]'
gray='\[\e[0;37m\]'
bold_gray='\[\e[01;37m\]'


function errormsg {
    local prev=$?
    if [ $prev != 0 ]; then
        echo -e "\e[01;31m\n$(sysexit-info $prev)\e[0m"
    fi
}


# Load __git_ps1 function
source /usr/local/etc/bash_completion.d/git-prompt.sh

# No separator (handled in PS1)
GIT_PS1_STATESEPARATOR=''

# Show `*` for unstaged and `+` for staged changes
GIT_PS1_SHOWDIRTYSTATE=1

# Show `$` for stashed changes
GIT_PS1_SHOWSTASHSTATE=1

# Show `%` for untracked files
# GIT_PS1_SHOWUNTRACKEDFILES=1

# Show `<` for behind, `>` for ahead, `<>` for diverged, `=` for equal
# GIT_PS1_SHOWUPSTREAM="auto"

# Colorize dirty state like `git status -sb`
# (Only works with PROMPT_COMMAND)
GIT_PS1_SHOWCOLORHINTS=1

# Do nothing when the current directory is ignored
GIT_PS1_HIDE_IF_PWD_IGNORED=1


# This will get overwritten by liquidprompt, if it's installed.
function fancy_ps1 {
    local __timestamp_func='`date +%H:%M:%S`'
    local __timestamp="${bold_black}${__timestamp_func}${reset}"

    local __errormsg_func='`errormsg`'
    local __errormsg="${__errormsg_func}"

    local __user_and_host="${bold_green}\u@\h${reset}"

    local __pyinfo_func='`pyinfo --short --brew`'
    local __python_info="${bold_cyan}${__pyinfo_func}${reset}"

    local __working_dir="${bold_blue}\w${reset}"

    local __git_info="${bold_purple}"'$(__git_ps1 "(%s)")'"${reset}"

    local __prompt="${reset}${bold}$ ${reset}"

    export PS1="${reset}${__errormsg}\n${__timestamp} ${__user_and_host} ${__python_info} ${__working_dir} ${__git_info}\n${__prompt}"
}
fancy_ps1
