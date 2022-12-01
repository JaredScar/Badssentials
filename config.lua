Config = {
	Prefix = '^5[^1Badssentials^5] ^3',
	ScreenAffects = {
		AnnounceCommand = "announce",
        AcePermission = "Badssentials.Announce", --The ace permission need to run the AnnounceCommand.
		AnnouncementHeader = '~b~[~p~Announcement~b~]',
		AnnouncementPlacement = 0, -- Set to 0 for top or .3 for middle of screen
		AnnounceDisplayTime = 15, -- How many seconds should announcements display for?
		DeathScreen = true, -- Enable/Disable the death screen. (Enabled by default.) (ReviveSystem.enable must also be true!)
        DeathScreenDisplaySettings = { 
            --[[
            Display used when DeathScreen = true
            Available Placeholders;
            {REVIVE_COMMAND} | Returns the Set Revive Command.
            {RESPAWN_COMMAND} | Returns the set respawn command.
            ]]
            ['Line 1'] = {
                text = "~r~You are knocked out or dead...",
                x = .5,
                y = .05,
                scale = .8,
                center = true,
            },
            ['Line 2'] = {
                text = "~b~If you were knocked out, you may use ~g~{REVIVE_COMMAND}~b~!",
                x = .5,
                y = .1,
                scale = .8,
                center = true,
            },
            ['Line 3'] = {
                text = "~b~If you are dead, you must use ~g~{RESPAWN_COMMAND}~b~!",
                x = .5,
                y = .15,
                scale = .8,
                center = true,
            },
        },
	},
    AOPSystem = {
        DefaultAOP = "Sandy Shores",
        AOPCommand = "aop",
        --Announcement sent to players when AOP is changed. Set to "", or nil to disable.
        AOP_Announcement = "The AOP has changed to '{NEW_AOP}'. Finish your current scene(s) and head to {NEW_AOP}. ^1Failure to do so could lead to punishment!^0",
        AOP_AcePermission = "Badssentials.AOP", --The ace permission need to run the AOPCommand.
    },
    ReviveSystem = {
        enable = true, --Enable/Disable Revive System
        Revive_Delay = 120, -- Set to 0 to disable 
        Respawn_Delay = 60, -- Set to 0 to disable
        RespawnCommand = "respawn",
        RespawnMessage = "Respawned successfully!", --Message sent when player respawns.
        RespawnErrorMessage = "^1ERROR: You cannot respawn, you still have ^7{RESPAWN_TIME_LEFT} ^1remaining...", --Message sent to user when they can't respawn. Use {TIME_LEFT} to show how long they have to respawn.
        ReviveCommand = "revive",
        ReviveMessage = "Revived successfully!", --Message sent when player revives.
        ReviveErrorMessage = "^1ERROR: You cannot revive, you still have ^7{REVIVE_TIME_LEFT} ^1remaining...",
        ReviveOthersAcePermission = "Badssentials.Revive",
        ReviveOthersMessage = "You have been revived by ^5{PLAYER_NAME}^0.", --Message sent to user after being revived by someone else. Use {PLAYER_NAME} for the staff member's name.
        BypassReviveAcePermission = "Badssentials.Bypass.Revive",
        BypassRespawnAcePermission = "Badssentials.Bypass.Respawn",
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
        PeacetimeAcePermission = "Badssentials.PeaceTime", --The ace permission required to run PT or Peacetime command.
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
