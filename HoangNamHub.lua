local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- 2. Tạo cửa sổ chính (Window) của Hoàng Nam Hub
local Window = Fluent:CreateWindow({
    Title = "Hoàng Nam Hub",
    SubTitle = "by adr🍏 [Nokey v1.0]",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark"
})

-- 3. Tạo Tab Menu bên trái (Sidebar)
local Tabs = {
    Farm = Window:AddTab({ Title = "Farm", Icon = "home" }),
    Config = Window:AddTab({ Title = "Config", Icon = "settings" })
}
