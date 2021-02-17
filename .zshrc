# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden'
REVERSE_TAB="--bind tab:toggle-out,shift-tab:toggle-in"
SWITCH_SOURCES="--bind 'ctrl-d:reload(fd . --type d),ctrl-f:reload($FZF_DEFAULT_COMMAND)'"
export FZF_DEFAULT_OPTS="$REVERSE_TAB $SWITCH_SOURCES"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# zsh-vim-mode
MODE_CURSOR_VIINS="steady bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="steady block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"
MODE_INDICATOR=""

# prompt
fpath+=$HOME/.zsh/pure

# znap plugins
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
