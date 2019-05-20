SUBLIME_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages/User"

proj() {
    subl --project "$SUBLIME_DIR/Projects/$1.sublime-project"
}

alias prof='proj profile'
