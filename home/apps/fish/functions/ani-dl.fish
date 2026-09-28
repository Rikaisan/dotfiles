function ani-dl
	ani-cli -d -e 1-1 $argv
	for f in *.vtt
        ffmpeg -i $f $(string replace ".vtt" ".ass" $f)
    end
end