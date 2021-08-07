export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--bind tab:toggle-out,shift-tab:toggle-in"
export FZF_ALT_C_COMMAND='fd --type d --hidden'

export NNN_BMS='d:~/Documents;n:~/Documents/Downloads;l:~/Local;g:~/git;c:~/.config;v:~/.config/nvim'
export NNN_OPTS='Heo'
export NNN_COLORS='4321'

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

fpath+=$HOME/.config/zsh/pure
zstyle :prompt:pure:git:stash show yes
autoload -U promptinit; promptinit
prompt pure

zstyle ':znap:*' repos-dir ~/.config/zsh/plugins
source ~/.config/zsh/zsh-snap/znap.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
bindkey '^Y' autosuggest-execute
bindkey '^ ' autosuggest-accept

znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions
znap source Aloxaf/fzf-tab
znap source wookayin/fzf-fasd
znap source zdharma/fast-syntax-highlighting
znap source lukechilds/zsh-better-npm-completion

znap eval fasd 'fasd --init auto'
znap eval pyenv 'pyenv init -'

[ -f ~/.config/zsh/opts.zsh ] && source ~/.config/zsh/opts.zsh
[ -f ~/.config/zsh/functions.zsh ] && source ~/.config/zsh/functions.zsh
[ -f ~/.config/zsh/aliases.zsh ] && source ~/.config/zsh/aliases.zsh
[ -f ~/.config/zsh/fzf.zsh ] && source ~/.config/zsh/fzf.zsh 
