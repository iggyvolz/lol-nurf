local fkey=io.open(".settings/key","r")
local key=fkey:read("all")
fkey:close()
local riot=require "riot"("na",key)
local fnum=io.open(".data/NUM","r")
local num=fnum:read("all")
fnum:close()
local f=io.open(".data/"..num,"w")
f:write("return "..require "pl.pretty".write(riot.match("na",1770521644)))
f:close()
local nfnum=io.open(".data/NUM","w")
nfnum:write(num+1)
nfnum:close()