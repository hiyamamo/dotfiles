export GOROOT=$HOME/go
export GOPATH=$HOME/mygo
export GEM_HOME=~/extlib/gems
PATH=$PATH:$HOME/bin:$HOME/.rbenv/bin:$GOPATH/bin:$GOROOT/bin:/usr/local/Cellar/git/2.7.2/bin:$GEM_HOME/bin:
export PATH
PATH=/usr/local/heroku/bin:$PATH

if [ -d ${HOME}/.rbenv ]; then
  export PAHT=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
  . ~/.rbenv/completions/rbenv.zsh
fi
export SVN_EDITOR=vim
export PATH=$HOME/.nodebrew/current/bin:$PATH
