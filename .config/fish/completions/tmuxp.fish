function get_sessions
    set -l sessions (ls $HOME/.config/tmuxp)
    for session in $sessions
        echo (string split -r -m1 . $session)[1]
    end
end

complete -f -c tmuxp -n "__fish_seen_subcommand_from load" -a "(get_sessions)"
