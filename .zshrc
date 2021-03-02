# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# prompt
fpath+=$HOME/.zsh/pure
zstyle :prompt:pure:git:stash show yes

# znap
zstyle ':znap:*' plugins-dir ~/.znap
source ~/.znap/zsh-snap/znap.zsh

# nnn
 export NNN_BMS='d:~/Documents;n:~/Documents/Downloads;l:~/Local;g:~/git;c:~/.config'
 export NNN_PLUG='d:diffs;p:preview-tui;s:suedit;t:treeview;r:renamer'
 export NNN_FIFO=/tmp/nnn.fifo

# autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^ ' autosuggest-accept

znap prompt pure
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions
znap source Aloxaf/fzf-tab
znap source wookayin/fzf-fasd
znap source zdharma/fast-syntax-highlighting
znap source lukechilds/zsh-better-npm-completion

znap eval fasd-init 'fasd --init auto'

# other sources
source ~/.zsh/opts.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.fzf.zsh
