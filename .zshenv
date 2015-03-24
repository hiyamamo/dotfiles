export GOROOT=$HOME/go
export GOPATH=$HOME/mygo
export ANDROID_HOME=/var/lib/jenkins/android-sdk-linux
PATH=$PATH:$HOME/bin:$HOME/.rbenv/bin:$GOPATH/bin:$GOROOT/bin:$ANDROID_HOME/tools
export PATH
PATH=/usr/local/heroku/bin:$PATH

if [ -d ${HOME}/.rbenv ]; then
  export PAHT=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
  . ~/.rbenv/completions/rbenv.zsh
fi
