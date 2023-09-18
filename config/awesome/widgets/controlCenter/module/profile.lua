-- Copyleft © 2022 Saimoomedits

local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local helpers = require('helpers')
local wibox = require('wibox')
local awful = require('awful')



-- widgets
----------

-- mask overlay
local overlayed = wibox.widget({
	{
		bg = beautiful.bg_normal .. 'ef',
		forced_height = dpi(100),
		forced_width = dpi(100),
		widget = wibox.container.background,
	},
	direction = 'east',
	widget = wibox.container.rotate,
})

-- image
local profile_image = wibox.widget {
	image       = beautiful.avatar,
    vertical_fit_policy   = 'fit',
    horizontal_fit_policy = 'fit',
    resize      = true,
    align       = 'center',
    widget      = wibox.widget.imagebox
}

-- username
local username = wibox.widget {
    markup = 'Welcome, <b>user!</b>',
    font   = beautiful.font_sans .. '12',
    align = 'left',
    widget = wibox.widget.textbox
}
awful.spawn.easy_async_with_shell(
    'whoami', function(stdout)
        local name           = stdout:match('(%w+)')
        username.markup = '<b>Hi,</b> ' .. name
    end
)



-- description/host
local desc = wibox.widget{
    widget = wibox.widget.textbox,
    markup = helpers.colorize_text('AwesomeWM is awesome', beautiful.fg_dark .. '99'),
    font = beautiful.font_sans .. '10',
    align = 'left',
    valign = 'center'
}


-- finalize
-----------
return wibox.widget{
	{
		{
				profile_image,
				overlayed,
				layout = wibox.layout.stack
		},
		{
    	{
			{
    			widget = wibox.widget.textbox,
    			markup = helpers.colorize_text('Howdy!', beautiful.fg_dark .. '33'),
    			font = beautiful.font_sans .. '11',
    			align = 'left',
    			valign = 'center'
			},
			nil,
        	{
          	  	username,
				desc,
           		layout = wibox.layout.fixed.vertical,
            	spacing = dpi(2)
        	},
        	layout = wibox.layout.align.vertical,
        	expand = 'none'
		},
		widget = wibox.container.margin,
		margins = dpi(16)
    	},
		layout = wibox.layout.stack,
	},
	widget = wibox.container.background,
	shape = helpers.rounded_rect(dpi(4)),
	forced_width = dpi(160),
	forced_height = dpi(160)
}