local AtmosCore = require(game:GetService("ReplicatedStorage").Systems.AtmosCore.Main)

AtmosCore.Init({
    Year = 2023, Month = 1, Day = 25, Time = 9
}).Features({
	MoonPhase = false,
	DayAndNightCycle = true
}).Settings({
    LengthOfDayInMinutes = 1,
    Seed = 1640
})

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