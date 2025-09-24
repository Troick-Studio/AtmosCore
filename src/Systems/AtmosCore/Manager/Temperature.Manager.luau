------------------- Inicio -------------------
local TemperatureManager = {}
------------------- Requires -----------------
local RunService = game:GetService("RunService")
------------------ Variáveis -----------------
local TemperatureController = require(script.Parent.Parent.Domains.Temperature["Temperature.Controller"])
local TemperatureModel = require(script.Parent.Parent.Domains.Temperature["Temperature.Model"])
------------------- Funções ------------------

TemperatureManager.Init = function()

    if RunService:IsClient() then
        TemperatureController.Start()
        return
    end

end

TemperatureManager.Bindable = {
    OnTemperatureChanged = TemperatureModel.OnTemperatureChanged.Event
}

------------------ Retornos ------------------
return TemperatureManager
----------------------------------------------