# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Completion config
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' menu select=5
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Loads
autoload -Uz compinit
compinit

# Sources
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source ~/.local/src/zsh-autosuggestions/zsh-autosuggestions.zsh

# Exports
export GTK_USE_PORTAL=0
export GPG_TTY=$TTY

# Fpath
fpath=(~/.local/src/zsh-completions/src $fpath)

# Aliases
alias grep="grep --color=auto"
alias ls="lsd -lh"
alias lsa="lsd -lhA"
alias pipes="pipes.sh -f 30"
eval $(thefuck --alias)
alias tlmgr="/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"

# Aliases for my inner dumbass
alias yya="yay"
alias ayy="yay"
alias нфн="yay"
alias ннф="yay"
alias фнн="yay"

# Binds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^H" backward-kill-word

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
