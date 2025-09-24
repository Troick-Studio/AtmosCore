------------------- Inicio -------------------
local CalendarModel = {}
CalendarModel.Month = {}
------------------- Requires -----------------

------------------ Variáveis -----------------

CalendarModel.Date = {
    Day = 1,
    Month = 1,
    Year = 1,
    Season = nil
}

CalendarModel.Month.Days = {
	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
}

CalendarModel.Month.Names = {
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
}

CalendarModel.Month.GetName = function() return CalendarModel.Month.Names[CalendarModel.Date.Month] end

CalendarModel.Seasons = {
	{
		Name = "Spring",
		Months = {3, 4, 5},
		WeatherChances = {Sunny = 50, Rain = 25, Storm = 10, Wind = 15},
	},
	{
		Name = "Summer",
		Months = {6, 7, 8},
		WeatherChances = {Sunny = 60, Rain = 15, Storm = 10, Wind = 15},
	},
	{
		Name = "Autumn",
		Months = {9, 10, 11},
		WeatherChances = {Sunny = 40, Rain = 30, Storm = 10, Wind = 20},
	},
	{
		Name = "Winter",
		Months = {12, 1, 2},
		WeatherChances = {Sunny = 25, Rain = 15, Snow = 35, Storm = 10, Wind = 15},
	}
}

CalendarModel.DaysInMonth = function(month, year)
	if month == 2 then
		if year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0) then
			return 29
		end
		return 28
	else
		return CalendarModel.Month.Days[month]
	end
end

CalendarModel.GetSeason = function()
	for _, season in ipairs(CalendarModel.Seasons) do
		for _, m in ipairs(season.Months) do
			if m == CalendarModel.Date.Month then
				return season
			end
		end
	end
	return nil
end

------------------ Retornos ------------------
return CalendarModel
----------------------------------------------