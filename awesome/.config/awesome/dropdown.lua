local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

botao = wibox.widget {
    text = "TESTANDO",
    resize = false,
    widget = wibox.widget.textbox
}

menu_items = {
    { name = 'Reddit', icon_name = 'reddit.png', url = 'https://www.reddit.com/' },
    { name = 'StackOverflow', icon_name = 'stack-overflow.svg', url = 'http://github.com/' },
    { name = 'GitHub', icon_name = 'github.svg', url = 'https://stackoverflow.com/' },
}

popup = awful.popup {
    ontop = true,
    visible = false, -- should be hidden when created
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end,
    border_width = 1,
    border_color = "#ff0000",
    bg = "#ffffff",
    fg = "#ff0000",
    maximum_width = 400,
    offset = { y = 5 },
    widget = {}
}
rows = { layout = wibox.layout.fixed.vertical }

for _, item in ipairs(menu_items) do
   row = wibox.widget {
       {
           {
               {
                   image = "/home/pinto/.config/awesome/assets/" .. item.icon_name,
                   forced_width = 16,
                   forced_height = 16,
                   widget = wibox.widget.imagebox
               },
               {
                   text = item.name,
                   widget = wibox.widget.textbox
   },
               spacing = 12,
               layout = wibox.layout.fixed.horizontal
           },
           margins = 8,
           widget = wibox.container.margin
       },
       bg = beautiful.bg_normal,
       widget = wibox.container.background
   }
    table.insert(rows, row)
    row:connect_signal("mouse::enter", function(c)
        c:set_bg("#ff0000")
    end)
    row:connect_signal("mouse::leave", function(c)
        c:set_bg("#ffffff")
    end)
    row:buttons(
        awful.util.table.join(
            awful.button({}, 1, function()
                popup.visible = not popup.visible
                awful.spawn.with_shell('xdg-open ' .. item.url)
            end)
        )
    )
end
popup:setup(rows)


botao:buttons(
    awful.util.table.join(
        awful.button({}, 1, function()
            if popup.visible then
                popup.visible = not popup.visible
            else
                 popup:move_next_to(awful.mouse.current_widget_geometry)
            end
    end))
)

