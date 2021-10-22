# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/yamamoto/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="muse"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias zshconfig="vim ~/.zshrc"
alias gitconfig="vim ./.git/config"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias cdrails="cd ~/projects/bm_dev_chef/nfs_sync_dir/bm_on_rails"
alias cdphp="cd ~/projects/bm_dev_chef/nfs_sync_dir/php_apps"
alias cdgrunt="cd ~/projects/bm_dev_chef/nfs_sync_dir/bm-grunt-tasks"
alias cdchef="cd ~/projects/bm_dev_chef"
alias cdadmin="cd ~/projects/bm-admin-portable/src/buyma-admin"
alias cdstyling="cd ~/projects/buyma_styling/backend"
alias ctags="`brew --prefix`/bin/ctags"
alias ssh="TERM=xterm ssh"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias v="vagrant"
alias vssh="vagrant ssh"
alias vup="vagrant up"
alias y="yarn"
alias dc="docker-compose"
alias dspec="docker-compose exec spring bin/rspec"
alias kb="kubectl"

function peco-git-checkout () {
  local selected_branch=$(git branch -a | awk '{print $NF}'  | sed 's/remotes\/origin\///' | sort | uniq | peco)
  if [ -n "$selected_branch" ]; then
    git checkout ${selected_branch}
  fi
}

alias peck=peco-git-checkout

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N peco-src
bindkey '^]' peco-src
export PATH="/usr/local/sbin:$PATH"
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/yamamoto/.nodenv/versions/9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/yamamoto/.nodenv/versions/9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/yamamoto/.nodenv/versions/9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/yamamoto/.nodenv/versions/9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/yamamoto/.nodenv/versions/9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/yamamoto/.nodenv/versions/9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

alias shuttle=exec_sshuttle

function exec_sshuttle() {
  sshuttle --daemon --disable-ipv6 -r hiroki.yamamoto@tk.buyma.com \
    --pidfile /tmp/sshuttle.pid \
    106.186.74.106/32 106.186.74.107/32 \
    $(dig bmhistories-dc01-rw.d1.test.buyma.com +short | grep -v '[a-z]') \
    $(dig partners-test.buyma.com bm{items,trades}-0{1,2}.search-infra-dev.buyma.com \
    r.buyma.com postgres.personal-shopper-api-test.buyma.com postgres.personal-shopper-api.buyma.com argocd.srv-dev.buyma.com adminer.personal-shopper-api-test.buyma.com \
    personal-shopper-api.buyma.com partners.buyma.com personal-shopper-sandbox.buyma.com \
    adminer.personal-shopper-api.buyma.com b.buyma.com admin.buyma.com \
    japanpost.shipping.srv-test.buyma.com \
    japanpost.shipping.srv.buyma.com \
    postgres.japanpost.shipping.srv-test.buyma.com \
    postgres.japanpost.shipping.srv.buyma.com \
    specification.personal-shopper-api-test.buyma.com +short | sed 's@$@/32@')
}

alias curlish="PYENV_VERSION=2.7.15 curlish"
export PATH="$HOME/.buyma_utils/bin:$PATH"
alias sshp="SSHPASS=\`sudo cat ~/.ssh/.pass\` sshpass -e ssh"
alias sht=sshtunnel
