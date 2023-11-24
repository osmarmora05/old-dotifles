-- by chadcat7

local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local helpers = require('helpers')
local dpi = beautiful.xresources.apply_dpi

-- Widgets
----------
local date_widget = function(date, weekend)
  weekend = weekend or false
  return wibox.widget {
    markup = weekend and helpers.colorize_text(date, beautiful.green) or date,
    halign = 'center',
    font   = beautiful.font_sans .. ' 10', -- Number of days , columns 'su' and 'sa'
    widget = wibox.widget.textbox
  }
end

local day_widget = function(day, weekend)
  weekend = weekend or false
  return wibox.widget {
    markup = weekend and helpers.colorize_text(day, beautiful.red) or day,
    halign = 'center',
    font   = beautiful.font_sans .. ' 10', -- Title days
    widget = wibox.widget.textbox
  }
end

local currwidget = function(day)
  return wibox.widget {
    markup = helpers.colorize_text(day, beautiful.yellow),
    halign = 'center',
    font   = beautiful.font_sans .. ' 12',-- Current day
    widget = wibox.widget.textbox
  }
end

local title = wibox.widget {
  font = beautiful.font_sans, -- Month title 
  widget = wibox.widget.textbox,
  halign = 'center'
}

local theGrid = wibox.widget {
  forced_num_rows = 7,
  forced_num_cols = 7,
  vertical_spacing = dpi(12),
  horizontal_spacing = dpi(15),
  min_cols_size = dpi(10),
  min_rows_size = dpi(10),
  homogenous = true,
  layout = wibox.layout.grid,
}

local curr = os.date('*t')

local update_calendar = function(date)
  local monthName = os.date('%B', os.time(date))
  title.text = monthName:gsub('^%l', string.upper) .. ' ' .. os.date('%Y', os.time(date))
  theGrid:reset()
  for _, w in ipairs { 'Su', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sa' }  do
    if w == 'Su' or w == 'Sa' then
      theGrid:add(day_widget(w, true))
    else
      theGrid:add(day_widget(w, false))
    end
  end
  local first_date = os.date('*t', os.time({ day = 1, month = date.month, year = date.year }))
  local last_date = os.date('*t', os.time({ day = 0, month = date.month + 1, year = date.year }))

  local row = 2
  local col = first_date.wday

  for day = 1, last_date.day do
    if day == date.day then
      theGrid:add_widget_at(currwidget(day), row, col)
    elseif col == 1 or col == 7 then
      theGrid:add_widget_at(date_widget(day, true), row, col)
    else
      theGrid:add_widget_at(date_widget(day, false), row, col)
    end

    if col == 7 then
      col = 1
      row = row + 1
    else
      col = col + 1
    end
  end
end

local reset_calendar = function()
  curr = os.date('*t')
  update_calendar(curr)
end

-- Initial call when updating the calendar
reset_calendar()

-- Calendar Widget
local calendar_widget = wibox.widget {
  {
    {
      {
        {
          {
            text = '󰁍',
            font = beautiful.font_icon.. ' 10',
            widget = wibox.widget.textbox,
            buttons = awful.button({}, 1, function()
              curr = os.date('*t', os.time({
                day = curr.day,
                month = curr.month - 1,
                year = curr.year
              }))
              update_calendar(curr)
            end)
          },
          title,
          {
            text = '󰁔',
            font = beautiful.font_icon.. ' 10',
            widget = wibox.widget.textbox,
            buttons = awful.button({}, 1, function()
              curr = os.date('*t', os.time({
                day = curr.day,
                month = curr.month + 1,
                year = curr.year
              }))
              update_calendar(curr)
            end)
          },
          layout = wibox.layout.align.horizontal
        },
        theGrid,
        spacing = 24,
        layout = wibox.layout.fixed.vertical
      },
      widget = wibox.container.margin,
      margins = {
        right = dpi(32), left = dpi(32), top = dpi(18), bottom = dpi(18)     },
    },
    widget = wibox.container.background,
    bg = beautiful.bg_light,
    shape = helpers.rounded_rect(dpi(4))

  },
  widget = wibox.container.margin,
  bottom = 0,
}

-- Export function reset_calendar
calendar_widget.reset_calendar = reset_calendar

return calendar_widget