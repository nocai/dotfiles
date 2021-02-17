# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# prompt
fpath+=$HOME/.zsh/pure
zstyle :prompt:pure:git:stash show yes

# znap
zstyle ':znap:*' plugins-dir ~/.znap
source ~/.znap/zsh-snap/znap.zsh

znap prompt pure
znap source zsh-users/zsh-completions
znap source Aloxaf/fzf-tab
znap source wookayin/fzf-fasd
znap source zdharma/fast-syntax-highlighting

znap eval fasd-init 'fasd --init auto'

# other sources
source ~/.zsh/opts.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.fzf.zsh
