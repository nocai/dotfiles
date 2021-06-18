function untilfail
    set -g _success_count 1

    function on_fail_or_exit --on-job-exit %self
        echo untilfail: ran $_success_count 'time(s)'
        functions -e on_fail_or_exit
        set -e _success_count
    end

    while $argv
        set -g _success_count (math $_success_count + 1)
    end

    on_fail_or_exit
end
