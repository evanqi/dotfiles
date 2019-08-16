########################################################
# bootstrap Square bashrc; please don't change this bit.
########################################################
if [[ -f "$SQUARE_HOME/config_files/square/bashrc" ]]; then
  source $SQUARE_HOME/config_files/square/bashrc
fi
########################################################


###########################################
# Feel free to make your own changes below.
###########################################
source ~/.cawsrc
alias vi=vim
export EDITOR=vim
# alias ecrlogin="eval $(EC2_ROLE=deployer ec2-exec aws --region us-east-1 ecr get-login)"

sssh() {
    eval "$(ssh-agent -s)"
    ssh-add -K
}

ecrlogin() {
    EC2_ROLE=engineer ec2-exec aws --region us-east-1 ecr get-login | $SHELL
}

alias docker-memcached='docker run --rm -d -p 11211:11211 memcached:1.4.33'
alias docker-redis='docker run -d -p 6379:6379 redis:3.2.4'
alias st='~/go.sh'
alias rubocopg='git diff-tree -r --no-commit-id --name-only head origin/master | xargs rubocop --force-default-config'

# uncomment to automatically `bundle exec` common ruby commands
# if [[ -f "$SQUARE_HOME/config_files/square/bundler-exec.sh" ]]; then
#   source $SQUARE_HOME/config_files/square/bundler-exec.sh
# fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
