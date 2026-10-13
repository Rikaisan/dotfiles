function mkname
    set -l file_name (nameify $argv)
    mkdir -p $file_name && cd $file_name
end