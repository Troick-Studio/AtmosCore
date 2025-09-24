------------------- Inicio -------------------
local CommandsManager = {}
------------------- Requires -----------------
local RunService = game:GetService("RunService")
local CommandsController = require(script.Parent.Parent.Domains.Commands["Commands.Controller"])
local CommandsService = require(script.Parent.Parent.Domains.Commands["Commands.Service"])
------------------ Variáveis -----------------

------------------- Funções ------------------

CommandsManager.Init = function()
    if RunService:IsClient() then
        CommandsController.Init()
    else
        CommandsService.Init()
    end
end

------------------ Retornos ------------------
return CommandsManager
----------------------------------------------