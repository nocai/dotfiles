set PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
set -x EDITOR nvim

set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x FZF_DEFAULT_OPTS '--bind tab:toggle-out,shift-tab:toggle-in,alt-j:preview-down,alt-k:preview-up'

set fish_greeting

functions --copy cd standard_cd
function cd
    standard_cd $argv; and exa --classify
end

function update_fasd_db --on-event fish_preexec
    fasd --proc (fasd --sanitize (eval echo $argv) | string split -n " ") &>/dev/null
end
