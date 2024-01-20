-- Returns the current version set in fxmanifest.lua
function GetCurrentVersion()
	return GetResourceMetadata(GetCurrentResourceName(), "version")
end 

-- Grabs the latest version number from the web GitHub
PerformHttpRequest("https://raw.githubusercontent.com/JaredScar/Badssentials/master/version.txt", function(error, updatedVersion, headers)
	-- Wait to post message(s).
	Citizen.Wait(2500)

	-- Get the current resource version 
	local currentVersion = GetCurrentVersion()
	
	if (updatedVersion ~= nil) then 
		-- If the versions are different, print it out
		if (updatedVersion ~= currentVersion) then
			print('^0Badssentials is outdated, go to https://github.com/JaredScar/Badssentials to get the latest version.')
			print("Current Version: " .. currentVersion)
			print("Latest Version: " .. updatedVersion)
		else
			print('Badssentials is up to date!')
			print("Current Version: " .. currentVersion)
		end
	else 
		-- In case the version can not be requested, print out an error message
		print('^1There was an error in the checks for the latest version, if the issue persists create an issue on github. ^0https://github.com/JaredScar/Badssentials/issues')
	end 
end)