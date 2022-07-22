local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

teste = wibox.widget {
    bar_shape           = gears.shape.rounded_rect,
    bar_height          = 3,
    bar_color           = "#ffffff",
    handle_color        = "#ff0000",
    handle_shape        = gears.shape.circle,
    handle_border_color = "#ffffff",
    handle_border_width = 1,
    value               = 50,
    forced_width        = 50,
    minimum             = 0,
    maximum             = 100,
    widget              = wibox.widget.slider,
}


-- Connect to `property::value` to use the value on change
teste:connect_signal("property::value",
   function()
      awful.spawn("amixer -D pulse sset Master " .. teste.value .. "%")
      naughty.notify { title = tostring(teste.value)}
   end
)
