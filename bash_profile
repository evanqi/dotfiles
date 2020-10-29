if [[ -z $SQUARE_HOME ]]; then
  if [[ -d "$HOME/Development" ]]; then
    export SQUARE_HOME=$HOME/Development
  fi
fi

export LC_CTYPE="en_US.UTF-8"

# Reset umask to default
umask 022

# Allow more open files than the OSX default of 256
ulimit -n 4096

# Add your bin folder to the path, if you have it.  It's a good place to add all your scripts
if [[ -d "$HOME/bin" ]]; then
  export PATH="$HOME/bin:$PATH"
fi

if [[ -d $HOME/.bash_completion.d ]]; then
  for i in $(LC_ALL=C command ls "$HOME/.bash_completion.d"); do
    source "$HOME/.bash_completion.d/$i"
  done
fi
unset i

# In case the user does not have git completion
function __git_ps1() {
  echo ''
}

if [ $BASH_VERSINFO -ge 4 ]; then
  if [[ -n $(which brew) && -f $(brew --prefix)/share/bash-completion/bash_completion ]]; then
    . $(brew --prefix)/share/bash-completion/bash_completion
  fi
elif [ $BASH_VERSINFO -eq 3 ]; then
  if [[ -n $(which brew) && -f $(brew --prefix)/etc/bash_completion ]]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

if [[ -d "/usr/local/sbin" ]]; then
  export PATH="$PATH:/usr/local/sbin"
fi

export GIT_PS1_SHOWDIRTYSTATE=true

[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

# source the scripts in square/profile.d/
source $(dirname "${BASH_SOURCE[0]}")/profile

# vim: filetype=sh
