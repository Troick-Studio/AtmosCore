------------------- Inicio -------------------
local CycleService = {}
------------------- Requires -----------------
local CycleModel = require(script.Parent["Cycle.Model"])
local LoopManager = require(script.Parent.Parent.Parent.Manager["Loop.Manager"])
local CalendarManager = require(script.Parent.Parent.Parent.Manager["Calendar.Manager"])
------------------ Variáveis -----------------
local OnNight = Instance.new("BindableEvent")
local OnSunrise = Instance.new("BindableEvent")
local OnTimeChanged = Instance.new("BindableEvent") 
------------------- Funções ------------------

CycleService.Start = function(Date : {Year: number, Month: number, Day: number, Time: number})
    CycleModel.Clock.MinutesAfterMidnight = Date.Time * 60
    CycleModel.NightTriggered = Date.Time > 18 and true or false
    LoopManager.Add(function()
        if CycleModel.Enabled then
            CycleModel.CycleVariables.Value = (CycleModel.Clock.MinutesAfterMidnight + 0.1 * CycleModel.CycleVariables.Speed)

            if CycleModel.CycleVariables.Value / 60 >= 24 then
                CycleModel.CycleVariables.Value = CycleModel.CycleVariables.Value % CycleModel.CycleVariables.CycleLength
                CalendarManager.Advance.Day()
            end
            
            if CycleModel.CycleVariables.Value / 60 >= 17.9 and CycleModel.CycleVariables.Value / 60 <= 18.9 and not CycleModel.NightTriggered then
                CycleModel.NightTriggered = true
                OnNight:Fire()
            elseif CycleModel.CycleVariables.Value / 60 >= 6.5 and CycleModel.CycleVariables.Value / 60 <= 7.5 and CycleModel.NightTriggered then
                CycleModel.NightTriggered = false
                OnSunrise:Fire()
            end

            CycleModel.Clock.MinutesAfterMidnight = CycleModel.CycleVariables.Value
        end
    end)
end

CycleService.Command = function(Command, CommandValue)
    if not Command and CommandValue then return end

    return CycleModel.Commands[Command](CommandValue)
end

CycleService.Sync = function(Player)
    CycleModel.Commands.ReSync(Player)
end

CycleService.OnNight = OnNight.Event
CycleService.OnSunrise = OnSunrise.Event
CycleService.OnTimeChanged = OnTimeChanged.Event

------------------ Retornos ------------------
return CycleService
----------------------------------------------