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

function aiflint_enter(data)
        local player = Player:new(data.player);
        a_whisper_npc(flint, "Welcome to Boat Wars! - Test", player);
         soundblock:playSound('NOTE_PLING', 1000, 10);
         soundblock:playSound('ORB_PICKUP', 1000, 10);
end

registerHook("REGION_ENTER", "bw-enter", "aiflint_enter");

--PvP
--

--PvP Respawn
--

--PvE
--


--Loot Table
--
