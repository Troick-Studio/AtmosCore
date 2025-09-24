local AtmosCore = require(game:GetService("ReplicatedStorage").Systems.AtmosCore.Main)
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local ExampleUI = PlayerGui:WaitForChild("ExampleUI")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

AtmosCore.Init()
  
local function LampPostT(LampPost, Active)
    if Active then
        TweenService:Create(LampPost.LightSource.PointLight, TweenInfo.new(1), {Brightness = 1}):Play()
        LampPost.Bulb.Color = Color3.fromRGB(255, 255, 204)
        LampPost.Glass.Material = Enum.Material.Neon
        -- LampPost.LightSource.PointLight.Enabled = true
    else
        TweenService:Create(LampPost.LightSource.PointLight, TweenInfo.new(1), {Brightness = 0}):Play()
        LampPost.Bulb.Color = Color3.fromRGB(17, 17, 17)
        LampPost.Glass.Material = Enum.Material.SmoothPlastic
        -- LampPost.LightSource.PointLight.Enabled = false
    end
end

AtmosCore.OnNight:Connect(function()
    for _, LampPost in pairs(CollectionService:GetTagged("LampPost")) do
        LampPostT(LampPost, true)
    end
end)

AtmosCore.OnSunrise:Connect(function()
    for _, LampPost in pairs(CollectionService:GetTagged("LampPost")) do
        LampPostT(LampPost, false)
    end
end)

AtmosCore.OnTimeChanged:Connect(function(Time)
    local hours = math.floor(Time / 60)
    local minutes = Time % 60

    local timeString = string.format("%02d:%02d", hours, minutes)
    ExampleUI.Clock.Time.Text = timeString
end)

AtmosCore.OnTemperatureChanged:Connect(function(Temperature)
    if not Temperature then return end
    ExampleUI.Clock.Temperature.Text = `°{Temperature}`
end)