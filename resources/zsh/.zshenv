##
# .zshenv
#
# Define variables when shell start.

# ----------------------------------------------------------------------------
# XDG Environments
#   see:
#     - https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
#     - https://www.freedesktop.org/software/systemd/man/file-hierarchy.html#Runtime%20Data
#
#   on mac: (not in used)
#     - https://stackoverflow.com/questions/3373948/equivalents-of-xdg-config-home-and-xdg-data-home-on-mac-os-x/5084892
#     - https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW1

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"
#export XDG_RUNTIME_DIR="/run/user/$USER"

# ----------------------------------------------------------------------------
# Languages

export LC_ALL=en_US.UTF-8

# ----------------------------------------------------------------------------
# Tools

export JLESSCHARSET=UTF-8
export LV=-Ou8

#export EDITOR=vi
#export SVN_EDITOR=vi
export EDITOR=nvim
export SVN_EDITOR=nvim




# ----------------------------------------------------------------------------
# Paths

path=(
  /usr/local/opt/sqlite/bin
  $path
)

fpath=(
  /usr/local/share/zsh-completions
  $fpath
)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yudoufu/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/yudoufu/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yudoufu/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/yudoufu/opt/google-cloud-sdk/completion.zsh.inc'; fi
