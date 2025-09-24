------------------- Inicio -------------------
local TemperatureModel = {}
------------------- Requires -----------------

------------------ Variáveis -----------------

TemperatureModel.OnTemperatureChanged = Instance.new("BindableEvent") 

TemperatureModel.BaseTemperature = 10
TemperatureModel.Temperature = 0
TemperatureModel.DailyAmplitude = 5

TemperatureModel.LastData = {
	CurrentTemperature = 0,
	Weather = nil,
	Season = "Spring",
	Time = 9,
}


TemperatureModel.Clouds = {
    {TemperatureModifiers = 1},
    {TemperatureModifiers = 0.6},
    {TemperatureModifiers = 0.2},
    {TemperatureModifiers = -0.4},
    {TemperatureModifiers = -1},    
}

TemperatureModel.Weather = {
    Rain = {TemperatureModifiers = {Min = -1, Max = -5}},
	Storm = {TemperatureModifiers = {Min = -6, Max = -10}},
	Snow = {TemperatureModifiers = {Min = -15, Max = -18}},
	Wind = {TemperatureModifiers = {Min = -1, Max = -5}},
}

TemperatureModel.Season = {
    Spring = {TemperatureModifiers = 5},
    Summer = {TemperatureModifiers = 10},
    Autumn = {TemperatureModifiers = 5},
    Winter = {TemperatureModifiers = -8},
}

------------------ Retornos ------------------
return TemperatureModel
----------------------------------------------