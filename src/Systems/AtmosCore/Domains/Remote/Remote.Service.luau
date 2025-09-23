------------------- Inicio -------------------
local RemoteService = {}
------------------- Requires -----------------
local EventsManager = require(script.Parent.Parent.Parent.Manager["Events.Manager"])
local CycleController = require(script.Parent.Parent.Parent.Domains.Cycle["Cycle.Controller"])
local CycleModel = require(script.Parent.Parent.Parent.Domains.Cycle["Cycle.Model"])
------------------ Variáveis -----------------

------------------- Funções ------------------

RemoteService.Init = function() 
    EventsManager.OnServer("ToggleTime", function(Data)
        CycleController.Sync(Data)
    end)

    EventsManager.OnServer("ReSync", function(Player)
        print("Enviando horario do servidor atual:", CycleModel.Clock.MinutesAfterMidnight)
        return CycleModel.Clock.MinutesAfterMidnight
    end)
end

------------------ Retornos ------------------
return RemoteService
----------------------------------------------