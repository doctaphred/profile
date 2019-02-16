# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.bash"


# Use fd if it's available: https://github.com/sharkdp/fd
if exists fd; then  # `exists` is defined in functions.sh
    export FZF_DEFAULT_COMMAND='fd --type=file'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
