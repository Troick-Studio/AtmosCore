------------------- Inicio -------------------
local CycleModel = {}
------------------- Requires -----------------
local EventsManager = require(script.Parent.Parent.Parent.Manager["Events.Manager"])
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
------------------ Variáveis -----------------

CycleModel.Enabled = true
CycleModel.NightTriggered = false
CycleModel.MoonChange = false

CycleModel.OnNight = Instance.new("BindableEvent")
CycleModel.OnSunrise = Instance.new("BindableEvent")
CycleModel.OnTimeChanged = Instance.new("BindableEvent") 

CycleModel.Duration = {
	LengthOfDayInMinutes = 1,
	Length = 5 * 60,
	Step = 0.1
}

CycleModel.Clock = {
    MinutesAfterMidnight = 9.1 * 60, 
    Time = function()
        local Time = CycleModel.Clock.MinutesAfterMidnight / 60
        -- local TimeFormat = {
        --     Hours = math.floor(Time), 
        --     Minutes = math.floor((Time - math.floor(Time)) * 60)
        -- }
        
        return Time
        -- return {Raw = TimeFormat, Format = string.format("%02d:%02d", TimeFormat.Hours, TimeFormat.Minutes)}
    end,
}

CycleModel.CycleVariables = {
    Speed = 1440 / (CycleModel.Duration.LengthOfDayInMinutes * 60),
    CycleLength = 1440,
    Value = CycleModel.Clock.MinutesAfterMidnight,
}

CycleModel.Commands = {
    Set = function(CommandValue)
        CycleModel.Clock.MinutesAfterMidnight = (CommandValue * 60)  % 1440
        Lighting:SetMinutesAfterMidnight(CommandValue * 60)
        CycleModel.OnTimeChanged:Fire(CycleModel.Clock.MinutesAfterMidnight)
        if (CommandValue >= 18 and CommandValue <= 24) or (CommandValue >= 0 and CommandValue <= 6) then CycleModel.OnNight:Fire()
        elseif CommandValue >= 6.5 and CommandValue <= 18 then CycleModel.OnSunrise:Fire() end
    end,
    ReSync = function(Player, Data)
        if RunService:IsClient() then
            CycleModel.Clock.MinutesAfterMidnight = EventsManager.InvokeServer("ReSync")
            return CycleModel.Clock.MinutesAfterMidnight
        end

        if typeof(Player) == "table" then
            for _, Player in ipairs(Player) do
                EventsManager.FireClient(Player, "Sync", {
                    Time = CycleModel.Clock.MinutesAfterMidnight,
                    SyncData = {
                        CycleModel.CycleVariables.Speed,
                        CycleModel.CycleVariables.CycleLength,
                        CycleModel.CycleVariables.Value,
                    },
                })
            end
            return {Player, CycleModel.Clock.MinutesAfterMidnight}
        end

        EventsManager.FireClient(Player, "Sync", {
            Time = CycleModel.Clock.MinutesAfterMidnight,
            SyncData = {
                CycleModel.CycleVariables.Speed,
                CycleModel.CycleVariables.CycleLength,
                CycleModel.CycleVariables.Value,
            },
        })
        return {Player, CycleModel.Clock.MinutesAfterMidnight} 
    end,
    Get = function()
        return CycleModel.Clock.MinutesAfterMidnight
    end,
    Stop = function()
        CycleModel.Enabled = false
    end,
    Start = function()
        CycleModel.Enabled = true
    end,
    Toggle = function()
        CycleModel.Enabled = not CycleModel.Enabled
    end,
}

------------------ Retornos ------------------
return CycleModel
----------------------------------------------