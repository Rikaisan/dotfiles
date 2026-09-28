function anidir
    mkname $argv
	ani-dl $argv
    for f in *.vtt
        ffmpeg -i $f $(string replace ".vtt" ".ass" $f)
    end
end