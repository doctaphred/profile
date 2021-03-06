prohibit-subshells

reset='\[\e[0m\]'
bold='\[\e[1m\]'
black='\[\e[0;30m\]'
bold_black='\[\e[01;30m\]'
red='\[\e[0;31m\]'
bold_red='\[\e[01;31m\]'
green='\[\e[0;32m\]'
bold_green='\[\e[01;32m\]'
yellow='\[\e[0;33m\]'
bold_yellow='\[\e[01;33m\]'
blue='\[\e[0;34m\]'
bold_blue='\[\e[01;34m\]'
purple='\[\e[0;35m\]'
bold_purple='\[\e[01;35m\]'
cyan='\[\e[0;36m\]'
bold_cyan='\[\e[01;36m\]'
gray='\[\e[0;37m\]'
bold_gray='\[\e[01;37m\]'

errinfo () {
	err=${1:-$?}
	test $err = 0 && return
	echo -n "Error $err: "
    case $err in
        # 0) echo '[not an error]';;
        1) echo '[default error code]' ;;
        2) echo 'Error with shell builtin' ;;
        126) echo 'Cannot execute command. Do you need to `chmod a+x` it?' ;;
        127) echo 'Command not found. Is it on your $PATH? Did you make a typo?' ;;
        128) echo 'Invalid argument to exit' ;;
        129) echo 'Terminated by SIGHUP' ;;
        130) echo 'Terminated by SIGINT' ;;
        131) echo 'Terminated by SIGQUIT' ;;
        132) echo 'Terminated by SIGILL' ;;
        133) echo 'Terminated by SIGTRAP' ;;
        134) echo 'Terminated by SIGABRT' ;;
        135) echo 'Terminated by SIGEMT' ;;
        136) echo 'Terminated by SIGFPE' ;;
        137) echo 'Terminated by SIGKILL' ;;
        138) echo 'Terminated by SIGBUS' ;;
        139) echo 'Terminated by SIGSEGV' ;;
        140) echo 'Terminated by SIGSYS' ;;
        141) echo 'Terminated by SIGPIPE' ;;
        142) echo 'Terminated by SIGALRM' ;;
        143) echo 'Terminated by SIGTERM' ;;
        144) echo 'Terminated by SIGURG' ;;
        145) echo 'Terminated by SIGSTOP' ;;
        146) echo 'Terminated by SIGTSTP' ;;
        147) echo 'Terminated by SIGCONT' ;;
        148) echo 'Terminated by SIGCHLD' ;;
        149) echo 'Terminated by SIGTTIN' ;;
        150) echo 'Terminated by SIGTTOU' ;;
        151) echo 'Terminated by SIGIO' ;;
        152) echo 'Terminated by SIGXCPU' ;;
        153) echo 'Terminated by SIGXFSZ' ;;
        154) echo 'Terminated by SIGVTALRM' ;;
        155) echo 'Terminated by SIGPROF' ;;
        156) echo 'Terminated by SIGWINCH' ;;
        157) echo 'Terminated by SIGINFO' ;;
        158) echo 'Terminated by SIGUSR1' ;;
        159) echo 'Terminated by SIGUSR2' ;;
        255) echo 'Exit status out of range' ;;
        *) echo 'Unknown error' ;;
    esac
}

myinfo () {
    echo -n "$(whoami)@$(hostname -s)"
}

pyinfo () {
    python <<-EOF
		from __future__ import print_function
		import platform
		print(platform.python_version(), end='')
		EOF
    where="$(dirname "$(dirname "$(which python)")")"
    if test "$where" != "/usr/local"; then
        where_rel="$(realpath --no-symlinks --relative-to="$PWD" "$where")"
        echo -n " ($where_rel)"
    fi
}

gitinfo () {
     {
        commit="$(git rev-parse --short HEAD)"
        branch="$(git rev-parse --abbrev-ref HEAD)"
        ago="$(git log -1 --format='%cr' HEAD)"
    } 2>/dev/null || return
    echo "🌳 $branch ($commit, $ago)"
}

stashinfo () {
    {
        stashed="$(git stash list -1 --format='%cr')"
    } 2>/dev/null || return
    test -n "$stashed" && echo "🗄  ($stashed)"
}

# TODO: Bash's built-in prompt escape sequences are hella confusing,
# especially since they use the same escape character as normal strings.
# (Also, not sure how trailing newlines are handled.) Consider defining
# `PS0='$(ps0)'` and `PS1='$(ps1)'`, and replacing the escapes with
# explicit function/command calls.

timestamp="${bold_black}\D{%Y-%m-%d %H:%M:%S %Z}${reset}"
errinfo="${bold_red}\$(errinfo)${reset}"
myinfo="${bold_green}\$(myinfo)${reset}"
workdir="${bold_blue}\w${reset}"
pyinfo="${bold_cyan}\$(pyinfo)${reset}"
gitinfo="${bold_purple}\$(gitinfo)${reset}"
stashinfo="\$(stashinfo)"
prompt="${bold}\\\$${reset}"

PS0="\n$timestamp\n\n"
PS1="\n$timestamp\n$errinfo\n$myinfo $workdir 🐍 $pyinfo $gitinfo $stashinfo\n$prompt "


# ls-after-cd, inspired by http://pastebin.com/VBSQJyeA
# Insert into PROMPT_COMMAND
__prev_wd="$PWD"
_ls_new_wd() {
    [[ $__prev_wd != "$PWD" ]] && ls
    __prev_wd="$PWD"
}

# https://debian-administration.org/article/543/Bash_eternal_history
__prev_hist="$(history 1)"
_eternal_history() {
    local __hist
    __hist="$(history 1)"
    if [[ "$__prev_hist" != "$__hist" ]]; then
        echo $$ "$USER" "$__hist" >> ~/.bash_eternal_history
        __prev_hist="$__hist"
    fi
}

_prompt_command() {
    # Append history lines from this session to the history file
    history -a
    # Append last history command to custom "eternal history" file
    _eternal_history
    # List directory contents if we're in a new working directory
    _ls_new_wd
}

PROMPT_COMMAND="_prompt_command; $PROMPT_COMMAND"
