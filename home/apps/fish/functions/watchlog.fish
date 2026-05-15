function watchlog
    tail -f $argv[1] | bat -pp -l cclog
end