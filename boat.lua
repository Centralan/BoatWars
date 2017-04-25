-- AI
--

local world = World:new('BoatWars');
local soundblock = Location:new(world, 0, 100, 0);
local ai = 'flint'
local Rules = ''

function a_broadcast(msg)
	world:broadcast(msg);
end

function a_broadcast_npc(npc, msg)
	a_broadcast('&f &b' .. npc .. '&f: ' .. msg);
end

function a_whisper_npc(npc, msg, player)
	player:sendMessage('&b[BW]&7Captain Flint &b' .. npc .. ' &3-> &f' .. msg);
end

--PvP
--

--PvP Respawn
--

--PvE
--


--Loot Table
--
