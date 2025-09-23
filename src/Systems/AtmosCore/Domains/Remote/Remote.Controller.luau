------------------- Inicio -------------------
local RemoteController = {}
------------------- Requires -----------------
local EventsManager = require(script.Parent.Parent.Parent.Manager["Events.Manager"])
local CycleController = require(script.Parent.Parent.Parent.Domains.Cycle["Cycle.Controller"])
local CalendarModel = require(script.Parent.Parent.Parent.Domains.Calendar["Calendar.Model"])
------------------ Variáveis -----------------

------------------- Funções ------------------

RemoteController.Init = function() 
    EventsManager.OnClient("Sync", function(Data)
        CycleController.Sync(Data)
    end)

    EventsManager.OnClient("SyncDate", function(Date)
        CalendarModel.Date = Date
    end)
end

------------------ Retornos ------------------
return RemoteController
----------------------------------------------