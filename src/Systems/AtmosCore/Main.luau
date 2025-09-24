------------------ Inicio ------------------
local Main = {}
Main.Command = {}
------------------ Requires ----------------
local CycleManager = require(script.Parent.Manager["Cycle.Manager"])
local CalendarManager = require(script.Parent.Manager["Calendar.Manager"])
local LoopManager = require(script.Parent.Manager["Loop.Manager"])
local RemoteManager = require(script.Parent.Manager["Remote.Manager"])
local EventsManager = require(script.Parent.Manager["Events.Manager"])
local CommandsManager = require(script.Parent.Manager["Commands.Manager"])
local CalendarModel = require(script.Parent.Domains.Calendar["Calendar.Model"])
local VisualsModel = require(script.Parent.Domains.Visuals["Visuals.Model"])
local CycleModel = require(script.Parent.Domains.Cycle["Cycle.Model"])
local CloudsManager = require(script.Parent.Manager["Clouds.Manager"])
local TemperatureManager = require(script.Parent.Manager["Temperature.Manager"])
local Utils = require(script.Parent.Utils.Util)
local RunService = game:GetService("RunService")
local GlobalConfigs = require(script.Parent["Global.Configs"])
------------------ Variáveis ----------------
local PreSettings = {
        LengthOfDayInMinutes = 30,
        Seed = Utils.Random.Generate(),
        InitYear = 2020
    }
local PreData = {Day = 1, Month = 1, Year = 1, Time = 9}
local Settings
------------------ Funções ------------------

type InitData = {Year : number?, Month : number?, Day : number?, Time : number?}
type FeaturesData = {MoonPhase : boolean?, DayAndNightCycle : boolean?, WeatherCycle : boolean?, DynamicClouds : boolean?, BetterVisuals : boolean?}
type SettingsData = {LengthOfDayInMinutes : number?, Seed : number?, InitYear : number?}
--[[
    Inicia o AtmosCore

    Client-Side - se auto-configura, não necessita de parametros

    Server-Side - recebe os seguintes parametros:
    @param Init() recebe data {Year = 1>>Infinitamente, Month = 1->12, Day = 1->31, Time = 0->24}
    @param Features() recebe quais Features estará habilitadas ou desabilitadas
    @param Settings() recebe um objeto que contém {Seed = sequência de numeros, InitYear = recebe um numero que sera adicionado ao Year para retornar algo como 2020 + Year, LengthOfDayInMinutes = duração em minutos do ciclo de dia e noite}
]]
Main.Init = function(data : InitData?)
    VerifyAtmosphere()
    local Data = PreData
    if data then for name, value in pairs(data) do Data[name] = value end end

    RemoteManager.Init()
    CycleManager.Init(Data)
    LoopManager.Init()
    CalendarManager.Init(Data)
    CommandsManager.Init()
    TemperatureManager.Init()
    
    if RunService:IsClient() then
        CloudsManager.Init()
    end
    if RunService:IsServer() then
        local Funcs = {}

        Funcs.Features = function(featuresSettings : FeaturesData?)
            if not featuresSettings then return end
            for name, value in pairs(featuresSettings) do 
                if name == "BetterVisuals" then
                    VisualsModel.Enabled = value
                    PreSettings.BetterVisuals = value
                elseif name == "DayAndNightCycle" then
                    CycleModel.Enabled = value
                    PreSettings.DayAndNightCycle = value
                end
            end
            return Funcs
        end

        Funcs.Settings = function(settings : SettingsData?)
            Settings = PreSettings
            if settings then
                for name, value in pairs(settings) do
                    Settings[name] = value
                    if name == "Seed" then
                        GlobalConfigs.Seed = value
                    elseif name == "InitYear" then
                        CalendarModel.Date.Year += value
                    elseif name == "LengthOfDayInMinutes" then
                        CycleModel.Duration.LengthOfDayInMinutes = value <= 0.1 and 1 or value
                        CycleModel.CycleVariables.Speed = 1440 / (value * 60)
                    end
                end
            end
            return Funcs
        end

        Funcs.Admins = function(admins : {any}?)
            if admins then
                for _, name in ipairs(admins) do
                    table.insert(GlobalConfigs.Admins, name)
                end
            end
            Settings.Admins = GlobalConfigs.Admins
            return Funcs
        end

        return Funcs
    end

    return nil
end

type Commands = "Set" | "Stop" | "Start" | "ReSync" | "Toggle" | "Get"
--[[
    Executa comandos especificos
]]
Main.Command.Time = function(Command : Commands, CommandValue : number | {Player : Player, Data : any}?) return CycleManager.Command(Command, CommandValue) end

--[[
    Sincroniza os dados do Servidor com o Cliente
]]
Main.Sync = function(Player) CycleManager.Sync(Player) end

function VerifyAtmosphere()
    if not game.Lighting:FindFirstChild("Atmosphere") then Instance.new("Atmosphere", game.Lighting) end
    if not game.Lighting:FindFirstChild("SunRays") then Instance.new("SunRaysEffect", game.Lighting).Name = "SunRays" end
    if not game.Lighting:FindFirstChild("ColorCorrection") then Instance.new("ColorCorrectionEffect", game.Lighting).Name = "ColorCorrection" end
    if not game.Lighting:FindFirstChild("ExtraConditionsCorrection") then Instance.new("ColorCorrectionEffect", game.Lighting).Name = "ExtraConditionsCorrection" end
    if not game.Lighting:FindFirstChild("TemperatureCorrection") then Instance.new("ColorCorrectionEffect", game.Lighting).Name = "TemperatureCorrection" end
end

------------------- Eventos ------------------

game.Players.PlayerAdded:Connect(function(Player)
    CycleModel.Commands.ReSync(Player)
    EventsManager.FireAllClients("SyncDate", CalendarModel.Date)
    EventsManager.FireClient(Player, "SyncSettings", Settings)
end)

--[[
    OnNight - Executa cada vez que anoitece
]]
Main.OnNight = CycleManager.Bindable.OnNight

--[[
    OnSunrise - Executa cada vez que amanhece
]]
Main.OnSunrise = CycleManager.Bindable.OnSunrise

--[[
    OnDay - Executa cada vez que o dia passa
    @return Dia
]]
Main.OnDay = CalendarManager.Bindable.OnDay

--[[
    OnMonth - Executa cada vez que o mês passa
    @return - Objeto com o numero do mês e o nome do mês
]]
Main.OnMonth = CalendarManager.Bindable.OnMonth

--[[
    OnYear - Executa cada vez que o ano passa
    @return - Ano
]]
Main.OnYear = CalendarManager.Bindable.OnYear

--[[
    OnSeason - Executa cada vez que a estação do ano muda
    @return - Objeto com os dados da estação do ano
]]
Main.OnSeason = CalendarManager.Bindable.OnSeason

--[[
    OnTimeChanged - Executa cada vez que o horário é atualizado
    @return - Horário
]]
Main.OnTimeChanged = CycleManager.Bindable.OnTimeChanged

--[[
    OnTemperatureChanged - Executa cada vez que a temperatura é atualizada
    @return - Temperatura
]]
Main.OnTemperatureChanged = TemperatureManager.Bindable.OnTemperatureChanged

------------------ Retornos ------------------
return Main
----------------------------------------------
