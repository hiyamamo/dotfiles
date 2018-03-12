export GOPATH=$HOME/mygo
export PATH=$HOME/bin:$HOME/.rbenv/bin:$GOPATH/bin::/usr/local/Cellar/git/2.7.2/bin:$HOME/.rbenv/shims:$PATH

if [ -d ${HOME}/.rbenv ]; then
  eval "$(rbenv init -)"
fi
export SVN_EDITOR=vim
export LESS='-i -g -M -R'
