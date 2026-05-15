function mkname
    set -l file_name (string lower $argv | string replace -a '-' ' ' | string replace -a "[[:punct:]]|’" "" | string replace -a ' ' '_' | string join "_")
    mkdir -p $file_name && cd $file_name
end