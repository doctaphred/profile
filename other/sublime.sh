SUBLIME_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
SUBLIME_PROJECT_DIR="$SUBLIME_DIR/Projects"

proj() {
    # Open a project in Sublime Text.
    (
        # cd to project directory to show only the basenames.
        # Use a subshell so cd doesn't affect the parent directory.
        cd "$SUBLIME_PROJECT_DIR"
        # TODO: Exclude extensions from display.
        path="$(fd '\.sublime-project$' | fzp "$@")"
        if test -n "$path"; then
            set -x
            # TODO: does the --project flag actually do anything?
            subl --project "$path"
        fi
    )
}
