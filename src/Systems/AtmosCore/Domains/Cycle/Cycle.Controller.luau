------------------- Inicio -------------------
local CycleController = {}
------------------- Requires -----------------
local CycleModel = require(script.Parent["Cycle.Model"])
local LoopManager = require(script.Parent.Parent.Parent.Manager["Loop.Manager"])
-- local CalendarManager = require(script.Parent.Parent.Parent.Manager["Calendar.Manager"])
local CalendarModel = require(script.Parent.Parent.Calendar["Calendar.Model"])
------------------ Variáveis -----------------
local Lighting = game:GetService("Lighting")
local Synced = false
local NightTriggered = false

local OnNight = Instance.new("BindableEvent")
local OnSunrise = Instance.new("BindableEvent")
local OnDay = Instance.new("BindableEvent")
local OnTimeChanged = Instance.new("BindableEvent") 
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
            OnDay:Fire()
            print(CalendarModel.Date)
        end
        
        if CycleModel.CycleVariables.Value / 60 >= 17.9 and CycleModel.CycleVariables.Value / 60 <= 18.9 and not NightTriggered then
            NightTriggered = true
            OnNight:Fire()
        elseif CycleModel.CycleVariables.Value / 60 >= 5.9 and CycleModel.CycleVariables.Value / 60 <= 6.9 and NightTriggered then
            NightTriggered = false
            OnSunrise:Fire()
        end

        OnTimeChanged:Fire(CycleModel.CycleVariables.Value)
        Lighting:SetMinutesAfterMidnight(CycleModel.CycleVariables.Value)
        CycleModel.Clock.MinutesAfterMidnight = CycleModel.CycleVariables.Value
    end
end

CycleController.OnNight = OnNight.Event
CycleController.OnSunrise = OnSunrise.Event
CycleController.OnDay = OnDay.Event
CycleController.OnTimeChanged = OnTimeChanged.Event

------------------ Retornos ------------------
return CycleController
----------------------------------------------