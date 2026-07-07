local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- 1. Khởi tạo Giao diện chính (Sửa tên theo ý bạn)
local Window = Fluent:CreateWindow({
    Title = "Hoàng Nam Hub",
    SubTitle = "by Hoàng Nam adr🍏",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- Tắt để menu mượt hơn trên máy yếu
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Nhấn Ctrl trái để ẩn/hiện nếu chơi PC
})

-- 2. SỬA LỖI MENU TRÊN MOBILE (Tạo nút tròn mờ để bấm ẩn/hiện)
Fluent:AddMinimizeButton({
    Button = { Image = "rbxassetid://4483345998" }, -- Icon nút ẩn hiện
    Corner = { CornerRadius = UDim.new(0, 8) }
})

-- 3. Tạo các Danh mục (Tab) giống Nô Nô Hub
local Tabs = {
    Farm = Window:MakeTab({ Title = "Farm", Icon = "rbxassetid://4483345998" }),
    Stats = Window:MakeTab({ Title = "Chỉ Số (Stats)", Icon = "rbxassetid://4483345998" }),
    Teleport = Window:MakeTab({ Title = "Dịch Chuyển", Icon = "rbxassetid://4483345998" }),
    Config = Window:MakeTab({ Title = "Cài Đặt", Icon = "rbxassetid://4483345998" })
}

-- ==================== DANH MỤC: FARM ====================
Tabs.Farm:AddParagraph({
    Title = "Chức Năng Farm Quái",
    Content = "Hãy bật các tùy chọn dưới đây để tự động cày cấp"
})

-- Nút Auto Farm Level
Tabs.Farm:AddToggle("AutoFarmLevel", {
    Title = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        if Value then
            print("Đã bật Auto Farm Level")
            -- Code chức năng Farm chính của bạn sẽ dán ở đây
        else
            print("Đã tắt Auto Farm Level")
        end
    end
})

-- Nút Auto Farm Nearest (Quái gần nhất)
Tabs.Farm:AddToggle("AutoFarmNearest", {
    Title = "Auto Farm Quái Gần Nhất",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmNearest = Value
        if Value then
            print("Đã bật Auto Farm Nearest")
        else
            print("Đã tắt Auto Farm Nearest")
        end
    end
})

-- Nút Tự động nhận nhiệm vụ (Auto Bone / Quests...)
Tabs.Farm:AddToggle("AutoQuest", {
    Title = "Auto Nhận Nhiệm Vụ",
    Default = false,
    Callback = function(Value)
        _G.AutoQuest = Value
    end
})

-- ==================== DANH MỤC: CHỈ SỐ (STATS) ====================
Tabs.Stats:AddParagraph({ Title = "Nâng Chỉ Số", Content = "Tự động cộng điểm khi lên cấp" })

Tabs.Stats:AddToggle("AutoMelee", { Title = "Auto Cộng Cận Chiến (Melee)", Default = false, Callback = function(v) _G.Melee = v end })
Tabs.Stats:AddToggle("AutoDefense", { Title = "Auto Cộng Phòng Thủ (Defense)", Default = false, Callback = function(v) _G.Defense = v end })
Tabs.Stats:AddToggle("AutoSword", { Title = "Auto Cộng Kiếm (Sword)", Default = false, Callback = function(v) _G.Sword = v end })

-- ==================== DANH MỤC: DỊCH CHUYỂN ====================
Tabs.Teleport:AddButton({
    Title = "Dịch chuyển sang Sea 1",
    Callback = function()
        print("Đang chuyển sang Sea 1...")
    end
})

Tabs.Teleport:AddButton({
    Title = "Dịch chuyển sang Sea 2",
    Callback = function()
        print("Đang chuyển sang Sea 2...")
    end
})

Tabs.Teleport:AddButton({
    Title = "Dịch chuyển sang Sea 3",
    Callback = function()
        print("Đang chuyển sang Sea 3...")
    end
})

-- Chọn giao diện mặc định khi mở lên
Window:SelectTab(1)
