------------------- Inicio -------------------
local CloudsController = {}
------------------- Requires -----------------
local Clouds = nil
local Utils = require(script.Parent.Parent.Parent.Utils.Util)
local LoopManager = require(script.Parent.Parent.Parent.Manager["Loop.Manager"])
local CloudsModel = require(script.Parent["Clouds.Model"])
local CalendarModel = require(script.Parent.Parent.Calendar["Calendar.Model"])
local CycleModel = require(script.Parent.Parent.Cycle["Cycle.Model"])
------------------ Variáveis -----------------
local StartTime = 0
local DynamicStart = false
local RNG
local Delay
local cloudDensity
local Duration
local Secret = 1053
------------------- Funções ------------------

CloudsController.Start = function()
	local Density = CloudsModel.Density
	Clouds = game.Workspace.Terrain:WaitForChild("Clouds")
    if Density <= 1 then
        CloudDensity(CloudsModel.OldDensity, CloudsModel.Clouds[1], Density)
    elseif Density > 1 and Density <= 2 then
        CloudsModel.OldDensity = CloudsModel.Clouds[1]
        CloudDensity(CloudsModel.OldDensity, CloudsModel.Clouds[2], Density - 1)
    elseif Density > 2 and Density <= 3 then
        CloudsModel.OldDensity = CloudsModel.Clouds[2]
        CloudDensity(CloudsModel.OldDensity, CloudsModel.Clouds[3], Density - 2)
    elseif Density > 3 and Density <= 4 then
        CloudsModel.OldDensity = CloudsModel.Clouds[3]
        CloudDensity(CloudsModel.OldDensity, CloudsModel.Clouds[4], Density - 3)
    elseif Density > 4 and Density <= 5 then
        CloudsModel.OldDensity = CloudsModel.Clouds[4]
        CloudDensity(CloudsModel.OldDensity, CloudsModel.Clouds[5], Density - 4)
    end
end

CloudsController.Dynamic = function()
    local startDensity = 0
    local oldCloudDensity = 0

    LoopManager.Add(function()
        if not DynamicStart then
            StartTime = CycleModel.Clock.MinutesAfterMidnight
            RNG = Utils.Random.GetRNG(CalendarModel.Date.Day, Secret)

            Delay = RNG:NextNumber(1.5*60, 4.5*60)
            cloudDensity = RNG:NextInteger(1, 3)
            Duration = RNG:NextNumber(0.5*60, 2.5*60)

            startDensity = oldCloudDensity  
            DynamicStart = true
        end
        
        local elapsed = CycleModel.Clock.MinutesAfterMidnight - StartTime
        if elapsed < 0 then elapsed = elapsed + 1440 end
                
        if elapsed < Duration then
            local progress = elapsed / Duration
            local dynamicDensity = startDensity + (cloudDensity - startDensity) * progress

            CloudsModel.Density = dynamicDensity
        elseif elapsed < Duration + Delay then
        elseif elapsed >= Duration + Delay then
            Secret += 1
            oldCloudDensity = cloudDensity
            DynamicStart = false
        end
    end)
end

function CloudDensity(OldCloudSettings, CloudSettings, Density)
    Clouds.Density = Utils.Math.Lerp.Number(OldCloudSettings.Density, CloudSettings.Density, Density)
    Clouds.Cover = Utils.Math.Lerp.Number(OldCloudSettings.Cover, CloudSettings.Cover, Density )
    Clouds.Color = Utils.Math.Lerp.Color(OldCloudSettings.Color, CloudSettings.Color, Density)
end

------------------ Retornos ------------------
return CloudsController
----------------------------------------------