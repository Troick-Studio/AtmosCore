------------------- Inicio -------------------
local RandomUtil = {}
------------------- Requires -----------------

------------------ Variáveis -----------------

------------------- Funções ------------------

function RandomUtil.Generate()
	local seedGenerated = math.random(10000, 99999999)
	return seedGenerated
end

function RandomUtil.GetRNG(Seed, key, secret)
	local Key = key or 0
	local Secret = secret or ""
	return Random.new(tonumber(Seed + Key .. Secret))
end

RandomUtil.Lerp = {
	Number = function(a, b, t) return a + (b - a) * t end,
	Color = function(c1, c2, t) return c1:Lerp(c2, t) end,
}

------------------ Retornos ------------------
return RandomUtil
----------------------------------------------