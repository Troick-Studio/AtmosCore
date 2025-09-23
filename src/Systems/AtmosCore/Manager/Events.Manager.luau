------------------- Inicio -------------------
local EventsManager = {}
------------------- Requires -----------------

------------------ Variáveis -----------------
local RemoteFile = script.Parent.Parent.Remotes
------------------- Funções ------------------

-- Cria RemoteEvent ou RemoteFunction
EventsManager.CreateEvents = function(Data)
    local NewRemote = RemoteFile:FindFirstChild(Data.Name)
    if not NewRemote then
        NewRemote = Instance.new(Data.Type)
        NewRemote.Name = Data.Name
        NewRemote.Parent = RemoteFile
    end
    return NewRemote
end

-- Registra callback no Server (RemoteEvent)
EventsManager.OnServer = function(Name, Callback)
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

-- Registra callback no Client (RemoteEvent)
EventsManager.OnClient = function(Name, Callback)
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

-- Dispara para um Client específico (RemoteEvent)
EventsManager.FireClient = function(Player, Name, ...)
    local Remote = RemoteFile:FindFirstChild(Name)
    if Remote and Remote:IsA("RemoteEvent") then
        Remote:FireClient(Player, ...)
    end
end

-- Dispara para todos os Clients (RemoteEvent)
EventsManager.FireAllClients = function(Name, ...)
    local Remote = RemoteFile:FindFirstChild(Name)
    if Remote and Remote:IsA("RemoteEvent") then
        Remote:FireAllClients(...)
    end
end

-- Dispara do Client para o Server (RemoteEvent)
EventsManager.FireServer = function(Name, ...)
    local Remote = RemoteFile:FindFirstChild(Name)
    if Remote and Remote:IsA("RemoteEvent") then
        Remote:FireServer(...)
    end
end

-- Invoca RemoteFunction no Server a partir do Client
EventsManager.InvokeServer = function(Name, ...)
    local Remote = RemoteFile:FindFirstChild(Name)
    if Remote and Remote:IsA("RemoteFunction") then
        return Remote:InvokeServer(...)
    end
    return nil
end

-- Invoca RemoteFunction no Client a partir do Server
EventsManager.InvokeClient = function(Player, Name, ...)
    local Remote = RemoteFile:FindFirstChild(Name)
    if Remote and Remote:IsA("RemoteFunction") then
        return Remote:InvokeClient(Player, ...)
    end
    return nil
end

------------------ Retornos ------------------
return EventsManager
----------------------------------------------
