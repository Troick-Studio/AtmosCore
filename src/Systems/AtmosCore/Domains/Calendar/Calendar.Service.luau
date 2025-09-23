------------------- Inicio -------------------
local CalendarService = {}
CalendarService.Advance = {}
------------------- Requires -----------------
local CalendarModel = require(script.Parent["Calendar.Model"])
local EventsManager = require(script.Parent.Parent.Parent.Manager["Events.Manager"])
------------------ Variáveis -----------------

------------------- Funções ------------------

CalendarService.Advance.Day = function()
    if CalendarModel.Date.Day == CalendarModel.DaysInMonth(CalendarModel.Date.Month, CalendarModel.Date.Year) then
        CalendarModel.Date.Day = 1
        CalendarService.Advance.Month()
        return
    end
    CalendarModel.Date.Day += 1
    EventsManager.FireAllClients("SyncDate", CalendarModel.Date)
end

CalendarService.Advance.Month = function()
    if CalendarModel.Date.Month == 12 then
        CalendarModel.Date.Month = 1
        CalendarService.Advance.Year()
        return
    end
    CalendarModel.Date.Month += 1
    EventsManager.FireAllClients("SyncDate", CalendarModel.Date)
end

CalendarService.Advance.Year = function()
    CalendarModel.Date.Year += 1
    EventsManager.FireAllClients("SyncDate", CalendarModel.Date)
end

------------------ Retornos ------------------
return CalendarService
----------------------------------------------