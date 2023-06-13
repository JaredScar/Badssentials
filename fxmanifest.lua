author "badger.jar"
description "Badssenstials"
fx_version "cerulean"
game "gta5"
version '3.0.0'

client_script "client.lua"

server_scripts {
    "server.lua",
    "version-checker.lua"
} 

shared_scripts {
    "config.lua",
    "postals.lua"
}

exports {
    "GetAOP",
    "GetPeaceTimeStatus",
    "IsDisplaysHidden"
}
