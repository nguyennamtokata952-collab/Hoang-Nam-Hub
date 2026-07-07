getgenv().ScriptTitle = "Hoàng Nam Hub"
getgenv().ScriptSubTitle = "V2"

-- Sử dụng thư viện giao diện Kavo ổn định hơn trên điện thoại
local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Kavo.CreateLib(getgenv().ScriptTitle .. " " .. getgenv().ScriptSubTitle, "DarkTheme")

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

-- Tạo các Tab chức năng
local TabFarm = Window:NewTab("Tự Động (Farm)")
local TabTele = Window:NewTab("Dịch Chuyển")
local TabESP = Window:NewTab("Định Vị (ESP)")
local TabPVP = Window:NewTab("Tự Động PVP")
local TabMisc = Window:NewTab("Khác / Trái Quỷ")

-- Tạo các Section bên trong Tab
local SectionFarm = TabFarm:NewSection("Farm Level & Boss")
local SectionTele = TabTele:NewSection("Chọn Đảo")
local SectionESP = TabESP:NewSection("Định vị")
local SectionPVP = TabPVP:NewSection("Săn Bounty")
local SectionMisc = TabMisc:NewSection("Tiện ích")

SectionFarm:NewToggle("Tự động Farm Level", "Tự động đánh quái farm cấp", function(Value)
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
end)

local BossList = {"Saber Expert", "The Saw", "Greybeard", "Beautiful Pirate", "Rip_Indra", "Dough King"}
SectionFarm:NewDropdown("Chọn Boss", "Chọn con boss muốn diệt", BossList, function(SelectedBoss)
    _G.SelectedBossName = SelectedBoss
end)

SectionFarm:NewToggle("Tự động đánh Boss đã chọn", "Farm boss tự động", function(Value)
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
end)

local IslandList = {"Đảo Tân Thủ", "Đảo Khỉ", "Đảo Cát", "Đảo Tuyết", "Dinh Thự"}
local IslandPositions = {
    ["Đảo Tân Thủ"] = Vector3.new(979, 11, 1242),
    ["Đảo Khỉ"] = Vector3.new(-1611, 36, 151),
    ["Đảo Cát"] = Vector3.new(-1120, 14, 4010),
    ["Đảo Tuyết"] = Vector3.new(1286, 6, -1341),
    ["Dinh Thự"] = Vector3.new(-12463, 331, -7555)
}

SectionTele:NewDropdown("Chọn Đảo Dịch Chuyển", "Chọn đảo cần đến", IslandList, function(SelectedIsland)
    _G.SelectedIslandName = SelectedIsland
end)

SectionTele:NewButton("Bay Đến Đảo Đã Chọn", "Teleport lập tức", function()
    local pos = IslandPositions[_G.SelectedIslandName]
    if pos and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end)

SectionESP:NewToggle("Định vị Trái Ác Quỷ (ESP Fruit)", "Hiện vị trí trái ác quỷ", function(Value)
    _G.ESPFruit = Value
end)

SectionESP:NewToggle("Định vị Người Chơi (ESP Player)", "Hiện vị trí người chơi khác", function(Value)
    _G.ESPPlayer = Value
end)

local function GetPlayerNames()
    local tbl = {}
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP then table.insert(tbl, v.Name) end
    end
    return tbl
end

SectionPVP:NewDropdown("Chọn Người Chơi", "Chọn mục tiêu pvp", GetPlayerNames(), function(SelectedPlayer)
    _G.TargetPlayer = SelectedPlayer
end)

SectionPVP:NewToggle("Tự động Săn Bounties", "Tự bay đến vả mục tiêu", function(Value)
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
end)

SectionMisc:NewSlider("Chạy Nhanh (WalkSpeed)", "Kéo thanh để đổi tốc độ", 300, 16, function(Value)
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = Value
    end
end)

SectionMisc:NewButton("Tự Động Gacha Trái Ác Quỷ", "Bấm để random hên xui", function()
    ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "BuyFruit")
end)
