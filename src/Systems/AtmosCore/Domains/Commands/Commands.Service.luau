------------------- Inicio -------------------
local CommandsService = {}
------------------- Requires -----------------
local TextChatService = game:GetService("TextChatService")
local EventsManager = require(script.Parent.Parent.Parent.Manager["Events.Manager"])
local GlobalConfigs = require(script.Parent.Parent.Parent["Global.Configs"])
local CommandsModel = require(script.Parent["Commands.Model"])
------------------ Variáveis -----------------

------------------- Funções ------------------

CommandsService.Init = function()
    for _, command in pairs(CommandsModel.Commands) do
        CreateCommandsChat(command.Name, command.PrimaryAlias)
    end

    EventsManager.OnServer("Command", function(Player, Input, Type)
        local Command = CommandsModel.Commands[Type]
        local Args = string.split(Input, " ") 
        local Arg = Args[Command.Arg]
        local AdminPermission = false
        local ServerMessage = ""

        for _, admin in ipairs(GlobalConfigs.Admins) do
            if Player.Name == admin then
                AdminPermission = true
            end
        end
    
        if AdminPermission then 
            if Command.PreSettings and Command.PreSettings[Arg:lower()] then
                print(Arg:lower())
                local Value = Command.PreSettings[Arg:lower()]
                EventsManager.FireClient(Player, "ExecuteCommand", {Type, Value})
                ServerMessage = Command.Message(Value)
            else
                local Value = Arg
                EventsManager.FireClient(Player, "ExecuteCommand", {Type, Value})
                ServerMessage = Command.Message(Value)
            end
        end

        return AdminPermission, ServerMessage
    end)
end

function CreateCommandsChat(name, primaryAlias)
    local CommandChat = Instance.new("TextChatCommand")
    CommandChat.Name = name
    CommandChat.PrimaryAlias = primaryAlias
    CommandChat.Parent = TextChatService
end

------------------ Retornos ------------------
return CommandsService
----------------------------------------------