local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

--Volume Control
volume_slider = wibox.widget {
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

volume_text = wibox.widget{
    text = tostring(volume_slider.value) .. "%",
    widget = wibox.widget.textbox
}

volume_icon = wibox.widget{
    image  = "/home/pinto/.config/awesome/assets/volume.png",
    resize = true,
    widget = wibox.widget.imagebox
}

-- Connect to `property::value` to use the value on change
volume_slider:connect_signal("property::value",
   function()
      volume_text:set_text(tostring(volume_slider.value) .. "%")
      awful.spawn("amixer -D pulse sset Master " .. volume_slider.value .. "%")
   end
)

volume_widget = wibox.widget{
   {
      {
         volume_icon,
         volume_text,
         volume_slider,
         spacing = 2,
         layout = wibox.layout.fixed.horizontal
      },
      margins = 8,
      widget = wibox.container.margin
   },
   shape       = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 15) end,
   shape_clip  = true,
   bg = "#ebc034",
   widget = wibox.container.background
}
