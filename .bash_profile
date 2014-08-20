# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


# User specific environment and startup programs


# export PATH="$HOME/.rbenv/bin:$PATH"
export GOROOT=$HOME/go
export GOPATH=$HOME/mygo
PATH=$PATH:$HOME/bin:$HOME/.rbenv/bin:$GOPATH/bin:$GOROOT/bin
export PATH
eval "$(rbenv init -)"
PATH=/usr/local/heroku/bin:$PATH
source ~/.git-completion.bash
