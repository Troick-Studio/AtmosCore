------------------- Inicio -------------------
local CalendarModel = {}
------------------- Requires -----------------

------------------ Variáveis -----------------

CalendarModel.Date = {
    Day = 1,
    Month = 1,
    Year = 1
}

CalendarModel.MonthDays = {
	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
}

CalendarModel.DaysInMonth = function(month, year)
	if month == 2 then
		if year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0) then
			return 29
		end
		return 28
	else
		return CalendarModel.MonthDays[month]
	end
end

------------------ Retornos ------------------
return CalendarModel
----------------------------------------------