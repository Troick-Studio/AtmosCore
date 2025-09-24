------------------- Inicio -------------------
local CommandsController = {}
------------------- Requires -----------------
local TextChatService = game:GetService("TextChatService")
local EventsManager = require(script.Parent.Parent.Parent.Manager["Events.Manager"])
local CommandsModel = require(script.Parent["Commands.Model"])
------------------ Variáveis -----------------

------------------- Funções ------------------

CommandsController.Init = function()
    for _, command in pairs(CommandsModel.Commands) do
        TextChatService:FindFirstChild(command.Name).Triggered:Connect(function(textSource, input)
            local perm, ServerMessage = EventsManager.InvokeServer("Command", input, command.Type)
            local chatMessage = ""

            if perm then chatMessage = ServerMessage
            else chatMessage = '<font color="#ff2f40"><b>Você não tem permissão para executar esse comando!</b></font>' end

            TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(chatMessage)
        end)
    end
end

------------------ Retornos ------------------
return CommandsController
----------------------------------------------