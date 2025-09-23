local AtmosCore = require(game:GetService("ReplicatedStorage").Systems.AtmosCore.Main)
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local GraphicsUI = PlayerGui:WaitForChild("GraphicsUI")

AtmosCore.Init()
  
AtmosCore.OnTimeChanged:Connect(function(Time)
    local hours = math.floor(Time / 60)
    local minutes = Time % 60

    local timeString = string.format("%02d:%02d", hours, minutes)

    GraphicsUI.Clock.Time.Text = timeString
end)