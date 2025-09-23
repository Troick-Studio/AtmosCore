local AtmosCore = require(game:GetService("ReplicatedStorage").Systems.AtmosCore.Main)

AtmosCore.Init({
    Year = 2023, Month = 1, Day = 1, Time = 12
}).Features({
	MoonPhase = false,
	DayAndNightCycle = true
}).Settings({
    LengthOfDayInMinutes = 30
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