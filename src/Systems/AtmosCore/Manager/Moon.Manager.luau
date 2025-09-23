------------------- Inicio -------------------
local MoonManager = {}
------------------- Requires -----------------
local MoonController = require(script.Parent.Parent.Domains.Moon["Moon.Controller"])
------------------ Variáveis -----------------

------------------- Funções ------------------

MoonManager.Phase = function()
    return MoonController.MoonPhase()
end

------------------ Retornos ------------------
return MoonManager
----------------------------------------------