-- {{{ Libraries
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local drop = require("scratch.drop")
local lain = require("lain")
-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Init

-- beautiful init
beautiful.init("/home/hbc/.config/awesome/themes/multicolor/theme.lua")

-- stuffs
modkey = "Mod4"
altkey = "Mod1"
terminal = "xfce4-terminal"
editor = "vim"
editor_cmd = terminal .. " -" .. editor
gui_editor = "gvim"
browser = "google-chrome"
browser2 = "firefox"

local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}

-- }}}

-- {{{ Tags
-- TODO multi screen tweaking
tags = {
    -- pre screen settings
    settings =  {
        {"alpha", "beta"},
        {"alpha", "beta", "gamma", "delta"}
    }
}
for s = 1, screen.count() do
    local current_setting = s
    if current_setting > #tags.settings then
        current_setting = #tags.settings
    end
    tags[s] = awful.tag(tags.settings[current_setting], s, layouts[1])
end
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Wibox

markup = lain.util.markup

-- clock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
textclock = awful.widget.textclock(
    markup("#7788af", "%A %d %B ") ..
    markup("#de5e13", " %H:%M ")
)

-- battery
-- TODO fix resource file reading
baticon = wibox.widget.imagebox(beautiful.widget_batt)
batwidget = lain.widgets.bat({
    settings = function()
        if bat_now.perc == "N/A" then
            bat_now.perc = " AC "
        else
            bat_now.perc = bat_now.perc .. "% "
        end
        widget:set_text(bat_now.perc)
    end
})

-- spacer
spacer = wibox.widget.textbox(" ")

-- container
mywibox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({}, 1, awful.tag.viewonly),
    awful.button({modkey}, 1, awful.client.movetotag),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({modkey}, 3, awful.client.toggletag),
    awful.button({}, 4,
        function(t)
            awful.tag.viewnext(awful.tag.getscreen(t))
        end),
    awful.button({}, 5,
        function(t)
            awful.tag.viewprev(awful.tag.getscreen(t))
        end)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({}, 1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                -- without this, the following :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() then
                    awful.tag.viewonly(c:tags()[1])
                end
                -- this will also un-minimize the client
                client.focus = c
                c:raise()
            end
        end),
    awful.button({}, 3,
        function()
            if instance then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({width = 250})
            end
        end),
    awful.button({}, 4,
        function()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.button({}, 5,
        function()
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end)
)
mypromptbox = {}

-- placing widgets
for s = 1, screen.count() do
    -- layouts
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
        awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
        awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
        awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
        awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)
    ))

    -- taglist
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all,
                                        mytaglist.buttons)

    -- tasklist
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags,
                                          mytasklist.buttons)

    -- promptbox
    mypromptbox[s] = awful.widget.prompt()

    -- wibox
    mywibox[s] = awful.wibox({
        position = "top",
        screen = s,
        height = 20
    })

    -- left part
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- right part
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then
        right_layout:add(wibox.widget.systray())
    end
    right_layout:add(clockicon)
    right_layout:add(textclock)
    right_layout:add(mylayoutbox[s])
    right_layout:add(baticon)
    right_layout:add(batwidget)

    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end

-- }}}

