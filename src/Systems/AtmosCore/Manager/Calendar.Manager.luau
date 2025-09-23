------------------- Inicio -------------------
local CalendarManager = {}
CalendarManager.Advance = {}
------------------- Requires -----------------
-- local CalendarController = require(script.Parent.Parent.Domains.Calendar["Calendar.Controller"])
local CalendarService = require(script.Parent.Parent.Domains.Calendar["Calendar.Service"])
local CalendarModel = require(script.Parent.Parent.Domains.Calendar["Calendar.Model"])
local RunService = game:GetService("RunService")
------------------ Variáveis -----------------

------------------- Funções ------------------

CalendarManager.Init = function(Data)
    if RunService:IsServer() then
        CalendarModel.Date.Day = Data.Day
        CalendarModel.Date.Month = Data.Month
        CalendarModel.Date.Year = Data.Year
        CalendarModel.Date.Season = CalendarModel.GetSeason()
    end
end

CalendarManager.Advance.Day = function()
    if not RunService:IsClient() then
        CalendarService.Advance.Day()
    end
end

CalendarManager.Bindable = {
    OnDay = CalendarService.OnDay,
    OnMonth = CalendarService.OnMonth,
    OnYear = CalendarService.OnYear,
    OnSeason = CalendarService.OnSeason
}

------------------ Retornos ------------------
return CalendarManager
----------------------------------------------