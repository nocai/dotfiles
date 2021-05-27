if status --is-interactive
    abbr -a -g mkdir 'mkdir -p'
    abbr -a -- - 'cd -'

    abbr -a -g n nnn

    abbr -a -g ni 'npm install'
    abbr -a -g nid 'npm install --save-dev'
    abbr -a -g ng 'npm install -g'
    abbr -a -g nr 'npm run'
    abbr -a -g ns 'npm start'
    abbr -a -g yd 'yarn add'
    abbr -a -g ydd 'yarn add --dev'
    abbr -a -g npmr 'npm run'

    abbr -a -g nv nvim
    abbr -a -g nvr nvr-node
    abbr -a -g nvf 'nvim -c Files'
    abbr -a -g nvn 'nvim -c NnnPicker'
    abbr -a -g nvg 'nvim -c Git'
    abbr -a -g nvp 'nvim -c PackerSync'
    abbr -a -g vimdiff 'nvim -d'

    abbr -a -g b brew
    abbr -a -g bi 'brew install'
    abbr -a -g bu 'brew uninstall'
    abbr -a -g bubu 'brew update && brew upgrade'
    abbr -a -g bs 'brew search'

    abbr -a -g exa 'exa --icons --classify'
    abbr -a -g ext 'exa --tree --level'

    abbr -a -g tl 'tmux list-sessions'
    abbr -a -g td 'tmux detach'
    abbr -a -g ta 'tmux attach-session -t'
    abbr -a -g tn 'tmux new-session -s'
    abbr -a -g tksv 'tmux kill-server'
    abbr -a -g tkss 'tmux kill-session -t'

    abbr -a -g mx tmuxinator
    abbr -a -g mxs 'tmuxinator start'
    abbr -a -g mxe 'tmuxinator edit'
    abbr -a -g mxn 'tmuxinator new'
    abbr -a -g mxc 'tmuxinator copy'

    abbr -a -g g git
    abbr -a -g lg lazygit
    abbr -a -g ga 'git add'
    abbr -a -g gd 'git diff'
    abbr -a -g gc 'git commit -v'
    abbr -a -g gco 'git checkout'
    abbr -a -g gcl 'git clone'
    abbr -a -g gm "git merge"
    abbr -a -g gp 'git push'
    abbr -a -g gf 'git fetch'
    abbr -a -g gl "git pull"
    abbr -a -g gst 'git status --short'
end
