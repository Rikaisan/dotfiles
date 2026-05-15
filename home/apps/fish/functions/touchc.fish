function touchc
	printf "#pragma once\n" >> "$argv[1].h"
	printf "#include \"$argv[1].h\"\n" >> "$argv[1].c"
end