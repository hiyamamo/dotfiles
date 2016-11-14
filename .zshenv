export GOROOT=$HOME/go
export GOPATH=$HOME/mygo
PATH=$PATH:$HOME/bin:$HOME/.rbenv/bin:$GOPATH/bin:$GOROOT/bin:/usr/local/Cellar/git/2.7.2/bin:
export PATH
PATH=/usr/local/heroku/bin:$PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH:/Applications/MacVim.app/Contents/MacOS/

if [ -d ${HOME}/.rbenv ]; then
  export PAHT=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi
export SVN_EDITOR=vim
export PATH=$HOME/.nodebrew/current/bin:$PATH
export JAVA_HOME=`/usr/libexec/java_home -v 1.7`
export MAVEN_HOME=$HOME/Projects/bm-admin-portable/opt/maven/default
export TOMCAT_HOME=$HOME/Projects/bm-admin-portable/opt/tomcat/default
export PATH=$MAVEN_HOME/bin:$PATH