-- {{{ Mouse & key bindings
root.buttons(awful.util.table.join(
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))

globalkeys = awful.util.table.join(
    -- default keybindings
    awful.key({modkey}, "Return", function() awful.util.spawn(terminal) end),
    awful.key({modkey, "Control"}, "r", awesome.restart),
    awful.key({modkey, "Shift"}, "q", awesome.quit),

    -- prompt
    awful.key({modkey}, "r", function() mypromptbox[mouse.screen]:run() end),
    awful.key({modkey}, "x",
              function ()
                  awful.prompt.run({prompt = "Run Lua code: "},
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    awful.key({modkey}, "Left", awful.tag.viewprev),
    awful.key({modkey}, "Right", awful.tag.viewnext),
    awful.key({modkey}, "Escape", awful.tag.history.restore),
    awful.key({modkey}, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({modkey}, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({modkey}, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({modkey}, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

    -- toggle wibox visible
    awful.key({modkey}, "w",
        function()
            mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
        end),

    -- layout manipulation
    awful.key({modkey, "Shift"}, "j", function() awful.client.swap.byidx(1) end),
    awful.key({modkey, "Shift"}, "k", function() awful.client.swap.byidx(-1) end),
    awful.key({modkey, "Control"}, "j", function() awful.screen.focus_relative(1) end),
    awful.key({modkey, "Control"}, "k", function() awful.screen.focus_relative(-1) end),
    awful.key({modkey,}, "u", awful.client.urgent.jumpto),
    awful.key({modkey,}, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({altkey, "Shift"}, "l", function() awful.tag.incmwfact(0.05) end),
    awful.key({altkey, "Shift"}, "h", function() awful.tag.incmwfact(-0.05) end),
    awful.key({modkey, "Shift"}, "l", function() awful.tag.incnmaster(-1) end),
    awful.key({modkey, "Shift"}, "h", function() awful.tag.incnmaster(1) end),
    awful.key({modkey, "Control"}, "l", function() awful.tag.incncol(-1) end),
    awful.key({modkey, "Control" }, "h", function() awful.tag.incncol( 1) end),
    awful.key({modkey,}, "space", function() awful.layout.inc(layouts,  1) end),
    awful.key({modkey, "Shift"}, "space", function() awful.layout.inc(layouts, -1) end),
    awful.key({modkey, "Control"}, "n", awful.client.restore)
)

clientkeys = awful.util.table.join(
    awful.key({modkey}, "f", function(c) c.fullscreen = not c.fullscreen end),
    awful.key({modkey, "Shift"}, "c", function(c) c:kill() end),
    awful.key({modkey, "Control"}, "space", awful.client.floating.toggle),
    awful.key({modkey, "Control"}, "Return", function(c) c:swap(awful.client.getmaster()) end),
    awful.key({modkey}, "o", awful.client.movetoscreen),
    awful.key({modkey}, "t", function(c) c.ontop = not c.ontop end),
    awful.key({modkey}, "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({modkey}, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

clientbuttons = awful.util.table.join(
    awful.button({}, 1, function(c) client.focus = c; c:raise() end),
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize)
)

-- map number to tags
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({modkey}, "#" .. i + 9,
                  function()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({modkey, "Control"}, "#" .. i + 9,
                  function()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({modkey, "Shift"}, "#" .. i + 9,
                  function()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({modkey, "Control", "Shift"}, "#" .. i + 9,
                  function()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

-- bind them all
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- global rule
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            keys = clientkeys,
            buttons = clientbuttons,
	    size_hints_honor = false
        }
    }
}
-- }}}

-- {{{ Signals
client.connect_signal("manage",
    function(c, startup)
        -- enable sloppy focus
        c:connect_signal("mouse::enter",
            function(c)
                if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                    and awful.client.focus.filter(c) then
                    client.focus = c
                end
            end)

        if not startup and not c.size_hints.user_position
            and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
)

-- disable border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized_horizontal == true and c.maximized_vertical == true then
            c.border_width = 0
            c.border_color = beautiful.border_normal
        else
            c.border_width = beautiful.border_width
            c.border_color = beautiful.border_focus
        end
    end
)

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))

        if #clients > 0 then -- Fine grained borders and floaters control
            for _, c in pairs(clients) do -- Floaters always have borders
                if awful.client.floating.get(c) or layout == "floating" then
                    c.border_width = beautiful.border_width

                -- No borders with only one visible client
                elseif #clients == 1 or layout == "max" then
                    clients[1].border_width = 0
                    awful.client.moveresize(0, 0, 2, 2, clients[1])
                else
                    c.border_width = beautiful.border_width
                end
            end
        end
      end)
end
-- }}}
