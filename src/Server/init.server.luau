local AtmosCore = require(game:GetService("ReplicatedStorage").Systems.AtmosCore.Main)

AtmosCore.Init()

AtmosCore.OnNight:Connect(function()
    print("Anoiteceu")
end)
AtmosCore.OnSunrise:Connect(function()
    print("Amanheceu")
end)
AtmosCore.OnDay:Connect(function()
    print("Passou um dia")
end)

AtmosCore.OnMonth:Connect(function(Month)
    print("Mes:", Month.Name)
end)