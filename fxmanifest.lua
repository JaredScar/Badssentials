author "Badger#0002"
description "Badssenstials"
fx_version "cerulean"
game "gta5"

client_script "client.lua"

server_script "server.lua"

shared_scripts {
    "config.lua",
    "postals.lua"
}

exports {
    "GetAOP",
    "GetPeaceTimeStatus",
    "IsDisplaysHidden"
}
