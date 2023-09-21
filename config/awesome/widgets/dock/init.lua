local awful = require("awful")
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")
local helpers = require("helpers")
local beautiful = require("beautiful")
local getIcon = require("widgets.dock.getIcon")


local placeDock = function(c, m)
  awful.placement.bottom(c, { margins = dpi(m) })
end

local layout = wibox.layout.fixed.horizontal
local rlayout = wibox.layout.fixed.vertical
local flexlayout = wibox.layout.flex.horizontal

local tomfoolery = function(s)
  -- this is the main dock
  local dock = awful.popup {
    widget = wibox.container.background,
    ontop = true,
    bg = beautiful.bg_normal,
    visible = true,
    screen = s,
    height = 150,
    width = 600,
    placement = function(c) placeDock(c, 10) end,
    shape = helpers.rounded_rect(10)
  }

  local hotpop = wibox({
    type = "desktop",
    height = beautiful.useless_gap * 3,
    width = 200,
    screen = s,
    ontop = true,
    visible = true,
    bg = beautiful.transparent
  })
  placeDock(hotpop, 0)
  hotpop:setup {
    widget = wibox.container.margin,
    margins = 10,
    layout = layout
  }
  -- autohiding the dock
  local function check_for_dock_hide()
    for _, client in ipairs(s.selected_tag:clients()) do
      if client.fullscreen then
        dock.visible = false --disable dock on fullscreen
        hotpop.visible = false
        
    else
        hotpop.visible = true
    end
      
    end
    -- make dock visible if nothing is open
    if #s.selected_tag:clients() < 1 then
      dock.visible = true
      return
    end
    if s == mouse.screen then
      local minimized
      for _, c in ipairs(s.selected_tag:clients()) do
        if c.minimized then
          minimized = true
        end
        if c.maximized or c.fullscreen then
          dock.visible = false
          return
        end
        if not c.minimized then
          -- if client enters dock area then hide it
          local y = c:geometry().y
          local h = c.height
          if (y + h) >= s.geometry.height - 85 then
            dock.visible = false
            return
          else
            dock.visible = true
          end
        end
      end
      if minimized then
        dock.visible = true
      end
    else
      dock.visible = false
    end
  end
  -- a timer to check for dock hide
  local dockHide = gears.timer {
    timeout = 1,
    autostart = true,
    call_now = true,
    callback = function()
      check_for_dock_hide()
    end
  }
  dockHide:again()
  -- a hotarea at the bottom which will toggle the dock upon hover

  -- creating permannant elements like settings launcher, rofi launcher etc
  local createPermaElement = function(icon, cmd)
    return wibox.widget {
      forced_height = 50,
      forced_width = 50,
      image = "/usr/share/icons/WhiteSur/" .. icon,
      clip_shape = helpers.rounded_rect(8),
      buttons = {
        awful.button({}, 1, function()
          awful.spawn.with_shell(cmd)
        end)
      },
      widget = wibox.widget.imagebox,
    }
  end

  local createPermaElements = function()
    local trash = createPermaElement("/places/scalable/gnome-dev-trash-full.svg", "nemo trash:/")
    return wibox.widget {
      {
        trash,
        spacing = 7,
        layout = layout
      },
      widget = wibox.container.margin,
      left = 7
    }
  end
  -- indicators, idea from crylia
  local createDockIndicators = function(data)
    local clients = data.clients
    local indicators = wibox.widget { layout = flexlayout, spacing = 4 }
    for _, v in ipairs(clients) do
      local bac
      if v == client.focus then
        bac = beautiful.blue
      elseif v.urgent then
        bac = beautiful.red
      elseif v.minimized then
        bac = beautiful.mid_normal
      elseif v.maximized then
        bac = beautiful.yellow
      elseif v.fullscreen then
        bac = beautiful.cyan
      else
        bac = beautiful.fg_light
      end
      local widget = wibox.widget {
        forced_height = 4,
        forced_width = 45,
        shape = helpers.rounded_rect(50),
        widget = wibox.container.background,
        bg = bac
      }
      indicators:add(widget)
    end
    return wibox.widget {
      {
        {
          indicators,
          spacing = 10,
          layout = layout
        },
        widget = wibox.container.place,
        halign = 'center'
      },
      forced_height = 4,
      forced_width = 45,
      widget = wibox.container.background
    }
  end
  -- creating 1 icon on the dock
  local createDockElement = function(data)
    local class = string.lower(data.class)
    local command = string.lower(data.class)
    local customIcons = { -- use this to define icons and commands for stuff that dont have icons available :despair:
      {
        name = "st-256color",
        convert = "xterm",
        command = "st"
      },
      -- {
      --   name = "org.wezfurlong.wezterm",
      --   convert = "xterm",
      --   command = "wezterm"
      -- },
      -- {
      --   name = "ncmpcpppad",
      --   convert = "deepin-music-player",
      --   command = "awesome-client 'awesome.emit_signal(\"toggle::ncmpcpppad\")'"
      -- },
      {
        name = "neofetchpad",
        convert = "xterm",
      },
      {
        name = "feh",
        convert = "image-viewer"
      },
      {
        name = "code",
        convert = "visualstudiocode",
        command = "code"
      },
      {
        name = "discord",
        convert = "discord",
        command = "Discord"
      },
      {
        name = "obsidian",
        convert = "obsidian",
        command = "flatpak run md.obsidian.Obsidian"
      }
    }
    for _, v in pairs(customIcons) do
      if class == v.name then
        class = v.convert
        command = v.command
      end
    end
    local dockelement = wibox.widget {
      {
        {
          {
            forced_height = 50,
            forced_width = 50,
            buttons = {
              awful.button({}, 1, function()
                awful.spawn.with_shell(command)
              end)
            },
            image = getIcon(nil, class, class, false),
            clip_shape = helpers.rounded_rect(8),
            widget = wibox.widget.imagebox,
          },
          layout = layout
        },
        createDockIndicators(data),
        layout = rlayout
      },
      forced_width = 50,
      widget = wibox.container.background
    }
    return dockelement
  end


  -- the main function
  local createDockElements = function()
    local clients = {}
    for _, t in ipairs(s.tags) do
        gears.table.merge(clients, t:clients())
     end

    -- making some pinned apps
    local metadata = {
      {
        name = "nautilus",
        id = 1,
        count = 0,
        clients = {},
        class = "nautilus"
      },
      {
        count = 0,
        id = 2,
        clients = {},
        name = "kitty",
        class = "kitty"
      },
      {
        count = 0,
        id = 3,
        clients = {},
        name = "brave-browser",
        class = "brave-browser"
      },
      {
        count = 0,
        id = 4,
        name = "obsidian",
        clients = {},
        class = "obsidian"
      },
      {
        count = 0,
        id = 5,
        name = "code",
        clients = {},
        class = "code"
      },
      {
        count = 0,
        id = 6,
        name = "discord",
        clients = {},
        class = "discord"
      },
      {
        count = 0,
        id = 7,
        name = "firefox",
        clients = {},
        class = "firefox"
      },
      {
        count = 0,
        id = 8,
        name = "spotify",
        clients = {},
        class = "spotify"
      }
    }
    -- end
    local classes = { "kitty", "discord", "obsidian", "brave-browser", "spotify", "nautilus", "code","firefox" }
    local dockElements = wibox.widget { layout = layout, spacing = 5 }
    -- generating the data
    for _, c in ipairs(clients) do
      local class = string.lower(c.class)
      if helpers.inTable(classes, class) then
        for _, j in pairs(metadata) do
          if j.name == class then
            table.insert(j.clients, c)
            j.count = j.count + 1
          end
        end
      else
        table.insert(classes, class)
        local toInsert = {
          count = 1,
          id = #classes + 1,
          clients = { c },
          class = class,
          name = class,
        }
        table.insert(metadata, toInsert)
      end
    end
    table.sort(metadata, function(a, b) return a.id < b.id end)
    for _, j in pairs(metadata) do
      dockElements:add(createDockElement(j))
    end
    return dockElements
  end
  local refresh = function()
    check_for_dock_hide()
    dock:setup {
      {
        createDockElements(),
        createPermaElements(),
        layout = layout
      },
      widget = wibox.container.margin,
      margins = {
        top = 10,
        bottom = 7,
        left = 10,
        right = 10,
      },
    }
  end
  refresh()
  client.connect_signal( --
    "focus",
    function()
      refresh()
    end
  )
  client.connect_signal( --
    "property::minimized",
    function()
      refresh()
    end
  )
  client.connect_signal(
    "property::maximized",
    function()
      refresh()
    end
  )
  client.connect_signal( --4
    "manage",
    function()
      refresh()
    end
  )
  client.connect_signal( --
    "unmanage",
    function()
      refresh()
    end
  )
  hotpop:connect_signal("mouse::enter", function()
    dockHide:stop()
    dock.visible = true
  end)
  hotpop:connect_signal("mouse::leave", function()
    dockHide:again()
  end)
  dock:connect_signal("mouse::enter", function()
    dockHide:stop()
    dock.visible = true
  end)
  dock:connect_signal("mouse::leave", function()
    dockHide:again()
  end)
  end

return tomfoolery
