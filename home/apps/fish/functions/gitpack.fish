function gitpack
	set -l name (pwd | string split -r -m1 -f2 '/')
	git archive HEAD --prefix "$name/" > "$name.tar.gz"
end