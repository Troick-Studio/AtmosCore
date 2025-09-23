------------------ Inicio ------------------
local Main = {}
Main.Command = {}
------------------ Requires ----------------
local CycleManager = require(script.Parent.Manager["Cycle.Manager"])
local CalendarManager = require(script.Parent.Manager["Calendar.Manager"])
local LoopManager = require(script.Parent.Manager["Loop.Manager"])
local RemoteManager = require(script.Parent.Manager["Remote.Manager"])
local EventsManager = require(script.Parent.Manager["Events.Manager"])
local CalendarModel = require(script.Parent.Domains.Calendar["Calendar.Model"])
local CycleModel = require(script.Parent.Domains.Cycle["Cycle.Model"])
local RunService = game:GetService("RunService")
local GlobalConfigs = require(script.Parent["Global.Configs"])
------------------ Variáveis ----------------
local Settings = nil
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
            Settings = settings
            for name, value in pairs(settings) do
                if name == "Seed" then
                    GlobalConfigs.Seed = value
                elseif name == "LengthOfDayInMinutes" then
                    CycleModel.Duration.LengthOfDayInMinutes = value
                    CycleModel.CycleVariables.Speed = 1440 / (value * 60)
                end
            end
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

game.Players.PlayerAdded:Connect(function(Player)
    CycleModel.Commands.ReSync(Player)
    EventsManager.FireAllClients("SyncDate", CalendarModel.Date)
    EventsManager.FireClient(Player, "SyncSettings", Settings)
end)

Main.OnNight = CycleManager.Bindable.OnNight
Main.OnSunrise = CycleManager.Bindable.OnSunrise
Main.OnDay = CalendarManager.Bindable.OnDay
Main.OnMonth = CalendarManager.Bindable.OnMonth
Main.OnYear = CalendarManager.Bindable.OnYear
Main.OnSeason = CalendarManager.Bindable.OnSeason
Main.OnTimeChanged = CycleManager.Bindable.OnTimeChanged

------------------ Retornos ------------------
return Main
----------------------------------------------
