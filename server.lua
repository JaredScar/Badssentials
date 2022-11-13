--------------------
--- Badssentials ---
--------------------
function sendMsg(src, msg)
  TriggerClientEvent('chat:addMessage', src, {args = {Config.Prefix .. msg} });
end

function GetAOP()
  return currentAOP
end

RegisterCommand(Config.ScreenAffects.AnnounceCommand, function(source, args, raw) 
  local src = source;
  if IsPlayerAceAllowed(src, "Badssentials.Announce") then 
    -- Allowed to use /announce 
    if #args > 0 then 
      local ann = table.concat(args, " ");
      TriggerClientEvent('Badssentials:Announce', -1, ann);
    end
  end
end)

Citizen.CreateThread(function()
  while true do 
    Wait(1000);
    TriggerClientEvent('Badssentials:SetAOP', -1, currentAOP);
    TriggerClientEvent('Badssentials:SetPT', -1, peacetime);
    local time = format_time(os.time(), "%H:%M", "+01:00", "EST");
    local date = format_time(os.time(), "%m %d %Y", "+01:00", "EST");
    local timeHour = split(time, ":")[1]
    local dateData = split(date, " ");
    TriggerClientEvent('Badssentials:SetMonth', -1, dateData[1])
    TriggerClientEvent('Badssentials:SetDay', -1, dateData[2])
    TriggerClientEvent('Badssentials:SetYear', -1, dateData[3])
    if tonumber(timeHour) > 12 then 
      local timeStr = tostring(tonumber(timeHour) - 12) .. ":" .. split(time, ":")[2]
      TriggerClientEvent('Badssentials:SetTime', -1, timeStr);
    end
    if timeHour == "00" then 
      local timeStr = "12" .. ":" .. split(time, ":")[2]
      TriggerClientEvent('Badssentials:SetTime', -1, timeStr);
    end 
    if timeHour ~= "00" and tonumber(timeHour) <= 12 then 
      TriggerClientEvent('Badssentials:SetTime', -1, time);
    end
  end
end)
peacetime = false;
currentAOP = Config.AOPSystem.DefaultAOP; -- By default 
RegisterCommand(Config.AOPSystem.AOPCommand, function(source, args, rawCommand)
  local src = source;
  if IsPlayerAceAllowed(src, "Badssentials.AOP") then 
    -- Allowed to use /aop <aop>
    if #args > 0 then 
      currentAOP = table.concat(args, " ");
      sendMsg(src, "You have set the AOP to: " .. currentAOP);
      TriggerClientEvent('Badssentials:SetAOP', -1, currentAOP);
    else 
      -- Not enough arguments
      sendMsg(src, "^1ERROR: Proper usage: /aop <zone>");
    end
  end
end)
timersRev = {}
timersRes = {}
Citizen.CreateThread(function()
  while true do 
    Wait((1000)); -- Each second 
    for src, timer in pairs(timersRev) do 
      timersRev[src] = timer - 1;
      if (timersRev[src] <= 0) then 
        timersRev[src] = nil;
      end
    end
    for src, timer in pairs(timersRes) do 
      timersRes[src] = timer - 1;
      if (timersRes[src] <= 0) then 
        timersRes[src] = nil;
      end
    end
  end
end)
RegisterNetEvent("Badssentials:DeathTrigger")
AddEventHandler("Badssentials:DeathTrigger", function()
  local src = source;
  timersRev[src] = Config.ReviveSystem.Revive_Delay;
  timersRes[src] = Config.ReviveSystem.Respawn_Delay;
end)
RegisterCommand(Config.ReviveSystem.ReviveCommand, function(source, args, rawCommand)
  local src = source;
  if #args == 0 then 
    -- Revive themselves
    if timersRev[src] ~= nil and timersRev[src] >= 0 then 
      -- They are dead and have a timer 
      if IsPlayerAceAllowed(src, "Badssentials.Bypass.Revive") then 
        -- Can bypass reviving
        TriggerClientEvent('Badssentials:RevivePlayer', src);
        sendMsg(src, "You have been revived successfully!");
      else 
        -- Cannot bypass reviving, send they need to wait and what their timer is at 
        sendMsg(src, '^1ERROR: You cannot revive, you still have ^7' .. timersRev[src] .. ' ^1seconds remaining...');
      end
    else 
      -- Their timer is expired or not valid 
      TriggerClientEvent('Badssentials:RevivePlayer', src); 
      sendMsg(src, "You have been revived successfully!");
    end
  else 
    -- They are reviving someone else 
    if tonumber(args[1]) ~= src then 
      TriggerClientEvent('Badssentials:RevivePlayer', tonumber(args[1]));
      sendMsg(src, "You have revived player ^5" .. GetPlayerName(tonumber(args[1])) .. " ^3successfully!");
      sendMsg(tonumber(args[1]), "You have been revived successfully by ^5" .. GetPlayerName(src) .. "^3!");
    end
  end
end)
RegisterCommand(Config.ReviveSystem.RespawnCommand, function(source, args, rawCommand)
  local src = source;
  if #args == 0 then 
    -- Respawn themselves
    if timersRes[src] ~= nil and timersRes[src] >= 0 then 
      -- They are dead and have a timer 
      if IsPlayerAceAllowed(src, "Badssentials.Bypass.Respawn") then 
        -- Can bypass reviving
        TriggerClientEvent('Badssentials:RespawnPlayer', src);
        sendMsg(src, "You have respawned successfully!");
      else 
        -- Cannot bypass reviving, send they need to wait and what their timer is at 
        sendMsg(src, '^1ERROR: You cannot respawn, you still have ^7' .. timersRes[src] .. ' ^1seconds remaining...');
      end
    else 
      -- Their timer is expired or not valid 
      TriggerClientEvent('Badssentials:RespawnPlayer', src); 
      sendMsg(src, "You have respawned successfully!");
    end
  end 
end)


