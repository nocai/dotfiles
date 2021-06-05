set PATH /opt/homebrew/bin /opt/homebrew/sbin $HOME/.cargo/bin/ $PATH
set -x EDITOR nvim

set -x NNN_BMS 'd:~/Documents;n:~/Documents/Downloads;l:~/Local;g:~/git;c:~/.config;v:~/.config/nvim/lua'
set -x NNN_OPTS "Heo"

set fish_greeting
function fish_mode_prompt; end

fish_vi_cursor
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

functions --copy cd standard_cd
function cd
    standard_cd $argv; and exa --classify
end

function update_fasd_db --on-event fish_preexec
    fasd --proc (fasd --sanitize (eval echo $argv) | string split -n " ") &>/dev/null
end
