export GOROOT=$HOME/go
export GOPATH=$HOME/mygo
PATH=$PATH:$HOME/bin:$HOME/.rbenv/bin:$GOPATH/bin:$GOROOT/bin:/usr/local/Cellar/git/2.7.2/bin:
export PATH
PATH=/usr/local/heroku/bin:$PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH:/Applications/MacVim.app/Contents/MacOS/

export PATH=$HOME/.rbenv/shims:$PATH
if [ -d ${HOME}/.rbenv ]; then
  eval "$(rbenv init -)"
fi
export SVN_EDITOR=vim
export PATH=$HOME/.nodebrew/current/bin:$PATH
export LESS='-i -g -M -R'
