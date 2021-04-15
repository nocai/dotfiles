function mkcd
    if test -d $argv
        cd $argv
    else
        mkdir -p $argv && cd $argv
    end
end
