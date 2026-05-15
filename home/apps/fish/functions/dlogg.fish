function dlogg
    set -l file_name ($argv[2..] | string lower | string join "_")
    yt-dlp -x --audio-format wav -o $file_name.wav $argv[1]
    ffmpeg -i $file_name.wav $file_name.ogg
    rm $file_name.wav
end