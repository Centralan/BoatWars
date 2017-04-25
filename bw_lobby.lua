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

------------
----Table---
------------

function t_copy (t) -- shallow-copy a table
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do target[k] = v end
    setmetatable(target, meta)
    return target
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

--Player spawn locations
local startLocations = {
	s_angled_loc( 2989, 62, 3026, 91.0, 6.0),
	s_angled_loc( 2987, 62, 3030, 178.8, 6.8),

------------------------------------
---Lobby Player Check/Match Start---
------------------------------------

function s_within_bounds(player, lX, lY, lZ, hX, hY, hZ)
	local myWorld, x, y, z = player:getLocation();
	return x >= lX and y >= lY and z >= lZ and x <= hX and y <= hY and z <= hZ;
end

function s_get_players_in_lobby()
	local lobbyPlayers = {};
	local players = {myWorld:getPlayers()};
 
	for index, playerName in pairs(players) do
		local player = Player:new(playerName);
		if s_within_bounds(player, -11, 45, -20, 45, 154, 92) then
			table.insert(lobbyPlayers, player);
		end
	end
	return lobbyPlayers;
end

function s_get_players_in_match()
	local matchPlayers = {};
	local players = {myWorld:getPlayers()};
 
	for index, playerName in pairs(players) do
		local player = Player:new(playerName);
		if s_within_bounds(player, 2953, 61, 3001, 2998, 109, 3046) and not s_within_bounds(player, -11, 45, -20, 45, 154, 92) then
			table.insert(matchPlayers, player);
		end
	end
	return matchPlayers;
end

function s_match_start()
	matchRunning = true;
	
	local availableLocations = t_copy(startLocations);
	for index, player in pairs(s_get_players_in_lobby()) do
		if #availableLocations > 0 then
			local randomLocIndex = math.random(1, #availableLocations);
			player:clearInventory();
			player:teleport(availableLocations[randomLocIndex]);
			--table.insert(playing, player);
			playing[player.name] = true;
			table.remove(availableLocations, randomLocIndex);
			a_whisper_good(Overlord, player.name .. " Boat Wars has begun, sink your rivals!");
		else
			a_whisper_error(Overlord, player.name .. " Sorry, there are no more available spaces in this match!");
		end
	end

	matchTimer:start();
	matchTick:start();
end

---------------------
--Teleports------
---------------------

local tolobby = Location:new(myWorld, 16, 72, 60);
local tocovearena = Location:new(myWorld, 2999, 62, 3000);
