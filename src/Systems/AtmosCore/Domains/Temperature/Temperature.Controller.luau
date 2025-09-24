------------------- Inicio -------------------
local TemperatureController = {}
------------------- Requires -----------------
local TemperatureModel = require(script.Parent["Temperature.Model"])
local CycleModel = require(script.Parent.Parent.Cycle["Cycle.Model"])
local CalendarModel = require(script.Parent.Parent.Calendar["Calendar.Model"])
local LoopManager = require(script.Parent.Parent.Parent.Manager["Loop.Manager"])
------------------ Variáveis -----------------

------------------- Funções ------------------

TemperatureController.GetTemperature = function()
	local Time = CycleModel.Clock.Time()
	local Season = CalendarModel.Date.Season
	local Weather = TemperatureModel.Weather
	
	local Base = TemperatureModel.BaseTemperature
	local Daily = GetDailyVariation(Time)
    local SeasonMod = TemperatureModel.Season[Season.Name].TemperatureModifiers
	local WeatherMod = 0
	local EnvMod = 0

	local FinalTemp = tonumber(string.format("%.1f", Base + Daily + WeatherMod + EnvMod + SeasonMod))
	
	TemperatureModel.Temperature = FinalTemp

    if FinalTemp ~= TemperatureModel.LastData.Temperature then
        TemperatureModel.OnTemperatureChanged:fire(FinalTemp)
    end

    TemperatureModel.LastData.Temperature = FinalTemp
	TemperatureModel.LastData.Season = Season
	TemperatureModel.LastData.Time = Time

	return FinalTemp
end

TemperatureController.Start = function()
    LoopManager.Add(function()
        TemperatureController.GetTemperature()
    end)
end

function GetDailyVariation(Time)
	local Amplitude = TemperatureModel.DailyAmplitude or 5
	return math.sin((Time / 24) * math.pi * 2 - math.pi/2) * Amplitude / 2
end

------------------ Retornos ------------------
return TemperatureController
----------------------------------------------