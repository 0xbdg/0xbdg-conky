#!/usr/bin/env lua
conky_color = "${color1}%2d${color}"
t = os.date('*t', os.time())
year, month, currentday = t.year, t.month, t.day
daystart = os.date("*t", os.time { year = year, month = month, day = 1 }).wday
month_name = os.date("%B", os.time { year = year, month = month, day = 1 })
days_in_month = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

LeapYear = function(y) return (y % 4 == 0 and (y % 100 ~= 0 or y % 400 == 0)) end
if LeapYear(year) then days_in_month[2] = 29 end
days = days_in_month[month]
local title = string.format("   %s %d\nSu Mo Tu We Th Fr Sa\n", month_name, year)
io.write(title)

io.write(string.rep("   ", daystart - 1))
for d = 1, days do
    if d == currentday then
        io.write((conky_color):format(d))
    else
        io.write(string.format("%2d ", d))
    end
    if ((daystart - 1 + d) % 7) == 0 then io.write("\n") end
end
io.write("\n")
