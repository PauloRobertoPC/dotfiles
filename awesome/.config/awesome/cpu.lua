local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local update_interval = 5

local cpu_text = wibox.widget{
    font = "Roboto",
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}


local cpu_box_text = wibox.widget{
   {
      cpu_text,
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

local cpu_image = wibox.widget {
    image = "/home/pinto/.config/awesome/assets/cpu.png",
    widget = wibox.widget.imagebox,
    forced_heigth = dpi(8),
    forced_width = dpi(8),
    resize = true
}

local cpu_arc = wibox.widget {
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
      cpu_image,
      margins = dpi(35),
      widget = wibox.container.margin
   }, 
   cpu_arc,
   layout = wibox.layout.stack
}

cpu_arc_box = wibox.widget{
   w,
   left = 30,
   widget = wibox.container.margin
}

local cpu_widget = wibox.widget{
   {
      cpu_box_text,
      cpu_arc_box,
      spacing = 5,
      layout = wibox.layout.fixed.vertical
   },
   shape       = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 15) end,
   shape_clip  = true,
   bg = "#18191d",
   widget = wibox.container.background
}

local cpu_idle_script = [[
  sh -c "
  vmstat 1 2 | tail -1 | awk '{printf \"%d\", $15}'
  "]]

awful.widget.watch(cpu_idle_script, update_interval, function(widget, stdout)
    local cpu_free = stdout
    cpu_free = string.gsub(cpu_free, '^%s*(.-)%s*$', '%1')
    cpu_used = 100-cpu_free
    cpu_text:set_markup("<span foreground='#ffffff'>CPU: " ..math.floor(cpu_used) .. "%</span>")
    cpu_arc.value = cpu_used
end)

return cpu_widget
