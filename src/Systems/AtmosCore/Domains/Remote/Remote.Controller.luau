------------------- Inicio -------------------
local RemoteController = {}
------------------- Requires -----------------
local EventsManager = require(script.Parent.Parent.Parent.Manager["Events.Manager"])
local CycleController = require(script.Parent.Parent.Parent.Domains.Cycle["Cycle.Controller"])

local CalendarModel = require(script.Parent.Parent.Parent.Domains.Calendar["Calendar.Model"])
local CommandsModel = require(script.Parent.Parent.Parent.Domains.Commands["Commands.Model"])
local CycleModel = require(script.Parent.Parent.Parent.Domains.Cycle["Cycle.Model"])
local VisualsModel = require(script.Parent.Parent.Parent.Domains.Visuals["Visuals.Model"])
local GlobalConfigs = require(script.Parent.Parent.Parent["Global.Configs"])
------------------ Variáveis -----------------

------------------- Funções ------------------

RemoteController.Init = function() 
    EventsManager.OnClient("Sync", function(Data) CycleController.Sync(Data) end)
    EventsManager.OnClient("SyncDate", function(Date) CalendarModel.Date = Date end)

    EventsManager.OnClient("ExecuteCommand", function(Data)
        local Type, Value = unpack(Data)
        CommandsModel.Commands[Type].Execute(Value)
    end)

    EventsManager.OnClient("SyncSettings", function(Data) 
        for name, value in pairs(Data) do
            if name == "Seed" then
                GlobalConfigs.Seed = value
            elseif name == "LengthOfDayInMinutes" then
                CycleModel.Duration.LengthOfDayInMinutes = value
                CycleModel.CycleVariables.Speed = 1440 / (value * 60)
            elseif name == "DayAndNightCycle" then
                CycleModel.Enabled = value
            elseif name == "BetterVisuals" then
                VisualsModel.Enabled = value
            elseif name == "Admins" then
                GlobalConfigs.Admins = value
            end
        end
    end)
end

------------------ Retornos ------------------
return RemoteController
----------------------------------------------