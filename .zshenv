export GOROOT=$HOME/go
export GOPATH=$HOME/mygo
PATH=$PATH:$HOME/bin:$HOME/.rbenv/bin:$GOPATH/bin:$GOROOT/bin:
export PATH
PATH=/usr/local/heroku/bin:$PATH

if [ -d ${HOME}/.rbenv ]; then
  export PAHT=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
  . ~/.rbenv/completions/rbenv.zsh
fi
