local wibox        = require('wibox')
local awful        = require('awful')
local beautiful    = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi
local helpers      = require('helpers')
local screenshot    = require('script.screenshot')


local function status_widget(icon, action)
  local status = wibox.widget {
      {
          {
              id     = 'text_role',
              text   = icon,
              font   = beautiful.font_icon .. '16',
              align  = 'center',
              widget = wibox.widget.textbox
          },
          margins = dpi(18),
          widget  = wibox.container.margin
      },
      bg     = beautiful.mid_dark,
      widget = wibox.container.background,
      shape  = helpers.rounded_rect(dpi(35)),
      buttons = {
          awful.button({}, 1, action)
      },
      set_text = function(self, content)
          self:get_children_by_id('text_role')[1].text = content
      end
  }


  status:connect_signal('mouse::enter', function()
    status.bg = beautiful.mid_normal
 end)
 status:connect_signal('mouse::leave', function()
  status.bg = beautiful.mid_dark
 end)

 return status
end


local wifi_btn = status_widget('', function() awesome.emit_signal('network::toggle') end)
local bluetooth_btn = status_widget('',function() awesome.emit_signal('bluetooth::toggle') end)
local microphone_btn = status_widget('',function() awesome.emit_signal('microphone::mute') end)
local screenshot_btn = status_widget('',screenshot.screen)
--󰍬

awesome.connect_signal('signal::network', function(is_enabled)
    wifi_btn.text   = is_enabled and '' or ''
end)

awesome.connect_signal('signal::bluetooth', function(is_enabled)
    bluetooth_btn.text   = is_enabled and '' or ''
end)

awesome.connect_signal('signal::microphone', function(mic_level, mic_muted)
    microphone_btn.text   = mic_muted and '' or ''
end)


-- Final widgets
return wibox.widget{
    {
        {
            {
                wifi_btn,
                bluetooth_btn,
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(18)
            },
            {
                microphone_btn,
                screenshot_btn,
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(18)
            },
            layout = wibox.layout.fixed.vertical,
            spacing = dpi(12)
        },
        margins = dpi(16),
        widget = wibox.container.margin
    },
    bg = beautiful.bg_light,
    shape = helpers.rounded_rect(dpi(4)),
    forced_height = dpi(160),
    widget = wibox.container.background
}