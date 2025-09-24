------------------- Inicio -------------------
local RemoteManager = {}
------------------- Requires -----------------
local EventsManager = require(script.Parent["Events.Manager"])
local RemoteController = require(script.Parent.Parent.Domains.Remote["Remote.Controller"])
local RemoteService = require(script.Parent.Parent.Domains.Remote["Remote.Service"])
local RunService = game:GetService("RunService")
------------------ Variáveis -----------------

------------------- Funções ------------------

RemoteManager.Init = function()
    EventsManager.CreateEvents({ Name = "Sync", Type = "RemoteEvent" })
    EventsManager.CreateEvents({ Name = "SyncSettings", Type = "RemoteEvent" })
    EventsManager.CreateEvents({ Name = "SyncDate", Type = "RemoteEvent" })
    EventsManager.CreateEvents({ Name = "ToggleTime", Type = "RemoteEvent" })
    EventsManager.CreateEvents({ Name = "ReSync", Type = "RemoteFunction" })
    EventsManager.CreateEvents({ Name = "Command", Type = "RemoteFunction" })
    EventsManager.CreateEvents({ Name = "ExecuteCommand", Type = "RemoteEvent" })

    if RunService:IsClient() then RemoteController.Init()
    else RemoteService.Init() end
end

------------------ Retornos ------------------
return RemoteManager
----------------------------------------------