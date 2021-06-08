#███████╗███████╗██╗  ██╗██████╗  ██████╗
#╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝
#  ███╔╝ ███████╗███████║██████╔╝██║
# ███╔╝  ╚════██║██╔══██║██╔══██╗██║
#███████╗███████║██║  ██║██║  ██║╚██████╗
#╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

# ==============================================================================
# THEME
# ==============================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

# ==============================================================================
# PATH
# ==============================================================================
# alias python to python3 as who the hell is using 2.7 any more?
# https://opensource.com/article/19/5/python-3-default-mac
alias python='python3'
alias pip='pip3'

# Path to your oh-my-zsh installation.
export ZSH="/Users/gk/.oh-my-zsh"

# ==============================================================================
# PLUGINS
# ==============================================================================
plugins=(
    git
    brew
    colored-man-pages
    virtualenv
    python
    vscode
    colorize
    command-not-found
    osx
    )

source $ZSH/oh-my-zsh.sh

# ==============================================================================
# USER CONFIG
# ==============================================================================
# Enable command auto-correction.
# ENABLE_CORRECTION="true"
export BAT_THEME="OneHalfDark"

# ==============================================================================
# ALIASES
# ==============================================================================
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias zshconfig="code ~/.zshrc"
alias ohmyzsh="cMarkdownode ~/.oh-my-zsh"
alias cat="bat"
alias la="ls -a"
alias ll="ls -la"
alias vim="nvim"

# Dotfile Management - https://www.atlassian.com/git/tutorials/dotfiles
alias config="/opt/homebrew/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# ==============================================================================
# FISH Features
# ==============================================================================
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ==============================================================================
# NVMMarkdown
# ==============================================================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize Markdownprompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ==============================================================================
# FZF
# ==============================================================================

if type rg %> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# source /usr/share/fzf/completion.zsh
# source /usr/share/fzf/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ==============================================================================
# Oracle Instanclient
# http://mikelynchgames.com/software-development/installing-oracle-instant-client-and-sqlplus-on-osx/
# install via homebrew
# https://vanwollingenMarkdown.nl/install-oracle-instant-client-and-sqlplus-using-homebrew-a233ce224bf
# Homebrew tap
# https://github.com/InstantClientTap/homebrew-instantclient
# ==============================================================================
export ORACLE_HOME=/opt/homebrew/Cellar/instantclient-basic/19.8.0.0.0dbru
export DYLD_LIBRARY_PATH=$ORACLE_HOME
export LD_LIBRARY_PATH=$ORACLE_HOME
export TNS_ADMIN=$HOME/etc

