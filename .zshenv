export GOROOT=$HOME/go
export GOPATH=$HOME/mygo
export PATH=$PATH:$HOME/bin:$HOME/.rbenv/bin:$GOPATH/bin:$GOROOT/bin:/usr/local/Cellar/git/2.7.2/bin:

export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.rbenv/shims:$PATH
if [ -d ${HOME}/.rbenv ]; then
  eval "$(rbenv init -)"
fi
export SVN_EDITOR=vim
export PATH=$HOME/.nodebrew/current/bin:$PATH
export LESS='-i -g -M -R'
