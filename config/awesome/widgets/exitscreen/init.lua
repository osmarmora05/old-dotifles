-- by chadcat7

local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local helpers = require('helpers')

local powerofficon = '󰐥 '
local rebooticon = '󰜉 '
local exiticon = '󰈆 '
local suspendicon = '󰤄 '


local poweroffcommand = function()
  awful.spawn.with_shell('systemctl poweroff')
  awesome.emit_signal('hide::exit')
end

local rebootcommand = function()
  awful.spawn.with_shell('systemctl reboot')
  awesome.emit_signal('hide::exit')
end

local suspendcommnad = function ()
  awesome.emit_signal('hide::exit')
  awful.spawn.with_shell("systemctl suspend")
end

local exitcommand = function()
  awesome.quit()
end

local close = wibox.widget {
  {
    align = 'center',
    font = beautiful.font_icon .. ' 24',
    markup = helpers.colorize_text('󰅖', beautiful.red),
    widget = wibox.widget.textbox,
  },
  widget = wibox.container.place,
  halign = 'left',
  buttons = {
    awful.button({}, 1, function()
      awesome.emit_signal('hide::exit')
    end)
  },
}

local createButton = function(icon, cmd, color)
  local button = wibox.widget {
    {
      {
        id = 'text_role',
        align = 'center',
        font = beautiful.font_icon .. ' 45',
        markup = helpers.colorize_text(icon, color),
        widget = wibox.widget.textbox
      },
      margins = {
        left = dpi(100), right = dpi(70),
        top = dpi(70), bottom = dpi(70)
     },
      widget = wibox.container.margin
    },
    border_color = color,
    border_width = dpi(5),
    bg = beautiful.bg_normal,
    buttons = {
      awful.button({}, 1, function()
        cmd()
      end)
    },
    widget = wibox.container.background
  }
  button:connect_signal('mouse::enter', function(self)
    self.bg = color
    self:get_children_by_id('text_role')[1].markup = helpers.colorize_text(icon, beautiful.bg_normal)
  end)
  button:connect_signal('mouse::leave', function(self)
    self.bg = beautiful.bg_normal
    self:get_children_by_id('text_role')[1].markup = helpers.colorize_text(icon, color)
  end)
  return button
end



local poweroffbutton = createButton(powerofficon, poweroffcommand, beautiful.red)
local rebootbutton = createButton(rebooticon, rebootcommand, beautiful.blue)
local exitbutton = createButton(exiticon, exitcommand, beautiful.yellow)
local suspendbutton = createButton(suspendicon,suspendcommnad,beautiful.cyan)


local box = wibox.widget {
  {
    {
      poweroffbutton,
      rebootbutton,
      exitbutton,
      suspendbutton,
      layout = wibox.layout.fixed.horizontal,
      spacing = 40,
    },
    spacing = 20,
    layout = wibox.layout.fixed.vertical
  },
  widget = wibox.container.place,
  halign = 'center',
}
local exit_screen_grabber = awful.keygrabber({
  auto_start = true,
  stop_event = 'release',
  keypressed_callback = function(self, mod, key, command)
    if key == 'e' then
      exitcommand()
    elseif key == 'p' then
      poweroffcommand()
    elseif key=='s' then
      suspendcommnad()
    elseif key == 'r' then
      rebootcommand()
    elseif key == 'Escape' or key == 'q' or key == 'x' then
      awesome.emit_signal('hide::exit')
    end
  end,
})


return function (s)
    local exit = wibox({
        type = 'dock',
        screen = s,
        height = s.geometry.height,
        width = s.geometry.width,
        bg = beautiful.bg_normal .. '44',
        ontop = true,
        visible = false,
    })
    
    exit:setup {
        {
            close,
            box,
            nil,
            expand = 'none',
            layout = wibox.layout.align.vertical,
        },
        margins = dpi(15),
        widget = wibox.container.margin,
    }

    awesome.connect_signal('toggle::exit', function()
        if exit.visible then
            exit_screen_grabber:stop()
            exit.visible = false
        else
            exit.visible = true
            exit_screen_grabber:start()
        end
    end)

    awesome.connect_signal('show::exit', function()
        exit_screen_grabber:start()
        exit.visible = true
    end)

    awesome.connect_signal('hide::exit', function()
        exit_screen_grabber:stop()
        exit.visible = false
    end)

    return exit
end