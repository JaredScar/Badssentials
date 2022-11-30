Config = {
	Prefix = '^5[^1Badssentials^5] ^3',
	ScreenAffects = {
		AnnounceCommand = "announce",
        acePermission = "Badssentials.Announce", --The ace permission need to run the AnnounceCommand.
		AnnouncementHeader = '~b~[~p~FIRP Announcement~b~]',
		AnnouncementPlacement = 0, -- Set to 0 for top or .3 for middle of screen
		AnnounceDisplayTime = 15, -- How many seconds should announcements display for?
		DeathScreen = true, -- Enable/Disable the death screen. (Enabled by default.)
	},
    AOPSystem = {
        DefaultAOP = "Los Santos",
        AOPCommand = "aop",
        --Announcement sent to players when AOP is changed. Set to "", or nil to disable.
        aopAnnouncement = "The AOP has changed to '{NEW_AOP}'. Finish your current scene(s) and head to {NEW_AOP}. ^1Failure to do so could lead to punishment!^0",
        acePermission = "Badssentials.AOP", --The ace permission need to run the AOPCommand.
    },
    ReviveSystem = {
        Revive_Delay = 120, -- Set to 0 to disable 
        Respawn_Delay = 60, -- Set to 0 to disable
        RespawnCommand = "respawn",
        ReviveCommand = "revive",
        reviveOthersAcePermission = "Badssentials.Revive",
        bypassReviveAcePermission = "Badssentials.Bypass.Revive",
        bypassRespawnAcePermission = "Badssentials.Bypass.Respawn",
        RespawnLocations = {
            DefaultLocation = {
                --Sandy Shores Medical Center
                x = 1827.26,
                y = 3693.58,
                z = 34.22,
            },
            ['Los Santos'] = {
                --Pillbox Hill Medical Center
                x = 298.2,
                y = -584.17,
                z = 43.26,
            },
            ['Sandy Shores'] = {
                --Sandy Shores Medical Center
                x = 1827.26,
                y = 3693.58,
                z = 34.22,
            },
            ['Blaine County'] = {
                --Sandy Shores Medical Center
                x = 1827.26,
                y = 3693.58,
                z = 34.22,
            },
            ['Paleto Bay'] = {
                --Paleto Bay Medical Center
                x = -248.1,
                y = 6332.6,
                z = 32.43,
            },
        },
    },
    Misc = {
        PostalCommand = "postal",
        ToggleHUDCommand = "toggle-hud",
        Peacetime = "peacetime", -- Peacetime & PT both control the peacetime system.
        PT = "pt",
        ptAcePermission = "Badssentials.PeaceTime", --The ace permission required to run PT or Peacetime command.
    },
    Displays = {
		['Noir RP Server | Discord'] = {
			x = .800,
			y = .01,
			display = "~g~Noir RP ~w~| discord.gg/BB68c3d",
			textScale = .55,
			enabled = true
		},
		['Compass Location'] = {
			x = .165,
			y = .85,
			display = "~w~| ~g~{COMPASS} ~w~|",
			textScale = 1.0,
			enabled = true
		},
		['Street Location'] = {
			x = .22,
			y = .855,
			display = "~g~{STREET_NAME}",
			textScale = .45,
			enabled = true
		},
		['City Location'] = {
			x = .22,
			y = .875,
			display = "~w~{CITY}",
			textScale = .45,
			enabled = true
		},
		['Nearest Postal'] = {
			x = .165,
			y = .91,
			display = "~w~Nearest ~g~Postal: ~w~{NEAREST_POSTAL} (~w~{NEAREST_POSTAL_DISTANCE}m~w~)",
			textScale = .4,
			enabled = true
		},
		['Time & Date'] = {
			x = .165,
			y = .93,
			display = "~g~Time (EST): ~w~{EST_TIME} ~g~| Date: ~w~{US_MONTH}~g~/~w~{US_DAY}~g~/~w~{US_YEAR}",
			textScale = .4,
			enabled = true
		},
		['AOP & PeaceTime'] = {
			x = .165,
			y = .95,
			display = "~w~Current ~g~AOP: {CURRENT_AOP} ~g~| ~w~PeaceTime: {PEACETIME_STATUS}",
			textScale = .4,
			enabled = true
		},
        ['Player ID'] = {
            x = .345,
            y = .935,
            display = "~b~ID:~w~ {ID}",
            textScale = .45,
            enabled = true
        },
    }
}
