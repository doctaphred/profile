# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && include "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
include "/usr/local/opt/fzf/shell/key-bindings.bash"


# Use fd if it's available: https://github.com/sharkdp/fd
if exists fd; then  # `exists` is defined in functions.sh
    export FZF_DEFAULT_COMMAND='fd --color=always'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --hidden --no-ignore"
fi

FZF_PREVIEW='
    test -d {} &&
    CLICOLOR_FORCE=1 ls -C {} ||
    bat --color=always --style=header {}
'
export FZF_DEFAULT_OPTS="
    --reverse
    --ansi
    --height=90%
    --preview='$FZF_PREVIEW'
    --select-1
"
export FZF_CTRL_R_OPTS='
    --preview-window=hidden
    --height=40%
    --layout=default
'

# Press enter to open selection with less
alias fzl='fzf --bind "enter:execute(less {})"'
# Press tab to open selection with bat
alias fzb='fzf --bind "tab:execute(bat --paging=always --pager=less {})"'
# TODO: when/why does bat require `--pager=less` to avoid exiting at the
# end of the file (as if it's using `less -FX`)?

pbcrp() {
    # "pasteboard copy relative path"
    fd0 --color=always --hidden --no-ignore |
    fzf |
    pbcopy &&
    echo "Copied '$(pbpaste)' to the pasteboard."
}

pbcp() {
    # "pasteboard copy path"
    fd0 --color=always --hidden --no-ignore |
    fzp |
    pbcopy &&
    echo "Copied '$(pbpaste)' to the pasteboard."
}

pbcf() {
    # "pasteboard copy file"
    local path
    # TODO: skip fzf if the path exists
    path="$(
        fd0  --type=file --color=always --hidden --no-ignore |
        fzp "$@"
    )"
    if test -n "$path"; then
        pbcopy < "$path"
        echo "Copied contents of '$path' to the pasteboard."
    fi
}


fd0() {
    # Run fd and exit 0, even if fd's output pipe closes before it's
    # finished. (Only seems to matter in pipelines; not in subshells.)
    fd "$@" || true
}

alias fd-home='fd0 . ~'
alias fd-root='fd0 . /'

alias fd-all='fd0 --hidden --no-ignore'  # Or `fd -HI`
alias fd-all-home='fd-all . ~'
alias fd-all-root='fd-all . /'

alias fdh=fd-home
alias fdr=fd-root

alias fda=fd-all
alias fdah=fd-all-home
alias fdar=fd-all-root


alias fzf-home='fd-home | fzf'
alias fzf-root='fd-root | fzf'

alias fzf-all='fd-all | fzf'
alias fzf-all-home='fd-all-home | fzf'
alias fzf-all-root='fd-all-root | fzf'

alias fzfh=fzf-home
alias fzfr=fzf-root

alias fzfa=fzf-all
alias fzfah=fzf-all-home
alias fzfar=fzf-all-root


fzd() {
    # fzf directories from within a parent directory.

    # First cd to the base directory so fzf shows relative paths. Use a
    # subshell to avoid changing the parent's working directory in case
    # an error occurs (e.g., if you exit via ctrl+c).
    (cd "$1" &&
        fd0 --follow --type=directory |
        fzp "${@:2}")
}

fzd-all() {
    (cd "$1" &&
        fd0 --hidden --no-ignore --follow --type=directory |
        fzp "${@:2}")
}

jump() {
    # fzf + cd == <3

    # `cd` with no args defaults to $HOME, but `cd <empty string>` is a
    # no-op: if the subshell's command gives no output, nothing happens.
    cd "$(fzd "$@")"
}

jump-all() {
    cd "$(fzd-all "$@")"
}

# Jump (home)
alias j='jump ~'
alias ja='jump-all ~'

# Jump (dev)
alias jd='jump ~/dev'
alias jad='jump-all ~/dev'

# Jump (root)
alias jr='jump /'
alias jar='jump-all /'

# Jump (local)
alias jl='jump .'
alias jal='jump .'

jp() {
    # Jump to project.
    cd "$(
        cd ~/dev &&
        fd --follow --type=directory --max-depth=4 |
        fzp "$@"
    )"
}

sp() {
    # Jump to project and edit in Sublime.
    local path="$(
        cd ~/dev &&
        fd --follow --type=directory --max-depth=2 |
        fzp "$@"
    )"
    if test -n "$path"; then
        # TODO: open matching project instead of directory (if it exists).
        subl --background "$path"
        cd "$path"
    fi
}

fzs() {
    local path="$(fzp "${@:2}")"
    test -n "$path" && subl "$path"
}


alias fzs-home='fd-home | fzs'
alias fzs-root='fd-root | fzs'
alias fzs-dev='fd0 . ~/dev | fzs'  # TODO: Finish this

alias fzs-all='fd-all | fzs'
alias fzs-all-home='fd-all-home | fzs'
alias fzs-all-root='fd-all-root | fzs'

alias fzsh=fzs-home
alias fzsr=fzs-root
alias fzsd=fzs-dev

alias fzsa=fzs-all
alias fzsah=fzs-all-home
alias fzsar=fzs-all-root

# TODO: https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings#changing-the-layout
# http://www.andre-simon.de/doku/highlight/en/highlight.php

# *** SUPER DUPER TODO: https://junegunn.kr/2016/07/fzf-git/
