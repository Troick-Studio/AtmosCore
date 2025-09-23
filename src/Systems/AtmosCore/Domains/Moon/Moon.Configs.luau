------------------- Inicio -------------------
local MoonConfigs = {}
------------------- Requires -----------------
local Utils = require(script.Parent.Parent.Parent.Utils.Util)
local CalendarModel = require(script.Parent.Parent.Parent.Domains.Calendar["Calendar.Model"])
------------------ Variáveis -----------------

-- Reutilização de codigo antigo*

MoonConfigs.Moon = {
	{Phase = "New Moon", Texture = "rbxassetid://75226596184616", DurationDays = 7},
	{Phase = "Waxing Crescent", Texture = "rbxassetid://9028103439", DurationDays = 7},
	{Phase = "First Quarter", Texture = "rbxassetid://9014138816", DurationDays = 7},
	{Phase = "Waxing Gibbous", Texture = "rbxassetid://9028249353", DurationDays = 7},
	{Phase = "Full Moon", Texture = "rbxassetid://9013498676", DurationDays = 7},
	{Phase = "Waning Gibbous", Texture = "rbxassetid://9028202073", DurationDays = 7},
	{Phase = "Last Quarter", Texture = "rbxassetid://9014238161", DurationDays = 7},
	{Phase = "Waning Crescent", Texture = "rbxassetid://9027816797", DurationDays = 7}
}

MoonConfigs.GetMoonPhase = function()
	local TotalPhases = #MoonConfigs.Moon
	local MoonRNG = Utils.Random.GetRNG(8, 48)
	local InitialPhaseIndex = MoonRNG:NextInteger(1, TotalPhases)
	local PhaseOffset = 0
		
	for i = 1, InitialPhaseIndex - 1 do
		PhaseOffset = PhaseOffset + MoonConfigs.Moon[i].DurationDays
	end
	
	local CycleLength = 0
	for _, Phase in ipairs(MoonConfigs.Moon) do
		CycleLength = CycleLength + Phase.DurationDays
	end

	local DayInCycle = ((CalendarModel.Date.Day + PhaseOffset) % CycleLength)
	if DayInCycle == 0 then
		DayInCycle = CycleLength
	end

	local AccumulatedDays = 0
	local CurrentPhase

	for _, Phase in ipairs(MoonConfigs.Moon) do
		AccumulatedDays = AccumulatedDays + Phase.DurationDays
		if DayInCycle <= AccumulatedDays then
			CurrentPhase = Phase
			break
		end
	end

	return CurrentPhase
end

------------------ Retornos ------------------
return MoonConfigs
----------------------------------------------