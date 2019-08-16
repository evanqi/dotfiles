##############################################################
# bootstrap Square bash_profile; please don't change this bit.
##############################################################
if [[ -d "$HOME/Development" ]]; then
  SQUARE_HOME=$HOME/Development
fi
export SQUARE_HOME
if [[ -f "$SQUARE_HOME/config_files/square/bash_profile" ]]; then
  source $SQUARE_HOME/config_files/square/bash_profile
fi

export HOMEBREW_NO_ANALYTICS=1
##############################################################


###########################################
# Feel free to make your own changes below.
###########################################

source ~/.bash_local
source ~/.git-prompt.sh

# Print the current git author when the shell loads
if [[ -n $(which git) ]]; then
  printf "${COLOR_LIGHT_CYAN}Current git author:${COLOR_WHITE} ${GIT_AUTHOR_NAME:-$(git config user.name)} <${GIT_AUTHOR_EMAIL:-$(git config user.email)}>\n${COLOR_NC}"
fi

# vim: filetype=sh
export GOROOT=/usr/local/opt/go/libexec

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# This loads NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
