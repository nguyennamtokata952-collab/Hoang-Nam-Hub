
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Hoàng Nam Hub",
    SubTitle = "by adr🍏",
    TabWidth = 160, Size = UDim2.fromOffset(580, 460),
    Theme = "Dark", MinimizeKey = Enum.KeyCode.LeftControl
})
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Farm = Window:AddTab({ Title = "Farm", Icon = "swords" })
}
Tabs.Farm:AddSection("Auto Farm")
Tabs.Farm:AddToggle("AutoFarmLevel", {Title = "Auto Farm Level", Default = false})
        
Hãy copy cấu trúc này vào file GitHub của bạn
