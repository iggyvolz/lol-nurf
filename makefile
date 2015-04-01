check:
	luacheck .
parse:
	rm -Rf stuff
	mkdir -p stuff
	mv data/$n stuff/data
	lua parse.lua
get:
	lua get.lua $n
