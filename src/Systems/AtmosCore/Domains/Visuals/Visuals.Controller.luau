------------------- Inicio -------------------
local VisualsController = {}
------------------- Requires -----------------
-- local LoopManager = require(script.Parent.Parent.Parent.Manager["Loop.Manager"])
local VisualsConfigs = require(script.Parent["Visuals.Configs"])
local VisualsModel = require(script.Parent["Visuals.Modal"])
local Utils = require(script.Parent.Parent.Parent.Utils.Util) 
------------------ Variáveis -----------------
Lighting = game:GetService("Lighting")
local Graphics = VisualsConfigs.Graphics.Realistic
------------------- Funções ------------------

-- Reutilização de codigo antigo*

VisualsController.Start = function(time)
    if VisualsModel.Enabled then
        local States = GetDayState(time/60)
        local startMinutes = States.Current.Time.Initial * 60
        local endMinutes = States.Current.Time.Final * 60
        local t = math.clamp((time - startMinutes) / (endMinutes - startMinutes), 0, 1)
        if States.CurrentName == "Night" then
            if time >= 0 then
                t = 1
            end
        end

        Lighting.Brightness = Utils.Math.Lerp.Number(States.Preview.Lighting.Brightness, States.Current.Lighting.Brightness, t)
        Lighting.ColorShift_Top = Utils.Math.Lerp.Color(States.Preview.Lighting.ColorShift_Top, States.Current.Lighting.ColorShift_Top, t)
        Lighting.OutdoorAmbient = Utils.Math.Lerp.Color(States.Preview.Lighting.OutdoorAmbient, States.Current.Lighting.OutdoorAmbient, t)
        Lighting.EnvironmentSpecularScale = Utils.Math.Lerp.Number(States.Preview.Lighting.EnvironmentSpecularScale, States.Current.Lighting.EnvironmentSpecularScale, t)
        Lighting.Atmosphere.Density = Utils.Math.Lerp.Number(States.Preview.Lighting.Atmosphere.Density, States.Current.Lighting.Atmosphere.Density, t)
        Lighting.Atmosphere.Offset = Utils.Math.Lerp.Number(States.Preview.Lighting.Atmosphere.Offset, States.Current.Lighting.Atmosphere.Offset, t)
        Lighting.Atmosphere.Color = Utils.Math.Lerp.Color(States.Preview.Lighting.Atmosphere.Color, States.Current.Lighting.Atmosphere.Color, t)
        Lighting.Atmosphere.Decay = Utils.Math.Lerp.Color(States.Preview.Lighting.Atmosphere.Decay, States.Current.Lighting.Atmosphere.Decay, t)
        Lighting.Atmosphere.Glare = Utils.Math.Lerp.Number(States.Preview.Lighting.Atmosphere.Glare, States.Current.Lighting.Atmosphere.Glare, t)
        Lighting.Atmosphere.Haze = Utils.Math.Lerp.Number(States.Preview.Lighting.Atmosphere.Haze, States.Current.Lighting.Atmosphere.Haze, t)
        Lighting.SunRays.Intensity = Utils.Math.Lerp.Number(States.Preview.Lighting.SunRays.Intensity, States.Current.Lighting.SunRays.Intensity, t)
        Lighting.SunRays.Spread = Utils.Math.Lerp.Number(States.Preview.Lighting.SunRays.Spread, States.Current.Lighting.SunRays.Spread, t)
    else
        Lighting.Brightness = VisualsConfigs.Graphics.Default.Lighting.Brightness
        Lighting.ColorShift_Top = VisualsConfigs.Graphics.Default.Lighting.ColorShift_Top
        Lighting.OutdoorAmbient = VisualsConfigs.Graphics.Default.Lighting.OutdoorAmbient
        Lighting.EnvironmentSpecularScale = VisualsConfigs.Graphics.Default.Lighting.EnvironmentSpecularScale
        Lighting.Atmosphere.Density = VisualsConfigs.Graphics.Default.Lighting.Atmosphere.Density
        Lighting.Atmosphere.Offset = VisualsConfigs.Graphics.Default.Lighting.Atmosphere.Offset
        Lighting.Atmosphere.Color = VisualsConfigs.Graphics.Default.Lighting.Atmosphere.Color
        Lighting.Atmosphere.Decay = VisualsConfigs.Graphics.Default.Lighting.Atmosphere.Decay
        Lighting.Atmosphere.Glare = VisualsConfigs.Graphics.Default.Lighting.Atmosphere.Glare
        Lighting.Atmosphere.Haze = VisualsConfigs.Graphics.Default.Lighting.Atmosphere.Haze
        Lighting.SunRays.Intensity = VisualsConfigs.Graphics.Default.Lighting.SunRays.Intensity
        Lighting.SunRays.Spread = VisualsConfigs.Graphics.Default.Lighting.SunRays.Spread
    end
end

function GetDayState(hourNow: number)
    for i, period in pairs(VisualsConfigs.Cycle) do
        local startHour = period.Time.Initial
		local endHour = period.Time.Final
        local untilHour = period.Time.Until
        local untilN = 0

        if typeof(untilHour) == "table" then
            untilN = untilHour[2]
            untilHour = untilHour[1]
        end
        
        if startHour < endHour then
            if (hourNow >= startHour and hourNow < endHour) or (hourNow <= untilHour and hourNow >= endHour) or (hourNow <= untilN and hourNow >= 0) then
                local preview = period.Preview
                local next = period.Next
                return {Preview = Graphics[preview], Current = Graphics[period.Name], Next = Graphics[next], CurrentName = period.Name}
            end
        end

    end

	return nil
end

------------------ Retornos ------------------
return VisualsController
----------------------------------------------