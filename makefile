check:
	luacheck .
parse:
	rm -Rf stuff
	cp -R dstuff stuff
	mkdir -p stuff/frames
	cp .data/$n stuff/data
	lua parse.lua
get:
	lua get.lua $n
