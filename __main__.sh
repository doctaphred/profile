# Main entry point for bash config.
# Source this file from ~/.bashrc,
# and source ~/.bashrc from ~/.bash_profile

# Style guide: https://google.github.io/styleguide/shell.xml

source ~/profile/options.sh
source ~/profile/aliases.sh
source ~/profile/functions.sh
source ~/profile/path.sh
source ~/profile/prompt.sh

# Source each '.sh' file in the `source` directory in lexicographical order
for f in ~/profile/other/*.sh; do
    source "$f"
done

# # Only source this file in interactive shells, not from a script or from scp
# [[ $- = *i* ]] && source ~/profile/interactive.sh

# Profile modifications which should not be published
# include ~/private/profile.sh

# direnv: https://github.com/direnv/direnv
eval "$(direnv hook bash)"

# eval "$(pyenv init -)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# # test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
