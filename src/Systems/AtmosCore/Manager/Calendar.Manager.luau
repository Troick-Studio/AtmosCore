------------------- Inicio -------------------
local CalendarManager = {}
CalendarManager.Advance = {}
------------------- Requires -----------------
local CalendarController = require(script.Parent.Parent.Domains.Calendar["Calendar.Controller"])
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
        print(CalendarModel.Date)
    end
end

CalendarManager.Advance.Day = function()
    if RunService:IsClient() then
        CalendarController.Advance.Day()
    else
        CalendarService.Advance.Day()
    end
end

------------------ Retornos ------------------
return CalendarManager
----------------------------------------------