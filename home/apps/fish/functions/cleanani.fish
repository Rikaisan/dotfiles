function cleanani
    ls | grep .part | cut -d "." -f 1 | xargs -I _ sh -c "echo _ && rm _.vtt _.mp4.ytdl _.mp4.part"
end