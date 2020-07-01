# Utility functions for environment management.
#
# This file must be sourced, not run as a script.

# Set default values, only if variables are unset. (`true` is a no-op.)
# Note that this does NOT modify variables which are set to null/empty-string.
true ${ENV_DIR=env}
true ${ENV_SUFFIX=.env}
true ${ENV_LOG=1}

# Print a message to stderr.
log () { >&2 printf '[%s] %s\n' "${BASH_SOURCE[0]}" "$*"; }

# Log in bold red.
err () { log "$(tput bold)$(tput setaf 1)Error: $*$(tput sgr0)"; }

# Log in bold yellow.
warn () { log "$(tput bold)$(tput setaf 3)Warning: $*$(tput sgr0)"; }

# Log in cyan if $ENV_LOG is set to a nonempty value.
info () {
    if test "${ENV_LOG-}"; then
        log "$(tput setaf 6)$*$(tput sgr0)"
    fi
}

# Check whether a string is a valid variable name.
valid-name () { [[ "$1" =~ ^[[:alpha:]_][[:alnum:]_]*$ ]]; }

# Check whether a string is a special variable name.
special-name () { [[ "$1" =~ ^(HOME|PATH|PWD|SHELL|BASH_.*)$ ]]; }

# Load an environment variable from the corresponding file.
load () {
    local name file
    name="${1:?Which variable do you want to load?}"
    if valid-name "$name"; then
        file=$ENV_DIR/$name$ENV_SUFFIX
        info "loading $name from $file"
        export $name=$(<"$file")  # Load contents of file.
        # Note: The bash syntax `$(<file)` is equivalent to `$(cat file)`.
    else
        err "'$name' is not a valid variable name."
        log "  Variable names must start with an underscore or letter,"
        log "  and must contain only underscores, letters, and digits."
        return 1
    fi
}

# Load all environment variables defined in the env directory.
load-all () {
    local name
    info "loading environment from $ENV_DIR"
    for name in $(list-names); do
        load "$name"
    done
}

# List all variables defined in the env directory.
list-names () {
    local env_files file name
    if ! test -d "$ENV_DIR"; then
        err "env directory not found at $ENV_DIR"
        return 1
    fi
    env_files=$(find "$ENV_DIR" -name "*$ENV_SUFFIX")
    if ! test "$env_files"; then
        warn "no .env files found in $ENV_DIR"
        return 0
    fi
    # Don't read lines with `for`, to avoid strange bugs.
    # See http://mywiki.wooledge.org/DontReadLinesWithFor
    while IFS= read -r file; do
        name=$(basename "$file" "$ENV_SUFFIX")
        if valid-name "$name"; then
            if special-name "$name"; then
                warn "skipping $file: $name is not safe to modify"
            else
                printf '%s\n' "$name"
            fi
        else
            warn "skipping $file: '$name' is not a valid variable name"
        fi
    done <<<"$env_files"
}

# Print export statements for the current variables, handling escaping.
print-exports () {
    local name file value
    for name in $(list-names); do
        file=$ENV_DIR/$name$ENV_SUFFIX
        value=$(<"$file")  # Load contents of file.
        printf 'export %s=%q\n' "$name" "$value"
    done
}
