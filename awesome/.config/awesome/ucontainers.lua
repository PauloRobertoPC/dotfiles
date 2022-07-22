local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

teste1 = wibox.widget {
    {
        wibox.widget.systray(),
        left    = 5,
        top     = 2,
        bottom  = 2,
        right   = 5,
        widget  = wibox.container.margin,
    },
    bg          = "#ffffff",
    fg          = "#ff0000",
    shape       = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 15) end,
    shape_clip  = true,
    widget      = wibox.container.background,
}

texto = wibox.widget{
      markup = "This <i>is</i> a <b>textbox</b>!!!",
      --text = "This is a simple text box",
      align  = "center",
      valign = "center",
      color = "#ff0000",
      --ellipsize = "middle",
      --wrap = "word",
      --forced_width = 30,
      --forced_heigth = 30,
      opacity = 1,
      visible = true,
      widget = wibox.widget.textbox
}

teste = wibox.widget {
    texto,
    bg          = "#ffffff",
    fg          = "#ff0000",
    shape       = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 15) end,
    shape_clip  = true,
    widget      = wibox.container.background,
}

teste:connect_signal("button::press",
   function()
      naughty.notify { title = "Button Pressed"}
      
   end
)
teste:connect_signal("mouse::enter",
   function()
      teste.bg = "#ff0000"
   end
)
teste:connect_signal("mouse::leave",
   function()
      teste.bg = "#ffffff"
   end
)

teste3 = wibox.widget {
    bg          = "#ffffff",
    fg          = "#ff0000",
    shape       = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 15) end,
    shape_clip  = true,
    widget      = wibox.container.background,
}

sla = wibox.widget {
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
teste2 = wibox.widget {
    sla,
    bg          = "#ffffff",
    fg          = "#ff0000",
    shape       = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 15) end,
    shape_clip  = true,
    widget      = wibox.container.background,
}
sla:connect_signal("property::value",
   function()
      naughty.notify { title = tostring(sla.value)} -- debugger
   end
)


teste4 = awful.popup {
    widget = {
        {
            {
                text   = 'foobar',
                widget = wibox.widget.textbox
            },
            {
                {
                    text   = 'foobar',
                    widget = wibox.widget.textbox
                },
                bg     = '#ff00ff',
                clip   = true,
                shape  = gears.shape.rounded_bar,
                widget = wibox.widget.background
            },
            {
                value         = 0.5,
                forced_height = 30,
                forced_width  = 100,
                widget        = wibox.widget.progressbar
            },
            layout = wibox.layout.fixed.vertical,
        },
        margins = 10,
        widget  = wibox.container.margin
    },
    border_color = '#00ff00',
    border_width = 5,
    placement    = awful.placement.top_left,
    shape        = gears.shape.rounded_rect,
    visible      = true,
}
