prohibit-subshells

# Aliases and functions for working with Git and GitHub

alias gs='git status'

alias gsh='git show'
alias gshn='git show --name-only'
alias gsn='git show --name-only'

alias gst='git stash'
alias gsta='git stash --include-untracked'
alias gsts='git stash show --patch'  # --patch: Show diff, not just names
alias gstsh='git stash show --patch'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstcl='git stash clear'
alias gstd='git stash drop'
alias gsp='git stash pop'

alias gd='git diff'
alias gdc='git diff --cached'
alias gdn='git diff --name-only'
alias gdno='git diff --name-only'

alias gb='git branch'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

alias gc='git commit --verbose'
alias gca='git commit --amend'
alias regc='git commit --amend'

alias gch='git checkout'
alias gchp='git checkout -'
alias g-='git checkout -'
alias gch-='git checkout -'
alias gchb='git checkout -b'

alias gr='git reset'
alias grs='git reset --soft'
alias gf='git fetch'

# `git config --global rebase.autoStash true` makes this much nicer
alias gpr='git pull --rebase'

alias gpu='git push'  # Remember to `git config --global push.default current`
alias gpuf='git push --force-with-lease'
alias yeet='git push --force-with-lease'
alias YEET='git push --force --no-verify'

alias gsu='git submodule update'
alias gsur='git submodule update --recursive'
alias gsui='git submodule update --init'
alias gsuir='git submodule update --init --recursive'
alias gsuri='git submodule update --recursive --init'

alias gg='git grep'

alias gri='git rebase --interactive'
alias grim='git rebase --interactive master'

alias gcl='git clone'

git-in() {
    # Perform a git command in the given directory.
    >&2 echo 'Deprecated: use `git -C <dir>`'
    return 1
}

git-name() {
    # Print the symbolic name for the current commit
    # (n.b. 'HEAD' works here even in detached ("gittotined") state)
    git name-rev --always --name-only HEAD
}

git-current-branch() {
    git rev-parse --abbrev-ref HEAD
}

git-retrack() {
    # Solution to "There is no tracking information for the current branch."
    git branch \
        --set-upstream-to="origin"/"$(git-current-branch)" \
        "$(git-current-branch)"
}

# Squash the previous N commits into the N+1th,
# preserving and amending only the N+1th message.
gsqn() {
    # Git squash N
    git reset --soft "HEAD~$1" && git commit --amend
}

alias gsq='gsqn 1'

grin() {
    # Git rebase interactive <n>
    git rebase --interactive "HEAD~$1"
}

ga() {
    git add "$@"
    git status
}
alias gau='ga --update'
alias gauc='git add --update && git status && git commit'

gl () {
    # %h: abbreviated commit hash
    # %an: author name
    # %cr: committer date, relative
    # %s: subject
    # %d: ref names, like the --decorate option of git-log(1)
    # %C(red): switch to red text
    # %<(16): add spaces on the right to fit the next % to 16 columns; truncate the right side
    git log --pretty=format:'%C(yellow)%h%C(reset) %C(green)%<(16,trunc)%an%C(reset) %C(magenta)%<(14)%cr%C(reset)%C(red)%d%C(reset) %s' "$@"
}

gbdp() {
    # "git branch delete previous"
    git branch --delete '@{-1}'
}

gbdpf() {
    # "git branch delete previous (force)"
    git branch -D '@{-1}'
}

ggraph() {
    git log --pretty=oneline --abbrev-commit --graph --decorate
}

alias glg='gl | ag'
alias gll='git log'

gre() {
    git rebase --interactive HEAD~@1
}

ghcl() {
    # GitHub clone
    git clone "git@github.com:$1/$2.git" "${@:3}"
    cd "${!#}"
    git submodule update --recursive --init
}

ghql() {
    # GitHub qlone
    git clone "git@github.com:quantopian/$1.git" "${@:2}" 2>&1| tr Cc Qq
    cd "${!#}"
    git submodule update --recursive --init 2>&1| tr Cc Qq
}

ghcl-multi() {
    xargs -n1 -P32 -I% git clone "git@github.com:%.git"
}

ghcl-multi-org() {
    org="$1"
    xargs -n1 -P32 -I% git clone "git@github.com:$1/%.git"
}

git-bump() {
    pushd "$1"
    git checkout master
    git pull
    popd
}

pghcl() {
    # Personal GitHub clone
    # Make sure github-personal is defined as a Host in ~/.ssh/config,
    # with an IdentityFile entry pointing to the associated private key.
    set -x
    git clone "git@github-personal:$GITHUB_PERSONAL_ACCOUNT/$1.git"
    cd $1
    git config --local user.name "$NAME"
    git config --local user.email "$EMAIL"
    set +x
}

wghcl() {
    # Work GitHub clone
    # Make sure github-work is defined as a Host in ~/.ssh/config,
    # with an IdentityFile entry pointing to the associated private key.
    set -x
    git clone "git@github-work:$GITHUB_WORK_ORG/$1.git"
    cd $1
    git config --local user.name "$NAME"
    git config --local user.email "$WORK_EMAIL"
    set +x
}

bbcl() {
    # Bitbucket clone
    git clone "git@bitbucket.com:$1/$2.git"
    cd "$2"
}

git-set-origin-ssh() {
    git remote remove origin
    git remote add origin "git@github.com:doctaphred/${PWD##*/}.git"
}

# Recursively find git work trees in the current directory.
git-repos() {
    # The presence of either a `.git` file *or* directory can indicate a git
    # directory. (See `--separate-git-dir`, `--git-dir`, and `$GIT_DIR`.)
    find . -name .git -execdir pwd \;
}

# Clone a git repo into a directory matching its URL.
git-mirror() {
    netloc="$1"
    path="$2"
    dest="$HOME/git/$netloc/$path"

    mkdir -p "$dest"
    git clone "git@$netloc:$path.git" "$dest"
    cd "$dest"
    git submodule update --recursive --init
}

# Run `git fetch` in all mirrored git repos.
git-mirror-refresh() {
    # TODO: parallelize
    find "$HOME/git" -name .git -execdir pwd \; -execdir git fetch -v \;
}

github-mirror() {
    git-mirror "github.com" "$1/$2"
}

# Toggle whether a directory "is" a git repo, to temporarily avoid strange
# interactions with external tools.
ungit() { mv -v -i .git ..git; }
regit() { mv -v -i ..git .git; }

alias such=git
alias very=git
alias much=git
alias many=git
alias wow='git status'
alias amaze='git push'
# wow
# such commit
# very pull
# amaze


# bash completion
include /usr/local/etc/bash_completion.d/git-completion.bash
