local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local cpu_widgets = require("cpu")
local ram_widgets = require("ram")
local disk_widgets = require("disk")

local botao = wibox.widget {
    text = "SYSTEM INFO",
    resize = false,
    widget = wibox.widget.textbox
}

local popup = awful.popup {
    hide_on_right_click = true,
    ontop = true,
    visible = false, -- should be hidden when created
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 15)
    end,
    border_width = 1,
    border_color = "#000000",
    bg = "#0f1012",
    fg = "#ff0000",
    maximum_width = 600,
    heigth = 110,
    offset = { y = 5 },
    widget = {}
}

--botao:set_children({popup})
--popup:move_next_to(botao, "bottom")
popup:bind_to_widget(botao)

local rows = {
   {
      cpu_widgets,
      ram_widgets,
      disk_widgets,
      spacing = 15,
      forced_height  = 165,
      layout = wibox.layout.fixed.horizontal,
   },
   left = 15,
   right = 15,
   top = 15,
   bottom = 15,
   widget = wibox.container.margin
}
popup:setup(rows)

--botao:buttons(
--    awful.util.table.join(
--        awful.button({}, 1, function()
--            if popup.visible then
--                popup.visible = not popup.visible
--            else
--                 popup:move_next_to(awful.mouse.current_widget_geometry)
--            end
--    end))
--)


return botao
