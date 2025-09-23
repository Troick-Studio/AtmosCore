------------------ Inicio ------------------
local Main = {}
Main.Command = {}
------------------ Requires ----------------
local CycleManager = require(script.Parent.Manager["Cycle.Manager"])
local CalendarManager = require(script.Parent.Manager["Calendar.Manager"])
local LoopManager = require(script.Parent.Manager["Loop.Manager"])
local RemoteManager = require(script.Parent.Manager["Remote.Manager"])
local RunService = game:GetService("RunService")
------------------ Variáveis ----------------

------------------ Funções ------------------

Main.Init = function(data)
    local Data = data or nil
    RemoteManager.Init()
    CycleManager.Init(Data)
    LoopManager.Init()
    CalendarManager.Init(Data)

    if RunService:IsServer() then
        local Funcs = {}

        Funcs.Features = function(featuresSettings)
            -- for name, value in pairs(featuresSettings) do print(name, value) end
            return Funcs
        end

        Funcs.Settings = function(settings)
            -- for name, value in pairs(settings) do print(name, value) end
            return Funcs
        end

        return Funcs
    end

    return nil
end

Main.Command.Time = function(Command, CommandValue)
    return CycleManager.Command(Command, CommandValue)
end

Main.Sync = function(Player)
    CycleManager.Sync(Player)
end

------------------- Eventos ------------------

Main.OnNight = CycleManager.Bindable.OnNight
Main.OnSunrise = CycleManager.Bindable.OnSunrise
Main.OnDay = CycleManager.Bindable.OnDay
Main.OnTimeChanged = CycleManager.Bindable.OnTimeChanged

------------------ Retornos ------------------
return Main
----------------------------------------------
