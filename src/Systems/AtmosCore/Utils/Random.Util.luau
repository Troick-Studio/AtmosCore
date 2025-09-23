------------------- Inicio -------------------
local RandomUtil = {}
------------------- Requires -----------------
local GlobalConfigs = require(script.Parent.Parent["Global.Configs"])
------------------ Variáveis -----------------

------------------- Funções ------------------

RandomUtil.Generate = function()
	local seedGenerated = math.random(10000, 99999999)
	return seedGenerated
end

RandomUtil.GetRNG = function(key, secret)
	local Key = key or 0
	local Secret = secret or ""
	return Random.new(tonumber(GlobalConfigs.Seed + Key .. Secret))
end

------------------ Retornos ------------------
return RandomUtil
----------------------------------------------