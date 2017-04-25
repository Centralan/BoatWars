local myWorld = World:new('BoatWars');
local soundblock = Location:new(world, 0, 100, 0);

--------
---AI---
--------

local Overlord = 'Captain Flint'
local Message = ''
local Message2 = ''

function a_broadcast(msg)
	myWorld:broadcast(msg);
end

function a_broadcast_npc(npc, msg)
	a_broadcast('&f&c' .. npc .. '&6: &f' .. msg);
end

function a_whisper_error(npc, msg, player)
	player:sendMessage('&f&c' .. npc .. '&c' .. msg);
end

function a_whisper_good(npc, msg, player)
	player:sendMessage('&f&c' .. npc .. '&f' .. msg);
end

------------------
---Lobby Timer---
------------------

local matchRunning = false;
local preMatchRunning = false;
local matchCheckTimer = Timer:new('s_match_check', 20 * 60); -- 1 minute
local matchTimer = Timer:new('s_match_stale', 18000); -- 15 minutes
local lobbyLoc = s_angled_loc(-31, 90, 45, -179.80754, -0.30817112);
local matchTick = Timer:new('s_match_tick', 20 * 5); -- 5 seconds
local sign = Location:new(myWorld, 16, 72, 39);
local playing = {};

------------------------
---Lobby Player Check---
------------------------

---------------------
--Teleports------
---------------------

local tolobby = Location:new(myWorld, 16, 72, 60);
--local tocovearena = Location:new(myWorld, 2999, 62, 3000);
