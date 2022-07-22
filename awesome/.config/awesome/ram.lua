local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local naughty = require("naughty")

local update_interval = 5

local ram_text = wibox.widget{
    font = "Roboto",
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}


local ram_box_text = wibox.widget{
   {
      ram_text,
      shape       = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 15) end,
      shape_clip  = true,
      bg = "#18191d",
      widget = wibox.container.background
   },
   right = 30,
   bottom = 5,
   top = 10,
   widget = wibox.container.margin
}

local ram_image = wibox.widget {
    image = "/home/pinto/.config/awesome/assets/ram.png",
    widget = wibox.widget.imagebox,
    forced_heigth = dpi(8),
    forced_width = dpi(8),
    resize = true
}

local ram_arc = wibox.widget {
    max_value = 100,
    forced_width = 110,
    forced_heigth = 110,
    thickness = 8,
    start_angle = 4.3,
    rounded_edge = true,
    bg = "#0f1012",
    paddings = 10,
    colors = {"#6293f8"},
    widget = wibox.container.arcchart
}

local w = wibox.widget {
   {
      ram_image,
      margins = dpi(35),
      widget = wibox.container.margin
   }, 
   ram_arc,
   layout = wibox.layout.stack
}

ram_arc_box = wibox.widget{
   w,
   left = 30,
   widget = wibox.container.margin
}

local ram_widget = wibox.widget{
   {
      ram_box_text,
      ram_arc_box,
      spacing = 5,
      layout = wibox.layout.fixed.vertical
   },
   shape       = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 15) end,
   shape_clip  = true,
   bg = "#18191d",
   widget = wibox.container.background
}

local ram_script = 'sh -c "/home/pinto/.config/awesome/ram.sh"'

awful.widget.watch(ram_script, update_interval, function(widget, stdout)
    local available = stdout:match('(.*)@@')
    local total = stdout:match('@@(.*)@')
    local used = tonumber(total) - tonumber(available)
    local percent = used*100/total
    ram_text:set_markup("<span foreground='#ffffff'>RAM: " ..math.floor(percent) .. "%</span>")
    ram_arc.value = percent
end)

return ram_widget
