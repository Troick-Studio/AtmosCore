------------------- Inicio -------------------
local MoonController = {}
------------------- Requires -----------------
local MoonConfigs = require(script.Parent["Moon.Configs"])
local Utils = require(script.Parent.Parent.Parent.Utils.Util)
local CalendarModel = require(script.Parent.Parent.Parent.Domains.Calendar["Calendar.Model"])
------------------ Variáveis -----------------

------------------- Funções ------------------

function MoonController.MoonPhase()
	
	local totalPhases = #MoonConfigs.Moon
	local moonRNG = Utils.Random.GetRNG(8, 48)
	local initialPhaseIndex = moonRNG:NextInteger(1, totalPhases)
	local phaseOffset = 0
		
	for i = 1, initialPhaseIndex - 1 do
		phaseOffset = phaseOffset + MoonConfigs.Moon[i].DurationDays
	end
	
	local cycleLength = 0
	for _, phase in ipairs(MoonConfigs.Moon) do
		cycleLength = cycleLength + phase.DurationDays
	end

	local dayInCycle = ((CalendarModel.Date.Day + phaseOffset) % cycleLength)
	if dayInCycle == 0 then
		dayInCycle = cycleLength
	end

	local accumulatedDays = 0
	local currentPhase

	for _, phase in ipairs(MoonConfigs.Moon) do
		accumulatedDays = accumulatedDays + phase.DurationDays
		if dayInCycle <= accumulatedDays then
			currentPhase = phase
			break
		end
	end

	return currentPhase
end

------------------ Retornos ------------------
return MoonController
----------------------------------------------