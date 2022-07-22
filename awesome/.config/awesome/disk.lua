local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local update_interval = 5

local disk_text = wibox.widget{
    font = "Roboto",
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local disk_box_text = wibox.widget{
   {
      disk_text,
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

local disk_image = wibox.widget {
    image = "/home/pinto/.config/awesome/assets/disk.svg",
    widget = wibox.widget.imagebox,
    forced_heigth = dpi(8),
    forced_width = dpi(8),
    resize = true
}

local disk_arc = wibox.widget {
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
      disk_image,
      margins = dpi(35),
      widget = wibox.container.margin
   },
   disk_arc,
   layout = wibox.layout.stack
}

local disk_arc_box = wibox.widget{
   w,
   left = 30,
   widget = wibox.container.margin
}

local disk_widget = wibox.widget{
   {
      disk_box_text,
      disk_arc_box,
      spacing = 5,
      layout = wibox.layout.fixed.vertical
   },
   shape       = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 15) end,
   shape_clip  = true,
   bg = "#18191d",
   widget = wibox.container.background
}

local disk_script = 'sh -c "/home/pinto/.config/awesome/disk.sh"'

awful.widget.watch(disk_script, update_interval, function(widget, stdout)
    local percent = stdout
    disk_text:set_markup("<span foreground='#ffffff'>DISK: " ..math.floor(percent) .. "%</span>")
    disk_arc.value = percent
end)

return disk_widget
