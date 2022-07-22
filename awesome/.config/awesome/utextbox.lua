local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")

teste = wibox.widget{
    --markup = "This <i>is</i> a <b>textbox</b>!!!",
    text = "This is a simple text box",
    align  = "center",
    valign = "center",
    --ellipsize = "middle",
    --wrap = "word",
    --forced_width = 30,
    --forced_heigth = 30,
    opacity = 0.5,
    visible = true,
    widget = wibox.widget.textbox
}

teste:connect_signal("button::press",
   function()
      naughty.notify { title = "Button Pressed"}
   end
)
teste:connect_signal("button::release",
   function()
      naughty.notify { title = "Button Released"}
   end
)
teste:connect_signal("mouse::enter",
   function()
      naughty.notify { title = "Mouse Enter"}
   end
)
teste:connect_signal("mouse::leave",
   function()
      naughty.notify { title = "Mouse Leave"}
   end
)
