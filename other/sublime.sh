SUBLIME_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
SUBLIME_PROJECT_DIR="$SUBLIME_DIR/Projects"

proj() {
    # Open a project in Sublime Text.

    # Use a subshell so cd doesn't affect the parent directory.
    (
        cd "$SUBLIME_PROJECT_DIR"
        path="$(fzf-realpath $@)"
        if test -n "$path"; then
            set -x
            # TODO: does the --project flag actually do anything?
            subl --project "$path"
        fi
    )
}

alias prof='proj profile'
