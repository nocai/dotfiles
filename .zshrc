# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--bind tab:toggle-out,shift-tab:toggle-in,alt-j:preview-down,alt-k:preview-up"
export FZF_ALT_C_COMMAND='fd --type d --hidden'

# prompt
fpath+=$HOME/.zsh/pure
zstyle :prompt:pure:git:stash show yes
autoload -U promptinit; promptinit
prompt pure

# znap
zstyle ':znap:*' plugins-dir ~/.znap
source ~/.znap/zsh-snap/znap.zsh

# autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^ ' autosuggest-accept

znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions
znap source Aloxaf/fzf-tab
znap source wookayin/fzf-fasd
znap source zdharma/fast-syntax-highlighting
znap source lukechilds/zsh-better-npm-completion

eval "$(fasd --init auto)"

# other sources
source ~/.zsh/opts.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.fzf.zsh
