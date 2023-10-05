require('signals.naughty.error')
require('widgets.notification.base').init_actions()

local naughty = require('naughty')

naughty.connect_signal('request::display', function(n)
   require('widgets.notification.base').layout(n)
end)