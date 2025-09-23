------------------- Inicio -------------------
local LoopManager = {}
------------------- Requires -----------------

------------------ Variáveis -----------------
local Loops = {}
local Delta = 0.1
------------------- Funções ------------------

LoopManager.Add = function(callback : () -> (), waitTime : number?)
    waitTime = waitTime or 0 
     if typeof(callback) == "function" and type(waitTime) == "number" then
        table.insert(Loops, {Callback = callback, WaitTime = waitTime, Elapsed = 0})
    end
end

LoopManager.Init = function()
    spawn(function()
        while true do
            for _, LoopData in ipairs(Loops) do
                LoopData.Elapsed = LoopData.Elapsed + Delta
                if LoopData.Elapsed >= LoopData.WaitTime then
                    LoopData.Callback()
                    LoopData.Elapsed = 0
                end
            end
            task.wait(Delta)
        end
    end)
end

------------------ Retornos ------------------
return LoopManager
----------------------------------------------