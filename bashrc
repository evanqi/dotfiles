# Path
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH"

# Colors ----------------------------------------------------------
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export CLICOLOR='1'

alias ls='ls -G'  # OS-X SPECIFIC - the -G command in OS-X is for colors, in Linux it's no groups
export LSCOLORS="gxDxFxdxCxExExhbadgxgx"

# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[1;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'

# Opt out of homebrew analytics collection
export HOMEBREW_NO_ANALYTICS=1

#### BASH History Options ####

# Number of lines to keep in the history file
export HISTSIZE=1000000
# bash history is timestamped as YYYY-MM-DD HH:MM:SS
export HISTTIMEFORMAT='%F %T '
# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

##############################

# After each command, update LINES and COLUMNS to reflect the current window size
shopt -s checkwinsize

load_git_prompt() {
  if [[ $(type -t __git_ps1) != "function" ]]; then
    source $SQUARE_HOME/config_files/square/git-prompt
  fi
}

# Make git prompt work for completion, primarily for Python virualenvs
load_git_prompt

export PS1="\[${COLOR_LIGHT_GRAY}\]\w\[${COLOR_NC}\]\[${COLOR_LIGHT_CYAN}\]\$(__git_ps1 \" %s\")\[${COLOR_NC}\] "
export PS2='> '
export PS3='#? '
export PS4='+ '
