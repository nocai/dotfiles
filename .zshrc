# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# zsh-vim-mode
MODE_CURSOR_VIINS="steady bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="steady block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"
MODE_INDICATOR=""

# prompt
export PURE_CMD_MAX_EXEC_TIME=1
autoload -U promptinit; promptinit
prompt pure

source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
    zgen load Aloxaf/fzf-tab
    zgen load mroth/evalcache
    zgen load unixorn/autoupdate-zgen
    zgen load softmoth/zsh-vim-mode

    zgen load ~/.zsh/opts.zsh
    zgen load ~/.zsh/aliases.zsh
    zgen load ~/.zsh/functions.zsh

    zgen load ~/.fzf.zsh
    zgen load zdharma/fast-syntax-highlighting
    zgen save
fi

_evalcache rbenv init -
_evalcache pyenv init -
_evalcache fasd --init auto
