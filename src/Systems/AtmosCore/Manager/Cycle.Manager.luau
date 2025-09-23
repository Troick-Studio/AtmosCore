------------------- Inicio -------------------
local CycleManager = {}
------------------- Requires -----------------
local RunService = game:GetService("RunService")
local CycleService = require(script.Parent.Parent.Domains.Cycle["Cycle.Service"])
local CycleController = require(script.Parent.Parent.Domains.Cycle["Cycle.Controller"])
------------------ Variáveis -----------------

------------------- Funções ------------------

--[[
    Inicia o loop do dia e noite
    @param Date {Year: number, Month: number, Day: number, Time: number}
]]
CycleManager.Init = function(Date)
    Date = Date or nil
    if RunService:IsClient() then
        CycleController.Start()
    else
        Date = {Year = Date.Year or 2023, Month = Date.Month or 1, Day = Date.Day or 1, Time = Date.Time or 9}
        CycleService.Start(Date)
    end
end

CycleManager.Command = function(Command, CommandValue)
    if RunService:IsClient() then
        return CycleController.Command(Command, CommandValue)
    end
    return CycleService.Command(Command, CommandValue)
end

CycleManager.Sync = function(Player)
    if not RunService:IsClient() then
        CycleService.Sync(Player)
    end
end

local CycleSource = if RunService:IsClient() then CycleController else CycleService

CycleManager.Bindable = {
    OnNight = CycleSource.OnNight,
    OnSunrise = CycleSource.OnSunrise,
    OnDay = CycleSource.OnDay,
    OnTimeChanged = CycleSource.OnTimeChanged
}

------------------ Retornos ------------------
return CycleManager
----------------------------------------------