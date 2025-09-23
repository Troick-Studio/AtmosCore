------------------- Inicio -------------------
local RemoteController = {}
------------------- Requires -----------------
local EventsManager = require(script.Parent.Parent.Parent.Manager["Events.Manager"])
local CycleController = require(script.Parent.Parent.Parent.Domains.Cycle["Cycle.Controller"])
local CalendarModel = require(script.Parent.Parent.Parent.Domains.Calendar["Calendar.Model"])
local CycleModel = require(script.Parent.Parent.Parent.Domains.Cycle["Cycle.Model"])
local GlobalConfigs = require(script.Parent.Parent.Parent["Global.Configs"])
------------------ Variáveis -----------------

------------------- Funções ------------------

RemoteController.Init = function() 
    EventsManager.OnClient("Sync", function(Data) CycleController.Sync(Data) end)
    EventsManager.OnClient("SyncDate", function(Date) CalendarModel.Date = Date end)

    EventsManager.OnClient("SyncSettings", function(Data) 
        for name, value in pairs(Data) do
            if name == "Seed" then
                GlobalConfigs.Seed = value
            elseif name == "LengthOfDayInMinutes" then
                CycleModel.Duration.LengthOfDayInMinutes = value
                CycleModel.CycleVariables.Speed = 1440 / (value * 60)
            end
        end
    end)
end

------------------ Retornos ------------------
return RemoteController
----------------------------------------------