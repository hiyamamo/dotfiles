export PATH=~/.local/bin:/usr/local/bin:$PATH
source ~/dotfiles/.zshenv
setopt no_global_rcs
# Load nodenv automatically by appending
# the following to ~/.zshrc:

eval "$(nodenv init -)"
export PATH=~/.nodenv/shims:~/bin:$PATH
eval "$(hub alias -s)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(direnv hook zsh)"
eval $(thefuck --alias)
