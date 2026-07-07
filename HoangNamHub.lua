getgenv().ScriptTitle = "Hoàng Nam Hub"
getgenv().ScriptSubTitle = "V2"
getgenv().ScriptImage = "https://i.ibb.co/LdqZGv46/2148.png"
getgenv().ScriptAuthorName = "Hoàng Nam"
getgenv().ScriptAuthorSubTitle = "https://discord.gg/brAqDRXVp"

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bracket-v2/Bracket-V2/main/bracket-v2.lua"))()
local Window = Library:CreateWindow({
    Name = getgenv().ScriptTitle .. " " .. getgenv().ScriptSubTitle,
    Size = UDim2.new(0, 520, 0, 400),
    ToggleKey = Enum.KeyCode.RightControl,
    Theme = "Dark"
})

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local TabFarm = Window:CreateTab("Tự Động (Farm)")
local TabTele = Window:CreateTab("Dịch Chuyển")
local TabESP = Window:CreateTab("Định Vị (ESP)")
local TabPVP = Window:CreateTab("Tự Động PVP")
local TabMisc = Window:CreateTab("Khác / Trái Quỷ")

TabFarm:CreateToggle({
    Name = "Tự động Farm Level",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarmLV = Value
        task.spawn(function()
            while _G.AutoFarmLV do task.wait(0.1)
                pcall(function()
                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                            LP.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton1(Vector2.new(850, 520))
                        end
                    end
                end)
            end
        end)
    end
})

local BossList = {"Saber Expert", "The Saw", "Greybeard", "Beautiful Pirate", "Rip_Indra", "Dough King"}
TabFarm:CreateDropdown({
    Name = "Chọn Boss",
    Options = BossList,
    CurrentOption = BossList[1],
    Callback = function(SelectedBoss)
        _G.SelectedBossName = SelectedBoss
    end
})

TabFarm:CreateToggle({
    Name = "Tự động đánh Boss đã chọn",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarmBoss = Value
        task.spawn(function()
            while _G.AutoFarmBoss do task.wait(0.1)
                pcall(function()
                    local targetBoss = workspace.Enemies:FindFirstChild(_G.SelectedBossName) or workspace.Bosses:FindFirstChild(_G.SelectedBossName)
                    if targetBoss and targetBoss:FindFirstChild("Humanoid") and targetBoss.Humanoid.Health > 0 then
                        LP.Character.HumanoidRootPart.CFrame = targetBoss.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    end
                end)
            end
        end)
    end
})

local IslandList = {"Đảo Tân Thủ", "Đảo Khỉ", "Đảo Cát", "Đảo Tuyết", "Dinh Thự"}
local IslandPositions = {
    ["Đảo Tân Thủ"] = Vector3.new(979, 11, 1242),
    ["Đảo Khỉ"] = Vector3.new(-1611, 36, 151),
    ["Đảo Cát"] = Vector3.new(-1120, 14, 4010),
    ["Đảo Tuyết"] = Vector3.new(1286, 6, -1341),
    ["Dinh Thự"] = Vector3.new(-12463, 331, -7555)
}

TabTele:CreateDropdown({
    Name = "Chọn Đảo Dịch Chuyển",
    Options = IslandList,
    CurrentOption = IslandList[1],
    Callback = function(SelectedIsland)
        _G.SelectedIslandName = SelectedIsland
    end
})

TabTele:CreateButton({
    Name = "Bay Đến Đảo Đã Chọn",
    Callback = function()
        local pos = IslandPositions[_G.SelectedIslandName]
        if pos and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
        end
    end
})

TabESP:CreateToggle({
    Name = "Định vị Trái Ác Quỷ (ESP Fruit)",
    CurrentValue = false,
    Callback = function(Value)
        _G.ESPFruit = Value
    end
})

TabESP:CreateToggle({
    Name = "Định vị Người Chơi (ESP Player)",
    CurrentValue = false,
    Callback = function(Value)
        _G.ESPPlayer = Value
    end
})

local function GetPlayerNames()
    local tbl = {}
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP then table.insert(tbl, v.Name) end
    end
    return tbl
end

TabPVP:CreateDropdown({
    Name = "Chọn Người Chơi",
    Options = GetPlayerNames(),
    CurrentOption = "",
    Callback = function(SelectedPlayer)
        _G.TargetPlayer = SelectedPlayer
    end
})

TabPVP:CreateToggle({
    Name = "Tự động Săn Bounties",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoPVP = Value
        task.spawn(function()
            while _G.AutoPVP do task.wait(0.1)
                pcall(function()
                    local p = Players:FindFirstChild(_G.TargetPlayer)
                    if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        LP.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    end
                end)
            end
        end)
    end
})

TabMisc:CreateSlider({
    Name = "Chạy Nhanh (WalkSpeed)",
    Min = 16,
    Max = 300,
    CurrentValue = 16,
    Callback = function(Value)
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.WalkSpeed = Value
        end
    end
})

TabMisc:CreateButton({
    Name = "Tự Động Gacha Trái Ác Quỷ (Random)",
    Callback = function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "BuyFruit")
    end
})

Library:Notify({
    Title = getgenv().ScriptTitle,
    Content = "Xin chào Hoàng Nam! Menu V2 đã sẵn sàng hoạt động.",
    Duration = 5
})
