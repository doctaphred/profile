# Main entry point for bash config.
# Source this file from ~/.bashrc,
# and source ~/.bashrc from ~/.bash_profile

# Style guide: https://google.github.io/styleguide/shell.xml

set -e  # Exit immediately if there's an error.

# XXX: Many external scripts rely on the 'nounset' (`set -u`) option to
# be *disabled* (the unfortunate default) -- not only when sourcing
# them, but sometimes even afterward (e.g., 'git-completion.bash').
#
# Someday I will write my own shell and will not have to deal with this
# nonsense; but until that day, don't run `set -u` in your bash profile!

log () {
	# Echo cyan text to stderr with some contextual information.
	>&2 echo -en "\033[0;36m"  # Style: reset; cyan foreground.
	# >&2 echo -n "[${FUNCNAME[1]}] "  # Prefix with calling function name.
	>&2 echo -n "$*"
	>&2 echo -e "\033[0m"  # Style: reset.
}

log "Shell: $SHELL ($BASH_VERSION)"
log "PID: $BASHPID"

# Get the directory containing this script, and resolve any symlinks.
# (n.b. `BASH_SOURCE` is an array, but we just want the first element.)
export PROFILE="$(realpath "$(dirname "$BASH_SOURCE")")"

prohibit-subshells () {
	# Call this function in additional setup scripts to prevent
	# accidentally sourcing them in a subshell.
	if test $$ != $BASHPID; then
		>&2 cat <<-EOF

		ERROR in ${BASH_SOURCE[1]}:

		This file is meant to be sourced in the current active shell
		(PID $$), but was run in a subshell (PID $BASHPID): any changes
		it makes to the shell environment (including aliases and
		function definitions) will have no effect in the parent shell.

		EOF
		exit 1
	fi
}

prohibit-subshells  # Just in case!

# Source these files in this specific order.
source "$PROFILE/options.sh"
source "$PROFILE/env.sh"
source "$PROFILE/aliases.sh"
source "$PROFILE/functions.sh"
source "$PROFILE/path.sh"
source "$PROFILE/prompt.sh"

# Source these files in arbitrary order.
# TODO: is this okay if paths contain spaces?
for path in $(find "$PROFILE/other" -name '*.sh'); do
	source "$path"
done

# direnv: https://github.com/direnv/direnv
eval "$(direnv hook bash)"

# iTerm shell integration
include ~/.iterm2_shell_integration.bash

# Now that we're done with setup, disable errexit so failed commands
# don't quit the interactive shell.
#
# TODO: figure out why the bash completion script below encounters an error.
set +e

# bash completion: `brew install bash-completion`
# XXX: This might be slow...
include "/usr/local/etc/profile.d/bash_completion.sh"
