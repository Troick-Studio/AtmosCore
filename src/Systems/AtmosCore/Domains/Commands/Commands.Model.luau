------------------- Inicio -------------------
local CommandsModel = {}
------------------- Requires -----------------
local CycleManager = require(script.Parent.Parent.Parent.Manager["Cycle.Manager"])
local CycleModel = require(script.Parent.Parent.Parent.Domains.Cycle["Cycle.Model"])
local VisualsModel = require(script.Parent.Parent.Parent.Domains.Visuals["Visuals.Model"])
------------------ Variáveis -----------------

CommandsModel.Commands = {
    TimeSet = {
        Name = "TimeSetCommand", 
        PrimaryAlias = "/time set",
        PreSettings = {
            day = 9,
            sunrise = 6.5,
            night = 21,
            moonset = 5.5
        },
        Type = "TimeSet",
        Arg = 3,
        Execute = function(value) 
            if tonumber(value) == nil then return end
            CycleManager.Command("Set", tonumber(value))
         end,
        Message = function(value) 
            if tonumber(value) then
                return `Tempo alterado para: {tonumber(value)}`
            else
                return '<font color="#ff2f40"><b>Erro ao definir tempo!</b></font>'
            end
         end
    },
    TimeAdd = {
        Name = "TimeAddCommand", 
        PrimaryAlias = "/time add",
        Type = "TimeAdd",
        Arg = 3,
        Execute = function(value) 
            if tonumber(value) then
                value = tonumber(value)
                print(CycleModel.Clock.MinutesAfterMidnight,value)
            
                CycleManager.Command("Set", (CycleModel.Clock.MinutesAfterMidnight / 60) + value)
            end
         end,
        Message = function(value) 
            if tonumber(value) then
                value = tonumber(value)
                local minutes = math.floor(value)
                local seconds = math.floor((value % 1) * 60)
                local ValueFormat = string.format("%d:%02d", minutes, seconds)
            
                return `Adicionado {ValueFormat} {value >= 2 and "horas" or value < 2 and "hora" or "minutos"} ao dia` 
            else
                return '<font color="#ff2f40"><b>Erro ao mudar tempo!</b></font>'
            end
        end
    },
    TimeSync = {
        Name = "TimeSyncCommand", 
        PrimaryAlias = "/time Sync",
        Type = "TimeSync",
        Arg = 2,
        Execute = function()           
                CycleManager.Command("ReSync")
         end,
        Message = function() 
            return `Tempo resincronizado`
        end
    },
    Visuals = {
        Name = "VisualsCommand", 
        PrimaryAlias = "/visuals",
        Type = "Visuals",
        Arg = 2,
        Execute = function(enable)
            local Enable = enable == "enable" and true or enable == "disable" and false or enable == "true" and true or enable == "false" and false or enable == true and true or false
            VisualsModel.Enabled = Enable
         end,
        Message = function(enable) 
            local Enable = enable == "enable" and true or enable == "disable" and false or enable == "true" and true or enable == "false" and false or enable == true and true or false
            return `Visual aprimorado {Enable and "habilitado" or "desabilitado"}`
         end
    },
}

------------------ Retornos ------------------
return CommandsModel
----------------------------------------------