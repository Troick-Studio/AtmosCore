------------------- Inicio -------------------
local CycleController = {}
------------------- Requires -----------------
local CycleModel = require(script.Parent["Cycle.Model"])
local LoopManager = require(script.Parent.Parent.Parent.Manager["Loop.Manager"])
local MoonManager = require(script.Parent.Parent.Parent.Manager["Moon.Manager"])
local VisualsController = require(script.Parent.Parent.Visuals["Visuals.Controller"])
------------------ Variáveis -----------------
local Lighting = game:GetService("Lighting")
local Synced = false

local OnNight = CycleModel.OnNight
local OnSunrise = CycleModel.OnSunrise
local OnTimeChanged = CycleModel.OnTimeChanged
------------------- Funções ------------------

CycleController.Start = function()
    LoopManager.Add(CycleDayAndNight)
end

CycleController.Command = function(Command, CommandValue)
    if not Command then return end

    return CycleModel.Commands[Command](CommandValue)
end

CycleController.Sync = function(Data)
    CycleModel.CycleVariables.Speed, CycleModel.CycleVariables.CycleLength, CycleModel.CycleVariables.Value = unpack(Data.SyncData)
    CycleModel.Clock.MinutesAfterMidnight = CycleModel.CycleVariables.Value
    Synced = true
end

function CycleDayAndNight()
    if Synced and CycleModel.Enabled then
        CycleModel.CycleVariables.Value = (CycleModel.Clock.MinutesAfterMidnight + 0.1 * CycleModel.CycleVariables.Speed)
        if CycleModel.CycleVariables.Value / 60 >= 24 then
            CycleModel.CycleVariables.Value = CycleModel.CycleVariables.Value % CycleModel.CycleVariables.CycleLength
        end

        if CycleModel.CycleVariables.Value / 60 >= 17 and CycleModel.CycleVariables.Value / 60 <= 18 and not CycleModel.MoonChange then
            Lighting.Sky.MoonTextureId = MoonManager.Phase().Texture
            CycleModel.MoonChange = true
        elseif CycleModel.CycleVariables.Value / 60 >= 17.9 and CycleModel.CycleVariables.Value / 60 <= 18.9 and not CycleModel.NightTriggered then
            CycleModel.NightTriggered = true
            OnNight:Fire()
        elseif CycleModel.CycleVariables.Value / 60 >= 6.5 and CycleModel.CycleVariables.Value / 60 <= 7.5 and CycleModel.NightTriggered then
            CycleModel.NightTriggered = false
            CycleModel.MoonChange = false
            OnSunrise:Fire()
        end

        OnTimeChanged:Fire(CycleModel.CycleVariables.Value)
        Lighting:SetMinutesAfterMidnight(CycleModel.CycleVariables.Value)
        CycleModel.Clock.MinutesAfterMidnight = CycleModel.CycleVariables.Value
    end
    VisualsController.Start(CycleModel.Clock.MinutesAfterMidnight)
end

CycleController.OnNight = OnNight.Event
CycleController.OnSunrise = OnSunrise.Event
CycleController.OnTimeChanged = OnTimeChanged.Event

------------------ Retornos ------------------
return CycleController
----------------------------------------------