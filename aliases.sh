prohibit-subshells

alias please=sudo  # Mind your manners!
alias pseudo=sudo
alias nuke='rm -rf'
alias chmod-yolo='chmod 777'
alias kj='kill %'  # Kill Job

alias la='ls -Ab'
alias ll='ls -AbelGhiOT'
alias lll='ls -@AbelGhiOT'  # Include extended attributes (multiple lines)

# The bash keyword 'time' occludes the actual 'time' program; only the
# latter has the handy -l option. (bash keywords can't be disabled via
# `enable -n`.)
alias time='/usr/bin/env time'

alias ag="ag --pager 'bat --plain'"
alias aga='ag --all-types --hidden'
alias agp='ag --py'
alias agj='ag --js'

# alias ~~='subl --project ~/Dropbox/proj/home.sublime-project'
# alias pr='subl ~/profile'


alias pbc=pbcopy
alias pbp=pbpaste
alias pbr='printf 🍺'

alias gimp='open -a GIMP-2.10.app'
