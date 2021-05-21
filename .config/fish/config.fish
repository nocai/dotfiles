set PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
set -x EDITOR nvim

set fish_greeting

functions --copy cd standard_cd
function cd
    standard_cd $argv; and exa --classify
end

function update_fasd_db --on-event fish_preexec
    fasd --proc (fasd --sanitize (eval echo $argv) | string split -n " ") &>/dev/null
end
