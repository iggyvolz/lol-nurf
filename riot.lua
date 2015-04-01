local function riot(rregion,key)
  assert(rregion,"rregion must be set")
  assert(key,"key must be set")
  local r={}
  r.__index=r
  local http=require "socket.http"
  local burl="https://"..rregion..".api.pvp.net"
  local decode = require("json.decode")
  local function req(data)
    local url=""..burl
    for i=1,#data do
      url=url.."/"..data[i]
    end
    return decode(http.request(url.."?api_key="..key))
  end
  function r.champion(region,id)
    assert(region,"region required")
    if id then
      return req{"api","lol",region,"v1.2","champion",id}
    else
      return req{"api","lol",region,"v1.2","champion"}
    end
  end
  function r.current_game(platformId,summonerId)
    assert(platformId,"platformId required")
    assert(summonerId,"summonerId required")
    return req{"observer-mode","rest","consumer","getSpectatorGameInfo",platformId,summonerId}
  end
  function r.featured_games()
    return req{"observer-mode","rest","featured"}
  end
  function r.game(region,summonerId)
    assert(region,"region required")
    assert(summonerId,"summonerId required")
    return req{"api","lol",region,"v1.3","game","by-summoner",summonerId,"recent"}
  end
  function r.league(region,mode,ids,entry) -- mode: true - by-summoner, false - by-team, nil - challenger
    assert(region,"region required")
    if mode==nil then
      return req{"api","lol",region,"v2.5","league","challenger"}
    end
    assert(ids,"Ids required if not using challenger")
    local uids=""
    for i=1,#ids do
      if i~=1 then uids=uids.."," end
      uids=uids..ids[i]
    end
    if mode then
      return req{"api","lol",region,"v2.5","league","by-summoner",uids,entry}
    else
      return req{"api","lol",region,"v2.5","league","by-team",uids,entry}
    end
  end
  function r.lol_static_data(region,point,id)
    assert(region,"region required")
    assert(point,"Point required")
    return req{"api","lol","static-data",region,"v1.2",point,id}
  end
  function r.lol_status(region)
    return req{"shards",region}
  end
  function r.match(region,matchId)
    assert(region,"region required")
    assert(matchId,"matchId required")
    return req{"api","lol",region,"v2.2","match",matchId}
  end
  function r.matchhistory(region,summonerId)
    assert(region,"region required")
    assert(summonerId,"summonerId required")
    return req{"api","lol",region,"v2.2","matchhistory",summonerId}
  end
  function r.stats(region,summonerId,ranked)
    assert(region,"region required")
    assert(summonerId,"summonerId required")
    return req{"api","lol",region,"v1.3","stats","by-summoner",summonerId,(ranked and "ranked" or "summary")}
  end
  function r.summoner(region,idsornames,special)
    assert(region,"region required")
    assert(type(idsornames)=="list","idsornames must be list")
    local uidsornames=""
    for i=1,#idsornames do
      if i~=1 then uidsornames=uidsornames.."," end
      uidsornames=uidsornames..idsornames[i]
    end
    assert(type(idsornames[1])=="string" or type(idsornames[1])=="number","type of idsornames must be string or number")
    return req{"api","lol",region,"v1.4","summoner",(type(idsornames[1])=="string" and "by-name" or nil),uidsornames,special}
  end
  function r.team(region,issummoner,ids)
    assert(region,"region required")
    assert(issummoner~=nil,"issummoner required")
    assert(ids,"ids required")
    local uids=""
    for i=1,#ids do
      if i~=1 then uids=uids.."," end
      uids=uids..ids[i]
    end
    return req{"api","lol",region,"v2.4","team",(issummoner and "by-summoner"),uids}
  end
  return r
end
return riot
