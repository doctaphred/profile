# Main entry point for bash config.
# Source this file from ~/.bashrc,
# and source ~/.bashrc from ~/.bash_profile

# Style guide: https://google.github.io/styleguide/shell.xml

set -e  # Exit immediately if there's an error.

log () {
    >&2 echo "$@"
}

log "Shell: $SHELL ($BASH_VERSION)"
log "PID: $BASHPID"

# Get the directory containing this script, and resolve any symlinks.
# (n.b. `BASH_SOURCE` is an array, but we just want the first element.)
export PROFILE="$(realpath "$(dirname "$BASH_SOURCE")")"

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
