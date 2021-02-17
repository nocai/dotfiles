# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden'
REVERSE_TAB="--bind tab:toggle-out,shift-tab:toggle-in"
SWITCH_SOURCES="--bind 'ctrl-d:reload(fd . --type d),ctrl-f:reload($FZF_DEFAULT_COMMAND)'"
export FZF_DEFAULT_OPTS="$REVERSE_TAB $SWITCH_SOURCES"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# prompt
fpath+=$HOME/.zsh/pure

# znap
zstyle ':znap:*' plugins-dir ~/.znap
source ~/.znap/zsh-snap/znap.zsh

znap prompt pure
znap source Aloxaf/fzf-tab
znap source zdharma/fast-syntax-highlighting

znap eval fasd-init 'fasd --init auto'

# other sources
source ~/.zsh/opts.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.fzf.zsh
