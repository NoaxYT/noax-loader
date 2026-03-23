local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
if not player then
    return
end

local userId = tostring(player.UserId)

local url = "https://noax-backend-tta2.onrender.com/api/load?userId=" .. userId

local response = game:HttpGet(url)

local ok, data = pcall(function()
    return HttpService:JSONDecode(response)
end)

if not ok or not data then
    warn("Erreur serveur")
    return
end

if not data.ok then
    warn(data.message or "Accès refusé")
    return
end

local fn, err = loadstring(data.payload)
if not fn then
    warn(err)
    return
end

fn()