RegisterCommand(Config.Misc.Peacetime, function(source, args, rawCommand)
  local src = source;
  if IsPlayerAceAllowed(src, "Badssentials.PeaceTime") then
    peacetime = not peacetime;
    TriggerClientEvent('Badssentials:SetPT', -1, peacetime);
    if peacetime then 
      sendMsg(src, "You have set PeaceTime to ^2ON"); 
    else 
      sendMsg(src, "You have set PeaceTime to ^1OFF");
    end
  end
end)
RegisterCommand(Config.Misc.PT, function(source, args, rawCommand)
  local src = source;
  if IsPlayerAceAllowed(src, "Badssentials.PeaceTime") then
    peacetime = not peacetime;
    TriggerClientEvent('Badssentials:SetPT', -1, peacetime);
    if peacetime then 
      sendMsg(src, "You have set PeaceTime to ^2ON"); 
    else 
      sendMsg(src, "You have set PeaceTime to ^1OFF");
    end
  end
end)
function split(source, sep)
    local result, i = {}, 1
    while true do
        local a, b = source:find(sep)
        if not a then break end
        local candidat = source:sub(1, a - 1)
        if candidat ~= "" then 
            result[i] = candidat
        end i=i+1
        source = source:sub(b + 1)
    end
    if source ~= "" then 
        result[i] = source
    end
    return result
end
function format_time(timestamp, format, tzoffset, tzname)
   if tzoffset == "local" then  -- calculate local time zone (for the server)
      local now = os.time()
      local local_t = os.date("*t", now)
      local utc_t = os.date("!*t", now)
      local delta = (local_t.hour - utc_t.hour)*60 + (local_t.min - utc_t.min)
      local h, m = math.modf( delta / 60)
      tzoffset = string.format("%+.4d", 100 * h + 60 * m)
   end
   tzoffset = tzoffset or "GMT"
   format = format:gsub("%%z", tzname or tzoffset)
   if tzoffset == "GMT" then
      tzoffset = "+0000"
   end
   tzoffset = tzoffset:gsub(":", "")

   local sign = 1
   if tzoffset:sub(1,1) == "-" then
      sign = -1
      tzoffset = tzoffset:sub(2)
   elseif tzoffset:sub(1,1) == "+" then
      tzoffset = tzoffset:sub(2)
   end
   tzoffset = sign * (tonumber(tzoffset:sub(1,2))*60 +
tonumber(tzoffset:sub(3,4)))*60
   return os.date(format, timestamp + tzoffset)
end
