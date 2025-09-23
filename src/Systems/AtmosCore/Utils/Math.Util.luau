------------------- Inicio -------------------
local MathUtils = {}
------------------ Requires ------------------

------------------ Variáveis -----------------

------------------- Funções ------------------

MathUtils.Lerp = {
	Number = function(a, b, t) return a + (b - a) * t end,
	Color = function(c1, c2, t) return c1:Lerp(c2, t) end,
}

------------------ Retornos ------------------
return MathUtils
----------------------------------------------
