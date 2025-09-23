------------------- Inicio -------------------
local EventsManager = {}
------------------- Requires -----------------

------------------ Variáveis -----------------
local RemoteFile = script.Parent.Parent.Remotes
------------------- Funções ------------------

--[[
    Cria RemoteEvent ou RemoteFunction com base no nome recebido e tipo
]]
EventsManager.CreateEvents = function(Data : {Name : string, Type : "RemoteFunction" | "RemoteEvent"})
    local NewRemote = RemoteFile:FindFirstChild(Data.Name)
    if not NewRemote then
        NewRemote = Instance.new(Data.Type)
        NewRemote.Name = Data.Name
        NewRemote.Parent = RemoteFile
    end
    return NewRemote
end

--[[
    Registra o callback recebido no Server (RemoteEvent)
]]
EventsManager.OnServer = function(Name : string, Callback : (any) -> ())
    local Remote = RemoteFile:FindFirstChild(Name)
    if Remote then
        if Remote:IsA("RemoteEvent") then
            Remote.OnServerEvent:Connect(function(Player, ...)
                Callback(Player, ...)
            end)
        elseif Remote:IsA("RemoteFunction") then
            Remote.OnServerInvoke = function(Player, ...)
                return Callback(Player, ...)
            end
        end
    end
end

--[[
    Registra o callback recebido no Client (RemoteEvent)
]]
EventsManager.OnClient = function(Name : string, Callback : (any) -> ())
    local Remote = RemoteFile:WaitForChild(Name)
    if Remote then
        if Remote:IsA("RemoteEvent") then
            Remote.OnClientEvent:Connect(function(...)
                Callback(...)
            end)
        elseif Remote:IsA("RemoteFunction") then
            Remote.OnClientInvoke = function(...)
                return Callback(...)
            end
        end
    end
end

--[[
    Dispara para um Client específico o callback registrado na quele Remote Event (RemoteEvent)
]]
EventsManager.FireClient = function(Player : Player, Name : string, ... : any)
    local Remote = RemoteFile:FindFirstChild(Name)
    if Remote and Remote:IsA("RemoteEvent") then
        Remote:FireClient(Player, ...)
    end
end

--[[
    Dispara para todos os Clients o callback registrado na quele Remote Event (RemoteEvent)
]]
EventsManager.FireAllClients = function(Name : string, ... : any)
    local Remote = RemoteFile:FindFirstChild(Name)
    if Remote and Remote:IsA("RemoteEvent") then
        Remote:FireAllClients(...)
    end
end

--[[
    Dispara do Client para o Server, executando o callback registrado na quele Remote Event (RemoteEvent)
]]
EventsManager.FireServer = function(Name : string, ... : any)
    local Remote = RemoteFile:FindFirstChild(Name)
    if Remote and Remote:IsA("RemoteEvent") then
        Remote:FireServer(...)
    end
end


--[[
    Invoca RemoteFunction no Server a partir do Client (RemoteFunction)
]]
EventsManager.InvokeServer = function(Name : string, ... : any)
    local Remote = RemoteFile:FindFirstChild(Name)
    if Remote and Remote:IsA("RemoteFunction") then
        return Remote:InvokeServer(...)
    end
    return nil
end

--[[
    Invoca RemoteFunction no Client a partir do Server (RemoteFunction)
]]
EventsManager.InvokeClient = function(Player : Player, Name : string, ... : any)
    local Remote = RemoteFile:FindFirstChild(Name)
    if Remote and Remote:IsA("RemoteFunction") then
        return Remote:InvokeClient(Player, ...)
    end
    return nil
end

------------------ Retornos ------------------
return EventsManager
----------------------------------------------
