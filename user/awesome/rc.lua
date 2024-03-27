require "lua"
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.spiral,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

powermenu = {
    { "restart", function() awful.spawn("systemctl reboot") end },
    { "power off", function() awful.spawn("systemctl poweroff") end },
}

mymainmenu = awful.menu({ 
    items = { 
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "powermenu", powermenu},
        { "open terminal", terminal }
    }
})

mylauncher = awful.widget.launcher({ 
    image = beautiful.awesome_icon,
    menu = mymainmenu 
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end
    end),
    awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Function to update battery widget
local function update_battery_widget(widget)
    awful.spawn.easy_async("upower -i /org/freedesktop/UPower/devices/battery_BAT0", function(stdout)
        local battery_percentage = stdout:match("percentage:%s*(%d+)%%")
        widget:set_text("Battery: " .. battery_percentage .. "%")
    end)
end

-- Create battery widget
local battery_widget = wibox.widget.textbox()
update_battery_widget(battery_widget)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            awful.widget.watch("upower -i /org/freedesktop/UPower/devices/battery_BAT0", 60, function(widget, stdout)
                update_battery_widget(widget)
            end),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Keybindings
local home = os.getenv("HOME")

local browser = "google-chrome-stable"
local calculator = "gnome-calculator"
local discord = "discord"
local fileExplorer = "nautilus"
local rofi = "rofi -show drun -theme ~/.config/rofi/style.rasi"
local telegram = "telegram-desktop"
local lockScreen = "betterlockscreen -l"
local screenshoot = "flameshot gui -p " .. home .. "/Pictures/Screenshots -c"

local volumeDown = "pactl set-sink-volume @DEFAULT_SINK@ -5%"
local volumeUp = "pactl set-sink-volume @DEFAULT_SINK@ +5%"
local volumeMute = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
local micMute = "pactl set-source-mute @DEFAULT_SOURCE@ toggle"

local brightnessDown = "brightnessctl s 5%-"
local brightnessUp = "brightnessctl s +5%"


globalkeys = gears.table.join(
    -- Apps
    awful.key({ altkey }, "c", function() awful.spawn(calculator) end, {description = "calculator", group = "APPS"}),
    awful.key({ altkey }, "d", function() awful.spawn(discord) end, {description = "discord", group = "APPS"}),
    awful.key({ altkey }, "f", function() awful.spawn(fileExplorer) end, {description = "file explorer", group = "APPS"}),
    awful.key({ altkey }, "t", function() awful.spawn(telegram) end, {description = "telegram", group = "APPS"}),
    awful.key({ altkey }, "w", function() awful.spawn(browser) end, {description = "browser", group = "APPS"}),
    awful.key({ altkey }, "Return", function () awful.spawn(terminal) end, {description = "terminal", group = "APPS"}),
    
    -- Tools
    awful.key({ altkey }, "F4", function() awful.spawn(lockScreen) end, {description = "lock screen", group = "TOOLS"}),
    awful.key({ }, "Print", function() awful.spawn(screenshoot) end, {description = "screenshoot", group = "TOOLS"}),
    
    -- Launchers
    awful.key({ altkey }, "r", function() awful.spawn(rofi) end, {description = "rofi", group = "LAUNCHER"}),
    -- awful.key({ altkey }, "p", function() menubar.show() end, {description = "menubar", group = "launcher"}),
    -- awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end, {description = "run prompt", group = "launcher"}),

    -- Screen Movements
    awful.key({ altkey, "Shift" }, "h", function () awful.screen.focus_bydirection("left") end, {description = "focus screen left", group = "SCREEN MOVEMENTS"}),
    awful.key({ altkey, "Shift" }, "j", function () awful.screen.focus_bydirection("down") end, {description = "focus screen down", group = "SCREEN MOVEMENTS"}),
    awful.key({ altkey, "Shift" }, "k", function () awful.screen.focus_bydirection("up") end, {description = "focus screen up", group = "SCREEN MOVEMENTS"}),
    awful.key({ altkey, "Shift" }, "l", function () awful.screen.focus_bydirection("right") end, {description = "focus screen right", group = "SCREEN MOVEMENTS"}),

    -- Client Movements
    awful.key({ modkey }, "h", function () awful.client.focus.bydirection("left") end, {description = "focus client left", group = "CLIENT MOVEMENTS"}),
    awful.key({ modkey }, "j", function () awful.client.focus.bydirection("down") end, {description = "focus client down", group = "CLIENT MOVEMENTS"}),
    awful.key({ modkey }, "k", function () awful.client.focus.bydirection("up") end, {description = "focus client up", group = "CLIENT MOVEMENTS"}),
    awful.key({ modkey }, "l", function () awful.client.focus.bydirection("right") end, {description = "focus client right", group = "CLIENT MOVEMENTS"}),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = "CLIENT MOVEMENTS"}),

    -- Client Swap Movements
    awful.key({ modkey, "Shift" }, "h", function () awful.client.swap.bydirection("left") end, {description = "focus client left", group = "CLIENT SWAP MOVEMENTS"}),
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.bydirection("down") end, {description = "focus client down", group = "CLIENT SWAP MOVEMENTS"}),
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.bydirection("up") end, {description = "focus client up", group = "CLIENT SWAP MOVEMENTS"}),
    awful.key({ modkey, "Shift" }, "l", function () awful.client.swap.bydirection("right") end, {description = "focus client right", group = "CLIENT SWAP MOVEMENTS"}),

    -- Awesome
    awful.key({ modkey, "Control" }, "r", awesome.restart, {description = "reload awesome", group = "AWESOME"}),
    awful.key({ modkey, "Control" }, "q", awesome.quit, {description = "quit awesome", group = "AWESOME"}),
    awful.key({ modkey, "Control" }, "k", hotkeys_popup.show_help, {description="keybindings", group="AWESOME"}),
    awful.key({ modkey, "Control" }, "m", function () mymainmenu:show() end, {description = "menu", group = "AWESOME"}),

    -- Resize
    awful.key({ modkey, "Control" }, "h", function () awful.tag.incmwfact(-0.05) end, {description = "decrease master width factor", group = "RESIZE"}),
    awful.key({ modkey, "Control" }, "l", function () awful.tag.incmwfact( 0.05) end, {description = "increase master width factor", group = "RESIZE"}),
    
    -- Layout
    awful.key({ modkey }, "space", function () awful.layout.inc( 1) end, {description = "select next layout", group = "LAYOUT"}),
    awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1) end, {description = "select previous layout", group = "LAYOUT"}),
    
    -- Volume
    awful.key({ }, "XF86AudioLowerVolume", function() awful.spawn(volumeDown) end, {description = "Volume Down", group = "VOLUME"}),
    awful.key({ }, "XF86AudioRaiseVolume", function() awful.spawn(volumeUp) end, {description = "Volume Up", group = "VOLUME"}),
    awful.key({ }, "XF86AudioMute", function() awful.spawn(volumeMute) end, {description = "Volume Mute", group = "VOLUME"}),
    awful.key({ }, "XF86AudioMicMute", function() awful.spawn(micMute) end, {description = "Mic Mute", group = "VOLUME"}),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessDown", function() awful.spawn(brightnessDown) end, {description = "Brightness Down", group = "BRIGHTNESS"}),
    awful.key({ }, "XF86MonBrightnessUp", function() awful.spawn(brightnessUp) end, {description = "Brightness Up", group = "BRIGHTNESS"})
)

clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function (c) c.fullscreen = not c.fullscreen c:raise() end, {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey }, "c", function (c) c:kill() end, {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle , {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, {description = "move to master", group = "client"}),
    awful.key({ modkey }, "o", function (c) c:move_to_screen() end, {description = "move to screen", group = "client"}),
    awful.key({ modkey }, "t", function (c) c.ontop = not c.ontop end, {description = "toggle keep on top", group = "client"})
)

-- Tag keybindings
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "TAG MOVEMENTS"}),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "TAG SWAP MOVEMENTS"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { 
        rule = { },
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    { 
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "megasync"
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
        }, 
        properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    { 
        rule_any = {
            type = { "normal", "dialog" }
        }, 
        properties = { titlebars_enabled = false }
    },
    
    { 
        rule_any = {
            class = {
                "evince",
                "Evince",
                "obsidian",
            },
        }, 
        properties = { maximized = false }
    },

    { 
        rule = { class = "ticktick" },
        properties = { screen = 1, tag = "4" } 
    },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- xrandr --query  to know the name of the monitors
local monitor1 = "eDP-1"
local monitor2 = "DP-1"
awful.spawn("xrandr --output " .. monitor2 .. " --auto --above " .. monitor1)

awful.spawn("betterlockscreen -u " .. home .. "/.config/awesome/assets/img/colorfulAI.png")
awful.spawn("blueman-applet")
awful.spawn("megasync")
awful.spawn("nm-applet")
awful.spawn("ticktick")
-- awful.spawn("picom --config " .. home .. "/.config/picom/picom.conf --experimental-backends")
