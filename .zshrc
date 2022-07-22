# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  1password
  asdf
  brew
  docker
  docker-compose
  fzf
  gitfast
  gpg-agent
  pipenv
  rake
  ripgrep
)

# FUNCTIONS
_has() {
  # Returns whether the given command is executable or aliased.
  return $( type $1 >/dev/null )
}

if _has aws; then plugins+=(aws); fi
if _has docker; then plugins+=(docker docker-compose); fi
if _has gcloud; then plugins+=(gcloud); fi
if _has helm; then plugins+=(helm); fi
if _has kubectl; then plugins+=(kubectl); fi
if _has vagrant; then plugins+=(vagrant); fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='vim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# ALIASES

alias be='bundle exec'
alias ber='bundle exec ruby'
alias gci='git commit --verbose'
alias gcis='git commit --gpg-sign --verbose'
alias gd='git diff --color=always'
alias gpoh='git push origin HEAD'
alias gpfoh='git push --force origin HEAD'
alias gri='git rebase -i'
alias grep='grep --color=auto -E'
alias gss='git status --short --branch'
alias ll='ls -lah'
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-synchronize="rsync -avzu --delete --progress -h"
alias rsync-update="rsync -avzu --progress -h"
if _has nvim; then
  alias vim=nvim
fi
alias vi="vim"
alias vim-update-plugins='vim +PlugUpdate +qall'
# Until this gets merged: https://github.com/ohmyzsh/ohmyzsh/pull/10994
if [[ "$TERM" == 'xterm-kitty' ]]; then
  alias kssh='kitty +kitten ssh'
  compdef kssh='ssh'
fi
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# FZF CONFIG
if _has fzf; then

export FZF_DEFAULT_OPTS='
--preview "[[ $(file --mime {}) =~ binary ]] &&
             echo {} is a binary file ||
             (highlight -O ansi {} ||
             cat {}) 2> /dev/null | head -$LINES"'


# Nord colors for fzf
# Generated here: https://minsw.github.io/fzf-color-picker/
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
 }

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
  local pid
  if [ "$UID" != "0" ]; then
      pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
      pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi

  if [ "x$pid" != "x" ]
  then
      echo $pid | xargs kill -${1:-9}
  fi
}

# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# List all vagrant boxes available in the system including its
# status, and try to access the selected one via ssh
vs(){
	cd $(cat ~/.vagrant.d/data/machine-index/index | jq '.machines[] | {name, vagrantfile_path, state}' | jq '.name + "," + .state  + "," + .vagrantfile_path'| sed 's/^"\(.*\)"$/\1/'| column -s, -t | sort -rk 2 | fzf | awk '{print $3}'); vagrant ssh
}

fi

# HISTORY CONFIG
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTDUP=erase               # Erase duplicates in the history file
setopt    appendhistory     # Append history to the history file (no overwriting)
setopt    sharehistory      # Share history across terminals
setopt    incappendhistory  # Immediately append to the history file, not just when a term is killed

alias h='history'

# HOMEBREW CONFIG
if _has brew; then
  # For the 5.0.x Homebrew'ed zsh installation...
  # unalias run-help
  autoload run-help
  HELPDIR=${HOMEBREW_PREFIX}/share/zsh/help

  # Opt out of Homebrew analytics
  export HOMEBREW_NO_ANALYTICS=1

  # Cask options
  HOMEBREW_CASK_OPTS="--appdir=~/Applications"
fi

# JQ CONFIG
# Some handy functions to make working with JSON simpler
if _has jq; then
  function jq-flatten() {
    jq -r '
    tostream
    | select(length > 1)
    | (
    .[0] | map(
    if type == "number"
    then "[" + tostring + "]"
    else "." + .
    end
    ) | join("")
    ) + " = " + (.[1] | @json)
    ' $*
  }

  function uptime.as() {
    curl --silent "https://get.uptime.is/api?sla=${1}" | jq .
  }
fi

# SYNTAX HIGHLIGHTING CONFIG
# This needs to be last in zshrc!
if [ -f ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/highlighters
fi

