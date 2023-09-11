local beautiful = require('beautiful')
local wibox     = require('wibox')

local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')
local widgets   = require('widgets.controlCenter.module')
local rubato    = require('modules.rubato')


local panel = wibox{
   ontop   = true,
   visible = false,
   width   = dpi(410),
   height  = dpi(640),
   --y       = dpi(55),
   x       = dpi(8),
   bg      = beautiful.bg_normal,
   shape   = helpers.rounded_rect(dpi(4)),
   widget = {
    {
        {
            
            { -- Top
                widgets.profile,
                widgets.setting,
                spacing = dpi(28),
                layout = wibox.layout.fixed.horizontal
            },
            { -- Middle
                widgets.sliders,
                spacing = dpi(28),
                layout = wibox.layout.fixed.horizontal
            }, -- Bottom
            widgets.themer,
            spacing = dpi(28),
            layout = wibox.layout.fixed.vertical
        },
        spacing = dpi(28),
        layout = wibox.layout.fixed.horizontal
    },
    margins = dpi(28),
    widget = wibox.container.margin

}

}

-- Animations
local slide = rubato.timed{
    pos = dpi(-panel.height),
    rate = 60,
    intro = 0.1,
    duration = 0.46,
    awestore_compat = true,
    subscribed = function(pos) panel.y = pos end
}

-- Flag
local controlCenter_status = false

slide.ended:subscribe(function()
    if controlCenter_status then
        panel.visible = false
    end
end)

local controlCenter_show = function()
    slide:set(dpi(55) + beautiful.useless_gap * 2)
    panel.visible = true
    controlCenter_status = false
end

local controlCenter_hide = function()
    slide:set(dpi(-panel.height))
    controlCenter_status = true
end

function panel:show()
    if panel.visible then
        controlCenter_hide()
    else
        controlCenter_show()
    end

    -- panel.visible = not panel.visible

    if panel.visible then
        widgets.themer.reset()
    end
 end


return panel