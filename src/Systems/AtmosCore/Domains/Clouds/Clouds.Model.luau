------------------- Inicio -------------------
local CloudsModel = {}
------------------- Requires -----------------

------------------ Variáveis -----------------

CloudsModel.Clouds = {
    {
        Cover = 0.63,
        Density = 0.06,
        Color = Color3.fromRGB(255, 255, 255)
    },
    {
        Cover = 0.56,
        Density = 0.5,
        Color = Color3.fromRGB(255, 255, 255)
    },
    {
        Cover = 0.66,
        Density = 0.5,
        Color = Color3.fromRGB(255, 255, 255)
    },
    {
        Cover = 0.87,
        Density = 0.75,
        Color = Color3.fromRGB(134, 134, 134)
    },
    {
        Cover = 1,
        Density = 1,
        Color = Color3.fromRGB(35, 35, 35)
    },
}

CloudsModel.OldDensity = CloudsModel.Clouds[1]
CloudsModel.Density = 1

------------------ Retornos ------------------
return CloudsModel
----------------------------------------------