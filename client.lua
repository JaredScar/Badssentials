--------------------
--- Badssentials ---
--------------------
function Draw2DText(x, y, text, scale, center)
    -- Draw text on screen
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    if center then 
    	SetTextJustification(0)
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
AddEventHandler('onClientMapStart', function()
	Citizen.Trace("RPRevive: Disabling le autospawn.")
	exports.spawnmanager:spawnPlayer() -- Ensure player spawns into server.
	Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
	Citizen.Trace("RPRevive: Autospawn is disabled.")
end)
deadCheck = false;
Citizen.CreateThread(function()
	while true do 
		Wait(0);
		local ped = GetPlayerPed(-1);
		if IsEntityDead(ped) then 
			Draw2DText(.5, .3, "~r~You are knocked out or dead...", 1.0, 1);
			Draw2DText(.5, .4, "~b~You may use ~g~/revive ~b~if you were knocked out", 1.0, 1);
			Draw2DText(.5, .5, "~b~If you are dead, you must use ~g~/respawn", 1.0, 1);
		end
		if IsEntityDead(ped) and not deadCheck then
			deadCheck = true;
			TriggerServerEvent("Badssentials:DeathTrigger");
		else 
			if not IsEntityDead(ped) then 
				deadCheck = false;
				StopScreenEffect("DeathFailOut")
			end 
		end
	end
end)
function revivePed(ped)
    local playerPos = GetEntityCoords(ped, true)
    isDead = false
    timerCount = reviveWait
    NetworkResurrectLocalPlayer(playerPos, true, true, false)
    SetPlayerInvincible(ped, false)
    ClearPedBloodDamage(ped)
    deadCheck = false;
end
RegisterNetEvent('Badssentials:RevivePlayer')
AddEventHandler('Badssentials:RevivePlayer', function()
	local ped = GetPlayerPed(-1);
	if IsEntityDead(ped) then 
		revivePed(ped);
	end
end)
RegisterNetEvent('Badssentials:RespawnPlayer')
AddEventHandler('Badssentials:RespawnPlayer', function()
	local ped = GetPlayerPed(-1);
	if IsEntityDead(ped) then 
		revivePed(ped);
		SetEntityCoords(ped, 1828.43, 3693.01, 34.22, false, false, false, false);
		SetEntityCoords(entity, xPos, yPos, zPos, xAxis, yAxis, zAxis, clearArea)
	end
end)
tickDegree = 0;
local nearest = nil;
local postals = Postals;
function round(num, numDecimalPlaces)
  if numDecimalPlaces and numDecimalPlaces>0 then
    local mult = 10^numDecimalPlaces
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end
currentTime = "0:00";
RegisterNetEvent('Badssentials:SetTime')
AddEventHandler('Badssentials:SetTime', function(time)
	currentTime = time;
end)
currentDay = 1;
RegisterNetEvent('Badssentials:SetDay')
AddEventHandler('Badssentials:SetDay', function(day)
	currentDay = day;
end)
currentMonth = 1;
RegisterNetEvent('Badssentials:SetMonth')
AddEventHandler('Badssentials:SetMonth', function(month)
	currentMonth = month;
end)
currentYear = "2021";
RegisterNetEvent('Badssentials:SetYear')
AddEventHandler('Badssentials:SetYear', function(year)
	currentYear = year;
end)
peacetime = false;
function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, false)
end
currentAOP = "Sandy Shores"
RegisterNetEvent('Badssentials:SetAOP')
AddEventHandler('Badssentials:SetAOP', function(aop)
	currentAOP = aop;
end)
RegisterNetEvent('Badssentials:SetPT')
AddEventHandler('Badssentials:SetPT', function(pt)
	peacetime = pt;
end)
displaysHidden = false;
RegisterCommand("toggle-hud", function()
	displaysHidden = not displaysHidden;
	TriggerEvent('Badger-Priorities:HideDisplay')
	if displaysHidden then 
		DisplayRadar(false);
	else 
		DisplayRadar(true);
	end
end)
RegisterCommand("postal", function(source, args, raw)
	if #args > 0 then 
		local postalCoords = getPostalCoords(args[1]);
		if postalCoords ~= nil then 
			-- It is valid 
			SetNewWaypoint(postalCoords.x, postalCoords.y);
			TriggerEvent('chatMessage', Config.Prefix .. "Your waypoint has been set to postal ^5" .. args[1]);
		else 
			TriggerEvent('chatMessage', Config.Prefix .. "^1ERROR: That is not a valid postal code...");
		end
	else 
		SetWaypointOff();
		TriggerEvent('chatMessage', Config.Prefix .. "Your waypoint has been reset!");
	end
end)
function getPostalCoords(postal)
	for _, v in pairs(postals) do 
		if v.code == postal then 
			return {x=v.x, y=v.y};
		end
	end
	return nil;
