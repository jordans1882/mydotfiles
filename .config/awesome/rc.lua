-- {{{ Document Header
-- Author: Jordan Schupbach
-- Filename: rc.lua
-- Purpose:
-- }}} Document Header

-- {{{ Load libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os
local table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
--local menubar       = require("menubar")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local table_join    = awful.util.table.join or gears.table.join -- 4.{0,1} compatibility
-- local conky = require("conky")

-- }}} Load libraries

-- {{{ Hotkey help

-- {{{ vim
local vim_rule_any = {name={"vim", "VIM"}}
for group_name, group_data in pairs({
    ["VIM: motion"] =             { color="#009F00", rule_any=vim_rule_any },
    ["VIM: command"] =            { color="#aFaF00", rule_any=vim_rule_any },
    ["VIM: command (insert)"] =   { color="#cF4F40", rule_any=vim_rule_any },
    ["VIM: operator"] =           { color="#aF6F00", rule_any=vim_rule_any },
    ["VIM: find"] =               { color="#65cF9F", rule_any=vim_rule_any },
    ["VIM: scroll"] =             { color="#659FdF", rule_any=vim_rule_any },
}) do
    hotkeys_popup.add_group_rules(group_name, group_data)
end


local vim_keys = {

    ["VIM: motion"] = {{
        modifiers = {},
        keys = {
            ['`']="goto mark",
            ['0']='"hard" BOL',
            ['-']="prev line",
            w="next word",
            e="end word",
            ['[']=". misc",
            [']']=". misc",
            ["'"]=". goto mk. BOL",
            b="prev word",
            ["|"]='BOL/goto col',
            ["$"]='EOL',
            ["%"]='goto matching bracket',
            ["^"]='"soft" BOL',
            ["("]='sentence begin',
            [")"]='sentence end',
            ["_"]='"soft" BOL down',
            ["+"]='next line',
            W='next WORD',
            E='end WORD',
            ['{']="paragraph begin",
            ['}']="paragraph end",
            G='EOF/goto line',
            H='move cursor to screen top',
            M='move cursor to screen middle',
            L='move cursor to screen bottom',
            B='prev WORD',
        }
    }, {
        modifiers = {"Ctrl"},
        keys = {
            u="half page up",
            d="half page down",
            b="page up",
            f="page down",
            o="prev mark",
        }
    }},

    ["VIM: operator"] = {{
        modifiers = {},
        keys = {
            ['=']="auto format",
            y="yank",
            d="delete",
            c="change",
            ["!"]='external filter',
            ['&lt;']='unindent',
            ['&gt;']='indent',
        }
    }},

    ["VIM: command"] = {{
        modifiers = {},
        keys = {
            ['~']="toggle case",
            q=". record macro",
            r=". replace char",
            u="undo",
            p="paste after",
            gg="go to the top of file",
            gf="open file under cursor",
            x="delete char",
            v="visual mode",
            m=". set mark",
            ['.']="repeat command",
            ["@"]='. play macro',
            ["&amp;"]='repeat :s',
            Q='ex mode',
            Y='yank line',
            U='undo line',
            P='paste before cursor',
            D='delete to EOL',
            J='join lines',
            K='help',
            [':']='ex cmd line',
            ['"']='. register spec',
            ZZ='quit and save',
            ZQ='quit discarding changes',
            X='back-delete',
            V='visual lines selection',
        }
    }, {
        modifiers = {"Ctrl"},
        keys = {
            w=". window operations",
            r="redo",
            ["["]="normal mode",
            a="increase number",
            x="decrease number",
            g="file/cursor info",
            z="suspend",
            c="cancel/normal mode",
            v="visual block selection",
        }
    }},

    ["VIM: command (insert)"] = {{
        modifiers = {},
        keys = {
            i="insert mode",
            o="open below",
            a="append",
            s="subst char",
            R='replace mode',
            I='insert at BOL',
            O='open above',
            A='append at EOL',
            S='subst line',
            C='change to EOL',
        }
    }},

    ["VIM: find"] = {{
        modifiers = {},
        keys = {
            [';']="repeat t/T/f/F",
            [',']="reverse t/T/f/F",
            ['/']=". find",
            ['?']='. reverse find',
            n="next search match",
            N='prev search match',
            f=". find char",
            F='. reverse find char',
            t=". 'till char",
            T=". reverse 'till char",
            ["*"]='find word under cursor',
            ["#"]='reverse find under cursor',
        }
    }},

    ["VIM: scroll"] = {{
        modifiers = {},
        keys = {
            zt="scroll cursor to the top",
            zz="scroll cursor to the center",
            zb="scroll cursor to the bottom",
        }
    },{
        modifiers = {"Ctrl"},
        keys = {
            e="scroll line up",
            y="scroll line down",
        }
    }},
}

hotkeys_popup.add_hotkeys(vim_keys)

-- }}} vim

-- {{{ tmux

local tmux = {}

function tmux.add_rules_for_terminal(rule)
    for group_name, group_data in pairs({
        ["tmux: sessions"] = rule,
        ["tmux: windows"]  = rule,
        ["tmux: panes"]    = rule,
        ["tmux: misc"]     = rule,
    }) do
        hotkeys_popup.add_group_rules(group_name, group_data)
    end
end

local tmux_keys = {
    ["tmux: sessions"] = {{
        modifiers = {},
        keys = {
            s     = "show all sessions",
            ['$'] = "rename the current session",
            ['('] = "move to previous session",
            [')'] = "move to next session",
            d     = "detach from current session"
        }
    }},

    ["tmux: windows"] = {{
        modifiers = {},
        keys = {
            c         = "create window",
            f         = "find window",
            [',']     = "rename current window",
            --['&']     = "close current window",
            p         = "previous window",
            n         = "next window",
            ['0...9'] = "select window by number"
        }
    }},

    ["tmux: panes"] = {{
        modifiers = {},
        keys = {
            [';']       = "toggle last active pane",
            ['%']       = "split pane vertically",
            ['"']       = "split pane horizontally",
            ['{']       = "move the current pane left",
            ['}']       = "move the current pane right",
            ['q 0...9'] = "select pane by number",
            o           = "toggle between panes",
            z           = "toggle pane zoom",
            ['space']   = "toggle between layouts",
            ['!']       = "convert pane into a window",
            x           = "close current pane"
        }
    }},

    ["tmux: misc"] = {{
        modifiers = {},
        keys = {
            [':'] = "enter command mode",
            ['?'] = "list shortcuts",
            t     = "show clock"
        }
    }}
}
hotkeys_popup.add_hotkeys(tmux_keys)

-- }}} tmux

-- {{{ Tabbed
local tabbed = {}

function tabbed.add_rules_for_terminal(rule)
    for group_name, group_data in pairs({
        ["tabbed: general"] = rule
    }) do
        hotkeys_popup.add_group_rules(group_name, group_data)
    end
end

local tabbed_keys = {
    ["tabbed: general"] = {{
        modifiers = {},
        keys = {
            t     = "show clock"
        }
    }}
}

hotkeys_popup.add_hotkeys(tabbed_keys)

-- TODO: Add the following help

--       Ctrl-Shift-Return
--              open new tab
--
--       Ctrl-Shift-h
--              previous tab
--
--       Ctrl-Shift-l
--              next tab
--
--       Ctrl-Shift-j
--              move selected tab one to the left
--
--       Ctrl-Shift-k
--              move selected tab one to the right
--
--       Ctrl-Shift-u
--              toggle autofocus of urgent tabs
--
--       Ctrl-Tab
--              toggle between the selected and last selected tab
--
--       Ctrl-` open dmenu to either create a new tab appending the entered string or select an already existing tab.
--
--       Ctrl-q close tab
--
--       Ctrl-u focus next urgent tab
--
--       Ctrl-[0..9]
--              jumps to nth tab
--
--       F11    Toggle fullscreen mode.
--
-- }}} Tabbed

-- }}} Hotkey help

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
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end

run_once({ "unclutter -root" }) -- entries must be comma-separated
-- }}}

-- {{{ Variable definitions

local themes = {
    "blackburn",       -- 1
    "copland",         -- 2
    "dremora",         -- 3
    "holo",            -- 4
    "multicolor",      -- 5
    "powerarrow",      -- 6
    "powerarrow-dark", -- 7
    "rainbow",         -- 8
    "steamburn",       -- 9
    "vertex",          -- 10
    "smurf",           -- 11 Custom user theme (copland base)
}

local chosen_theme = themes[11]
local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "st"
local editor       = os.getenv("EDITOR") or "nvim"
local gui_editor   = "gvim"
-- local browser      = "tabbed -c vimb -e"
local browser      = "luakit"
local guieditor    = "atom"
local scrlocker    = "xlock"

awful.util.terminal = terminal
awful.util.tagnames = {"", "", "", "", "", "", "7", "8", "9"}
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    lain.layout.centerwork,
    lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}
awful.util.taglist_buttons = table_join(
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
awful.util.tasklist_buttons = table_join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function()
                         local instance = nil

                         return function ()
                             if instance and instance.wibox.visible then
                                 instance:hide()
                                 instance = nil
                             else
                                 instance = awful.menu.clients({ theme = { width = 250 } })
                             end
                        end
                     end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)
-- }}}

-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
})
--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Mouse bindings
root.buttons(table_join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = table_join(

    --awful.key({ modkey , altkey}, "k", function() conky.show_key("F12") end,
              --{description = "Show Conky", group = "hotkeys"}),
    -- User Keybinds
    awful.key({ modkey }, "p", function() awful.util.spawn("tabbed -c zathura -e") end,
              {description = "pdf viewer (zathura)", group = "hotkeys"}),
    awful.key({ modkey }, "x", function() awful.util.spawn("xscreensaver-command -lock") end,
              {description = "pavucontrol", group = "hotkeys"}),

    awful.key({ modkey }, "e", function() awful.util.spawn("thunar") end,
              {description = "thunar", group = "hotkeys"}),
    -- Take a screenshot
    -- https://github.com/lcpz/dots/blob/master/bin/screenshot
    awful.key({ altkey }, "p", function() os.execute("gnome-screenshot") end,
              {description = "take a screenshot", group = "hotkeys"}),

    -- X screen locker
    awful.key({ altkey, "Control" }, "l", function () os.execute("xscreensaver-command -lock") end,
              {description = "lock screen", group = "hotkeys"}),

    -- Hotkeys
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description = "show help", group="awesome"}),
    -- Tag browsing
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view  previous nonempty", group = "tag"}),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
              {description = "view  previous nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ altkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),
    awful.key({ modkey,           }, "w", function () awful.util.mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "add new tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "move tag to the left", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "move tag to the right", group = "tag"}),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey,           }, "d", function () awful.spawn("rofi -modi 'run,ssh' -show run") end,
              {description = "open rofi", group = "launcher"}),

    awful.key({ altkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ altkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Dropdown application
    awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end,
              {description = "dropdown application", group = "launcher"}),

    -- Widgets popups
    awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end,
              {description = "show calendar", group = "widgets"}),
    awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
              {description = "show filesystem", group = "widgets"}),
    awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
              {description = "show weather", group = "widgets"}),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 10") end,
              {description = "+10%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 10") end,
              {description = "-10%", group = "hotkeys"}),

    -- ALSA volume control
    --awful.key({ altkey }, "Up",
    awful.key({  }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume up", group = "hotkeys"}),
    --awful.key({ altkey }, "Down",
    awful.key({  }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume down", group = "hotkeys"}),
    --awful.key({ altkey }, "m",
    awful.key({  }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "toggle mute", group = "hotkeys"}),
    awful.key({ altkey, "Control" }, "m",
        function ()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume 100%", group = "hotkeys"}),
    awful.key({ altkey, "Control" }, "0",
        function ()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume 0%", group = "hotkeys"}),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            awful.spawn.with_shell("mpc toggle")
            beautiful.mpd.update()
        end,
        {description = "mpc toggle", group = "widgets"}),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.spawn.with_shell("mpc stop")
            beautiful.mpd.update()
        end,
        {description = "mpc stop", group = "widgets"}),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            awful.spawn.with_shell("mpc prev")
            beautiful.mpd.update()
        end,
        {description = "mpc prev", group = "widgets"}),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            awful.spawn.with_shell("mpc next")
            beautiful.mpd.update()
        end,
        {description = "mpc next", group = "widgets"}),
    awful.key({ altkey }, "0",
        function ()
            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            if beautiful.mpd.timer.started then
                beautiful.mpd.timer:stop()
                common.text = common.text .. lain.util.markup.bold("OFF")
            else
                beautiful.mpd.timer:start()
                common.text = common.text .. lain.util.markup.bold("ON")
            end
            naughty.notify(common)
        end,
        {description = "mpc on/off", group = "widgets"}),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function () awful.spawn("xsel | xsel -i -b") end,
              {description = "copy terminal to gtk", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function () awful.spawn("xsel -b | xsel") end,
              {description = "copy gtk to terminal", group = "hotkeys"}),

    -- User programs
    awful.key({ modkey }, "q", function () awful.spawn(browser) end,
              {description = "run browser", group = "launcher"}),
    awful.key({ modkey }, "a", function () awful.spawn(guieditor) end,
              {description = "run gui editor", group = "launcher"}),

    -- Default
    --[[ Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
    --]]
    --[[ dmenu

    awful.key({ modkey }, "x", function ()
        awful.spawn(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
        beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
		end,
        {description = "show dmenu", group = "launcher"})
   -- ]]
    -- Prompt
    awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey , "Shift"}, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
    --]]


)

clientkeys = table_join(
    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client,
              {description = "magnify client", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"}),
    awful.key({ modkey,  "Shift"         }, "t",      function (c) c.sticky = not c.sticky            end,
              {description = "toggle sticky", group = "client"}),
awful.key({ modkey, "Mod1"    }, "Right",     function () awful.tag.incmwfact( 0.01)    end), -- add descriptions
awful.key({ modkey, "Mod1"    }, "Left",     function () awful.tag.incmwfact(-0.01)    end),
awful.key({ modkey, "Mod1"    }, "Down",     function () awful.client.incwfact( 0.01)    end),
awful.key({ modkey, "Mod1"    }, "Up",     function () awful.client.incwfact(-0.01)    end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = table_join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

clientbuttons = table_join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },

    -- Set Firefox to always map on the first tag on screen 1.
--    { rule = { class = "Firefox" },
 --     properties = { screen = 1, tag = awful.util.tagnames[1] } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = table_join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 16}) : setup {
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
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- No border for maximized clients
function border_adjust(c)
    if c.maximized then -- no borders if only 1 client visible
        c.border_width = 0
    elseif #awful.screen.focused().clients > 1 then
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- -- {{{ Random backgrounds
-- -- {{{ Function definitions
--
-- -- scan directory, and optionally filter outputs
-- function scandir(directory, filter)
--     local i, t, popen = 0, {}, io.popen
--     if not filter then
--         filter = function(s) return true end
--     end
--     print(filter)
--     for filename in popen('ls -a "'..directory..'"'):lines() do
--         if filter(filename) then
--             i = i + 1
--             t[i] = filename
--         end
--     end
--     return t
-- end
--
-- -- }}}
--
-- -- configuration - edit to your liking
-- wp_index = 1
-- wp_timeout  = 1
-- wp_path = "~/Pictures/"
-- wp_filter = function(s) return string.match(s,"%.png$") or string.match(s,"%.jpg$") end
-- wp_files = scandir(wp_path, wp_filter)
--
-- -- setup the timer
-- wp_timer = timer { timeout = wp_timeout }
-- wp_timer:connect_signal("timeout", function()
--
--   -- set wallpaper to current index for all screens
--   for s = 1, screen.count() do
--     gears.wallpaper.maximized(wp_path .. wp_files[wp_index], s, true)
--   end
--
--   -- stop the timer (we don't need multiple instances running at the same time)
--   wp_timer:stop()
--
--   -- get next random index
--   wp_index = math.random( 1, #wp_files)
--
--   --restart the timer
--   wp_timer.timeout = wp_timeout
--   wp_timer:start()
-- end)
--
-- -- initial start when rc.lua is first run
-- wp_timer:start()
--
--
-- -- }}
-- --
-- -- To rotate the wallpapers randomly, just comment the {{ic|wallpaper_cmd}} line above, and add a script into your {{ic|.xinitrc}} with the codes below(for awesome <= 3.4 ):
-- -- {{bc|
-- -- while true;
-- -- do
-- --   awsetbg -r <path/to/the/directory/of/your/wallpapers>
-- --   sleep 15m
-- -- done &

-- }}} Random backgrounds

-- {{{ Autostart application and processes

awful.util.spawn_with_shell("~/.config/awesome/autostart.sh") -- Shell transperancy
-- awful.util.spawn_with_shell("xcompmgr")
awful.util.spawn_with_shell("compton")
awful.util.spawn_with_shell("nm-applet")
awful.util.spawn_with_shell("dropbox")
--awful.util.spawn_with_shell("urxvt -e vit")
-- -- Autorun programs
-- autorun = true
-- autorunApps =
-- {
--    "swiftfox",
--    "mutt",
--    "consonance",
--    "linux-fetion",
--    "weechat-curses",
-- }
-- if autorun then
--    for app = 1, #autorunApps do
--        awful.util.spawn(autorunApps[app])
--    end
-- end
--
-- }}} Autostart application and processes

-- {{{ vim modeline
-- vim: set foldmethod=marker ts=8 sw=3 tw=80 et :
-- }}} vim modeline
