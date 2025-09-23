------------------- Inicio -------------------
local CloudsManager = {}
------------------- Requires -----------------
local CloudsController = require(script.Parent.Parent.Domains.Clouds["Clouds.Controller"])
-- local CloudsModel = require(script.Parent.Parent.Domains.Clouds["Clouds.Model"])
local LoopManager = require(script.Parent["Loop.Manager"])
------------------ Variáveis -----------------

------------------- Funções ------------------

CloudsManager.Init = function()
    CloudsController.Dynamic()
    LoopManager.Add(function()
        CloudsController.Start()
    end)
end

------------------ Retornos ------------------
return CloudsManager
----------------------------------------------