function burnsubs
	set -l outname (string split -m1 -f1 . $argv[1]).mp4
	ffmpeg -i $argv[1] -vf "subtitles='$argv[1]'" $outname
end