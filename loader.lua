local HttpService = game:GetService("HttpService")

local response = game:HttpGet("https://noax-backend-tta2.onrender.com/api/load")

local ok, data = pcall(function()
    return HttpService:JSONDecode(response)
end)

if not ok or not data then
    warn("Erreur serveur")
    return
end

if not data.ok then
    warn(data.message or "Erreur")
    return
end

local fn, err = loadstring(data.payload)
if not fn then
    warn(err)
    return
end

fn()
