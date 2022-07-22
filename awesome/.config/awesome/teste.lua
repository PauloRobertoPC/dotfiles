local wibox = require("wibox")
local awful = require("awful")

teste = wibox.widget.textbox()
bteste1 = awful.button({}, 1, function() awful.spawn("kitty") end, function() awful.spawn("kitty") end)
enulo = "FALSO" 
teste.text = "TESTANDO A MÁGICA"
teste.buttons = {bteste1}

