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

pyinfo () {
	where=$(dirname $(dirname $(which python)))
	echo -n "$(
		# XXX: Indented heredocs MUST be indented with tabs, not spaces.
		python <<-EOF
			import platform
			print(platform.python_version())
		EOF
	)"
	if test "$where" != "/usr/local"; then
		echo -n " ($(
			realpath --no-symlinks --relative-to="$PWD" "$where"
		))"
	fi
	echo
}

# TODO: Bash's built-in prompt escape sequences are hella confusing,
# especially since they use the same escape character as normal strings.
# (Also, not sure how trailing newlines are handled.) Consider defining
# `PS0='$(ps0)'` and `PS1='$(ps1)'`, and replacing the escapes with
# explicit function/command calls.

timestamp="${bold_black}\D{%Y-%m-%d %H:%M:%S %Z}${reset}"
errinfo="${bold_red}\$(errinfo)${reset}"
myinfo="${bold_green}\u@\H${reset}"
workdir="${bold_blue}\w${reset}"
pyinfo="${bold_cyan}\$(pyinfo)${reset}"
gitinfo="${bold_purple}\$(__git_ps1 '(%s)')${reset}"
prompt="${bold}\\\$${reset}"

PS0="\n$timestamp\n\n"
PS1="\n$timestamp\n$errinfo\n$myinfo $workdir 🐍 $pyinfo $gitinfo\n$prompt "
