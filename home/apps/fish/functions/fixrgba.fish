function fixrgba
    mv $argv[1] "$argv[1].old"
	magick "$argv[1].old" -channel rgba -fx "u*a" $argv[1]
end