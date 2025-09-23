------------------- Inicio -------------------
local VisualsConfigs = {}
------------------- Requires -----------------

------------------ Variáveis -----------------

VisualsConfigs.Graphics = {
    Realistic = {
        Dawn = {
            Time = {
                Initial = 6,
                Final = 6.5,
                Until = 6.5
            },
            Lighting = {
                Brightness = 4,
                ColorShift_Top = Color3.fromRGB(255, 160, 0),
                OutdoorAmbient = Color3.fromRGB(200, 140, 0),
                EnvironmentSpecularScale = 1,
                Atmosphere = {
                    Density = 0.3,
                    Offset = 0.25,
                    Color = Color3.fromRGB(245, 190, 132),
                    Decay = Color3.fromRGB(160, 75, 0),
                    Glare = 0.2,
                    Haze = 2.15
                },
                SunRays = {
                    Intensity = 0.13,
                    Spread = 0.24
                }
            },
            Preview = "Moonset"
        },
        Day = {
            Time = {
                Initial = 6.5,
                Final = 7,
                Until = 17
            },
            Lighting = {
                Brightness = 6,
                ColorShift_Top = Color3.fromRGB(0, 0, 0),
                OutdoorAmbient = Color3.fromRGB(100, 100, 100),
                EnvironmentSpecularScale = 1,
                Atmosphere = {
                    Density = 0.395,
                    Offset = 0,
                    Color = Color3.fromRGB(255, 255, 255),
                    Decay = Color3.fromRGB(255, 255, 255),
                    Glare = 0,
                    Haze = 0
                },
                SunRays = {
                    Intensity = 0.25,
                    Spread = 1
                }
            },
            Preview = "Dawn"
        },
        Sunset = {
            Time = {
                Initial = 17,
                Final = 18,
                Until = 18
            },
            Lighting = {
                Brightness = 4,
                ColorShift_Top = Color3.fromRGB(255, 160, 0),
                OutdoorAmbient = Color3.fromRGB(0, 0, 0),
                EnvironmentSpecularScale = 1,
                Atmosphere = {
                    Density = 0.3,
                    Offset = 0.25,
                    Color = Color3.fromRGB(245, 190, 132),
                    Decay = Color3.fromRGB(160, 75, 0),
                    Glare = 0.2,
                    Haze = 2.15
                },
                SunRays = {
                    Intensity = 0.13,
                    Spread = 0.24
                }
            },
            Preview = "Day"
        },
        Twilight = {
            Time = {
                Initial = 18,
                Final = 19.5,
                Until = 5,

            },
            Lighting = {
                Brightness = 0.9,
                ColorShift_Top = Color3.fromRGB(110, 155, 200),
                OutdoorAmbient = Color3.fromRGB(35, 40, 45),
                EnvironmentSpecularScale = 0,
                Atmosphere = {
                    Density = 0.485,
                    Offset = 0,
                    Color = Color3.fromRGB(0, 0, 0),
                    Decay = Color3.fromRGB(255, 255, 255),
                    Glare = 0,
                    Haze = 0
                },
                SunRays = {
                    Intensity = 0.25,
                    Spread = 1
                }
            },
            Preview = "Sunset"
        },
        Night = {
            Time = {
                Initial = 19.5,
                Final = 20.5,
                Until = 24,
            },
            Lighting = {
                Brightness = 0.8,
                ColorShift_Top = Color3.fromRGB(90, 139, 255),
                OutdoorAmbient = Color3.fromRGB(25, 31, 45),
                EnvironmentSpecularScale = 0,
                Atmosphere = {
                    Density = 0.485,
                    Offset = 0,
                    Color = Color3.fromRGB(0, 0, 0),
                    Decay = Color3.fromRGB(255, 255, 255),
                    Glare = 0,
                    Haze = 0
                },
                SunRays = {
                    Intensity = 0.25,
                    Spread = 1
                }
            },
            Preview = "Twilight"
        },
        Moonset = {
            Time = {
                Initial = 5,
                Final = 6,
                Until = 6
            },
            Lighting = {
                Brightness = 0.9,
                ColorShift_Top = Color3.fromRGB(0, 0, 0),
                OutdoorAmbient = Color3.fromRGB(0, 0, 0),
                EnvironmentSpecularScale = 0,
                Atmosphere = {
                    Density = 0.485,
                    Offset = 0,
                    Color = Color3.fromRGB(245, 190, 132),
                    Decay = Color3.fromRGB(160, 75, 0),
                    Glare = 0,
                    Haze = 0
                },
                SunRays = {
                    Intensity = 0.25,
                    Spread = 1
                }
            },
            Preview = "Night"
        }
    },
    Default = {
        Lighting = {
            Brightness = 2,
            ColorShift_Top = Color3.fromRGB(0, 0, 0),
            OutdoorAmbient = Color3.fromRGB(70, 70, 70),
            EnvironmentSpecularScale = 1,
            Atmosphere = {
                Density = 0.395,
                Offset = 0,
                Color = Color3.fromRGB(199, 170, 107),
                Decay = Color3.fromRGB(92, 60, 13),
                Glare = 0,
                Haze = 0
            },
            SunRays = {
                Intensity = 0.25,
                Spread = 1
            },
        },
    }
}

VisualsConfigs.Cycle = {
    {
        Name = "Dawn",
        Time = {
            Initial = 6,
            Final = 6.5,
            Until = 6.5
        },
        Preview = "Moonset",
        Next = "Day"
    },
    {
        Name = "Day",
        Time = {
            Initial = 6.5,
            Final = 7,
            Until = 17
        },
        Preview = "Dawn",
        Next = "Sunset"
    },
    {
        Name = "Sunset",
        Time = {
            Initial = 17,
            Final = 18,
            Until = 18
        },
        Preview = "Day",
        Next = "Twilight"
    },
    {
        Name = "Twilight",
        Time = {
            Initial = 18,
            Final = 19.5,
            Until = 5,
        },
        Preview = "Sunset",
        Next = "Night"
    },
    {
        Name = "Night",
        Time = {
            Initial = 19.5,
            Final = 20.5,
            Until = {24, 5},
        },
        Preview = "Twilight",
        Next = "Moonset"
    },
    {
        Name = "Moonset",
        Time = {
            Initial = 5,
            Final = 6,
            Until = 6
        },
        Preview = "Night",
        Next = "Dawn"
    }
}

VisualsConfigs.Weather = {
    Fog = {
        Atmosphere = {
            Density = 0.600
        },
        ColorCorrection = {
            Saturation = -0.5
        },
        Wind = {
            SpeedMin = 0,
            SpeedMax = 20
        }
    },
    Windy = {
        Atmosphere = {
            Density = 0.395
        },
        ColorCorrection = {
            Type = "ExtraConditionsCorrection",
            Saturation = 0
        },
        Wind = {
            SpeedMin = 50,
            SpeedMax = 100
        }
    }
}

VisualsConfigs.Temperature = {
    Cold = {
        ColorCorrection = {
            Type = "TemperatureCorrection",
            TintColor = Color3.fromRGB(230, 241, 255)
        }
    },
    Mild = {
        ColorCorrection = {
            Type = "TemperatureCorrection",
            TintColor = Color3.fromRGB(255, 255, 255)
        }
    },
    Hot = {
        ColorCorrection = {
            Type = "TemperatureCorrection",
            TintColor = Color3.fromRGB(255, 247, 234)
        }
    }
}

------------------ Retornos ------------------
return VisualsConfigs
----------------------------------------------