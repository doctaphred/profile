prohibit-subshells

alias please=sudo  # Mind your manners!
alias pseudo=sudo
alias nuke='rm -rf'
alias chmod-yolo='chmod 777'
alias kj='kill %'  # Kill Job

alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -Alh'
alias lal='ls -Alh'
alias lah='ls -lAh'

alias edit='subl --new-window'
alias e=edit

# The bash keyword 'time' occludes the actual 'time' program; only the
# latter has the handy -l option. (bash keywords can't be disabled via
# `enable -n`.)
alias time='/usr/bin/env time'

alias ag='ag --smart-case --pager "less -R -S"'
alias aga='ag --smart-case --pager "less -R -S" --skip-vcs-ignores'
alias agp='ag --py'
alias agj='ag --js'

# alias ~~='subl --project ~/Dropbox/proj/home.sublime-project'
# alias pr='subl ~/profile'


alias pbc=pbcopy
alias pbp=pbpaste
alias pbr='printf 🍺'

alias gimp='open -a GIMP-2.10.app'
