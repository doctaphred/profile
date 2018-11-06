# This file is sourced by `__main__.sh`.
#
# Without it (or another .sh file in this directory), bash will complain "No
# such file or directory" when asked to loop over and source each element of
# `~/bash/source/*.sh`, as the glob fails to expand and is replaced with the
# literal string.
#
# There exists a `nullglob` option, but setting it interferes with other
# usages of globs, and resetting its original value after using it is
# complicated and gross (i.e., typical bash), same as testing the glob
# result's existence before looping, via `compgen` or `test -f`. (Plus, this
# documentation needs to appear *somewhere*...)
#
# Using `find` might be a better option. Maybe someday.
