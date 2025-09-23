------------------- Inicio -------------------
local CalendarController = {}
CalendarController.Advance = {}
------------------- Requires -----------------
local CalendarModel = require(script.Parent["Calendar.Model"])
------------------ Variáveis -----------------

------------------- Funções ------------------

CalendarController.Advance.Day = function()
    if CalendarModel.Date.Day == CalendarModel.DaysInMonth(CalendarModel.Date.Month, CalendarModel.Date.Year) then
        CalendarModel.Date.Day = 0
        CalendarModel.Date.Month += 1
    end
    CalendarModel.Date.Day += 1
end

------------------ Retornos ------------------
return CalendarController
----------------------------------------------