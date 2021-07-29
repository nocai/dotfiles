set -x EDITOR nvr-node
set -x DENO_INSTALL "/Users/jose/.deno"

set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x FZF_DEFAULT_OPTS '--bind tab:toggle-out,shift-tab:toggle-in'

set -x NNN_BMS 'd:~/Documents;n:~/Documents/Downloads;l:~/Local;g:~/git;c:~/.config;v:~/.config/nvim/lua'
set -x NNN_OPTS Heo
set -x NNN_COLORS 4231

set PATH /opt/homebrew/bin /opt/homebrew/sbin $HOME/.cargo/bin/ $HOME/go/bin $DENO_INSTALL/bin:$PATH $PATH

set fish_greeting

functions --copy cd standard_cd
function cd
    standard_cd $argv; and exa --classify
end

function update_fasd_db --on-event fish_preexec
    fasd --proc (fasd --sanitize (eval echo $argv) | string split -n " ") &>/dev/null
end
