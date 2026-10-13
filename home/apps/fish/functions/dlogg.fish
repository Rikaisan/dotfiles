function dlogg
    set -l file_name ($argv[2..] | nameify)
    yt-dlp -x --audio-format wav -o $file_name.wav $argv[1]
    ffmpeg -i $file_name.wav $file_name.ogg
    rm $file_name.wav
end