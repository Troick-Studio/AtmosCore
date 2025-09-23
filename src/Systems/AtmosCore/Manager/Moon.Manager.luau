------------------- Inicio -------------------
local MoonManager = {}
------------------- Requires -----------------
local MoonConfigs = require(script.Parent.Parent.Domains.Moon["Moon.Configs"])
------------------ Variáveis -----------------

------------------- Funções ------------------

MoonManager.Phase = function() return MoonConfigs.GetMoonPhase() end

------------------ Retornos ------------------
return MoonManager
----------------------------------------------