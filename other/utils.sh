join () {
    # Intersperse the first arg between the rest.
    sep="$1"
    shift
    echo -n "$1"
    shift
    for arg in "$@"; do
        echo -n "$sep"
        echo -n "$arg"
    done
}

show () {
    for name in "$@"; do
        printf '%q=%q' "${name}" "${!name}"
    done
}

trim-whitespace () {
    # Remove trailing whitespace of all files recursively.
    # Ignores .git and .svn folders and their contents.
    # http://stackoverflow.com/a/5130044/1752050
    export LANG=C
    find . -not \( -name .svn -prune -o -name .git -prune \) -type f -print0 | xargs -0 sed -i '' -E "s/[[:space:]]*$//"
    # find dir -type f -exec sed -i 's/ *$//' '{}' ';'
}

setvol () {
    osascript -e "tell application \"System Events\" to set volume output volume $1"
}

setmic () {
    osascript -e "tell application \"System Events\" to set volume input volume $1"
}

alias mute='setvol 0'
alias unmute='setvol 50'
alias mutemic='setmic 0'
alias unmutemic='setmic 50'

# Copy working directory to clipboard
cpwd () {
    pwd | pbcopy
}

alias getip='dig +short myip.opendns.com @resolver1.opendns.com'
alias cpip='getip | pbcopy'

alias getip-local='ipconfig getifaddr en0'
alias cpip-local='getip-local | pbcopy'

# NOTE: the built-in `open` program handles URLs!

# Open Google Chrome
chrome () {
    open -a "Google Chrome" "$*"
}

# Open Firefox
ff () {
    open -a Firefox "$*"
}

# Open Safari
safari () {
    open -a Safari "$*"
}

json-to-yaml () {
    # json-to-yaml < file.json > newfile.yaml
    ruby -ryaml -rjson -e 'puts YAML.dump(JSON.parse(STDIN.read))'
}

tabs-to-spaces () {
    # Expand tabs in all files that don't start with a dot
    find . "$@" \! -name ".*" \! -type d -exec bash -c 'expand -t 4' {} \;
}

samefile () {
    cmp --silent "$@"
}

wake-on-lan () {
    # http://stackoverflow.com/a/31588036/1752050
    # example MAC: 11:22:33:44:55:66
    MAC="$1"
    Broadcast=255.255.255.255
    PortNumber=4000
    echo -e "$(
        echo "$(
            printf 'f%.0s' {1..12};
            printf "$(echo $MAC | sed 's/://g')%.0s" {1..16};
        )" | sed -e 's/../\\x&/g'
    )" | nc -w1 -u -b $Broadcast $PortNumber
}

openports() {
    lsof -i -P -w -n | grep LISTEN
}

rehist() {
    history -a  # Append this session's history to the history file
    history -c  # Clear this session's history
    history -r  # Read history from file
}
