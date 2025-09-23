------------------- Inicio -------------------
local CalendarService = {}
CalendarService.Advance = {}
------------------- Requires -----------------
local CalendarModel = require(script.Parent["Calendar.Model"])
local EventsManager = require(script.Parent.Parent.Parent.Manager["Events.Manager"])
------------------ Variáveis -----------------
local OnDay = Instance.new("BindableEvent")
local OnMonth = Instance.new("BindableEvent")
local OnYear = Instance.new("BindableEvent")
local OnSeason = Instance.new("BindableEvent")
------------------- Funções ------------------

CalendarService.Advance.Day = function()
    if CalendarModel.Date.Day == CalendarModel.DaysInMonth(CalendarModel.Date.Month, CalendarModel.Date.Year) then
        CalendarModel.Date.Day = 1
        CalendarService.Advance.Month()
        OnDay:Fire(CalendarModel.Date.Day)
        return
    end

    CalendarModel.Date.Day += 1
    OnDay:Fire(CalendarModel.Date.Day)

    EventsManager.FireAllClients("SyncDate", CalendarModel.Date)
end

CalendarService.Advance.Month = function()
    if CalendarModel.Date.Season ~= CalendarModel.GetSeason() then
        CalendarModel.Date.Season = CalendarModel.GetSeason()
        OnSeason:Fire(CalendarModel.Date.Season)
    end

    if CalendarModel.Date.Month == 12 then
        CalendarModel.Date.Month = 1
        CalendarService.Advance.Year()
        OnMonth:Fire({Number = CalendarModel.Date.Month, Name = CalendarModel.Month.GetName()})
        return
    end

    CalendarModel.Date.Month += 1
    OnMonth:Fire({Number = CalendarModel.Date.Month, Name = CalendarModel.Month.GetName()})

    EventsManager.FireAllClients("SyncDate", CalendarModel.Date)
end

CalendarService.Advance.Year = function()
    CalendarModel.Date.Year += 1
    OnYear:Fire(CalendarModel.Date.Year)

    EventsManager.FireAllClients("SyncDate", CalendarModel.Date)
end

CalendarService.OnDay = OnDay.Event
CalendarService.OnMonth = OnMonth.Event
CalendarService.OnYear = OnYear.Event
CalendarService.OnSeason = OnSeason.Event

------------------ Retornos ------------------
return CalendarService
----------------------------------------------