end
zone = nil;
streetName = nil;
postal = nil;
postalDist = nil;
degree = nil;
Citizen.CreateThread(function()
	while true do 
		Wait(150);
		local pos = GetEntityCoords(PlayerPedId())
		local playerX, playerY = table.unpack(pos)
		local ndm = -1 -- nearest distance magnitude
		local ni = -1 -- nearest index
		for i, p in ipairs(postals) do
			local dm = (playerX - p.x) ^ 2 + (playerY - p.y) ^ 2 -- distance magnitude
			if ndm == -1 or dm < ndm then
				ni = i
				ndm = dm
			end
		end

		--setting the nearest
		if ni ~= -1 then
			local nd = math.sqrt(ndm) -- nearest distance
			nearest = {i = ni, d = nd}
		end
		postal = postals[nearest.i].code;
		postalDist = round(nearest.d, 2);
		local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
		zone = GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z));
		degree = degreesToIntercardinalDirection(GetCardinalDirection());
		streetName = GetStreetNameFromHashKey(var1);
	end 
end)
Citizen.CreateThread(function()
	Wait(800);
	while true do 
		Wait(0);
		if peacetime then 
			if IsControlPressed(0, 106) then
                ShowInfo("~r~Peacetime is enabled. ~n~~s~You can not shoot.")
            end
            SetPlayerCanDoDriveBy(player, false)
            DisablePlayerFiring(player, true)
            DisableControlAction(0, 140) -- Melee R
		end
		for _, v in pairs(Config.Displays) do 
			local x = v.x;
			local y = v.y;
			local enabled = v.enabled;
			if enabled and not displaysHidden then 
				local disp = v.display;
				if (disp:find("{NEAREST_POSTAL}") or disp:find("{NEAREST_POSTAL_DISTANCE}")) then 
					disp = disp:gsub("{NEAREST_POSTAL}", postal);
					disp = disp:gsub("{NEAREST_POSTAL_DISTANCE}", postalDist)
				end
				if (disp:find("{STREET_NAME}")) then 
					disp = disp:gsub("{STREET_NAME}", streetName);
				end 
				if (disp:find("{CITY}")) then 
					disp = disp:gsub("{CITY}", zone);
				end
				if (disp:find("{COMPASS}")) then 
					disp = disp:gsub("{COMPASS}", degree);
				end
				disp = disp:gsub("{EST_TIME}", currentTime);
				disp = disp:gsub("{US_DAY}", currentDay);
				disp = disp:gsub("{US_MONTH}", currentMonth);
				disp = disp:gsub("{US_YEAR}", currentYear);
				disp = disp:gsub("{CURRENT_AOP}", currentAOP);
				if (disp:find("{PEACETIME_STATUS}")) then 
					if peacetime then 
						disp = disp:gsub("{PEACETIME_STATUS}", "~g~Enabled")
					else 
						disp = disp:gsub("{PEACETIME_STATUS}", "~r~Disabled")
					end
				end
				local scale = v.textScale;
				Draw2DText(x, y, disp, scale, false);
			end
			tickDegree = tickDegree + 9.0;
		end
	end
end)

function GetCardinalDirection()
	local camRot = Citizen.InvokeNative( 0x837765A25378F0BB, 0, Citizen.ResultAsVector() )
    local playerHeadingDegrees = 360.0 - ((camRot.z + 360.0) % 360.0)
    local tickDegree = playerHeadingDegrees - 180 / 2
    local tickDegreeRemainder = 9.0 - (tickDegree % 9.0)
   
    tickDegree = tickDegree + tickDegreeRemainder
    return tickDegree;
end
function degreesToIntercardinalDirection( dgr )
	dgr = dgr % 360.0
	
	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
		return " E "
	elseif dgr >= 22.5 and dgr < 67.5 then
		return "SE"
	elseif dgr >= 67.5 and dgr < 112.5 then
		return " S "
	elseif dgr >= 112.5 and dgr < 157.5 then
		return "SW"
	elseif dgr >= 157.5 and dgr < 202.5 then
		return " W "
	elseif dgr >= 202.5 and dgr < 247.5 then
		return "NW"
	elseif dgr >= 247.5 and dgr < 292.5 then
		return " N "
	elseif dgr >= 292.5 and dgr < 337.5 then
		return "NE"
	end
end
