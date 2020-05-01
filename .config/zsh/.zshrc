export ZSH=$HOME/.config/zsh
export ZSH_CUSTOM=$HOME/.my-zsh

setopt autocd # Automatically cd into typed directory.
stty stop undef # Disable ctrl-s to freeze terminal.

# Color-theme
# Enable colors and change prompt:
autoload -U colors && colors
setopt prompt_subst
ZSH_THEME_GIT_PROMPT_PREFIX=":("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"
[ -f $ZSH/git.zsh ] && source $ZSH/git.zsh
PS1='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}:%~%{$fg[red]%}]%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%}$%b '

# History:
HIST_STAMPS="yyyy-mm-dd"
[ -f $ZSH/history.zsh ] && source $ZSH/history.zsh
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh_history

# COM-alias
[ -f $ZSH/aliasrc ] && source $ZSH/aliasrc

# SSH-alias
if [ -f ~/.ssh/ssh_connection ]; then
  source ~/.ssh/ssh_connection
fi


# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zmodload zsh/complist
setopt completealiases
compinit
_comp_options+=(globdots) # Include hidden files

# Emacs-mode
bindkey -e
export KEYTIMEOUT=1
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# Edit the current command line in $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# FZF
# git clone --depth 1 https://github.com/junegunn/fzf.git
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'

# Plugins
[ -f $ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
