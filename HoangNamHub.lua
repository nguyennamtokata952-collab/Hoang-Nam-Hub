local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- ==================== 1. KHỞI TẠO MENU CHÍNH TRƯỚC (NHƯNG ẨN ĐI) ====================
local Window = Fluent:CreateWindow({
    Title = "Hoàng Nam Hub",
    SubTitle = "by Hoàng Nam Adr🍏",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Sửa lỗi Menu trên Mobile (Nút tròn ẩn hiện)
Fluent:AddMinimizeButton({
    Button = { Image = "rbxassetid://4483345998" },
    Corner = { CornerRadius = UDim.new(0, 8) }
})

-- Tạo các Tab tính năng cho Menu chính
local Tabs = {
    BallControl = Window:MakeTab({ Title = "Điều Khiển Bóng", Icon = "rbxassetid://4483345998" }),
    Config = Window:MakeTab({ Title = "Cài Đặt", Icon = "rbxassetid://4483345998" })
}

Tabs.BallControl:AddParagraph({
    Title = "Tính Năng Đá Bóng",
    Content = "Điều khiển và dịch chuyển bóng theo ý muốn của bạn."
})

-- Nút 1: Controll Ball
Tabs.BallControl:AddToggle("ControllBall", {
    Title = "Controll Ball (Điều Khiển Bóng)",
    Default = false,
    Callback = function(Value)
        _G.ControllBall = Value
        if Value then
            Fluent:Notify({ Title = "Hoàng Nam Hub", Content = "Đã bật Điều Khiển Bóng!", Duration = 2 })
            spawn(function()
                while _G.ControllBall do
                    task.wait(0.1)
                    -- Code chức năng xử lý bóng dán ở đây
                end
            end)
        else
            Fluent:Notify({ Title = "Hoàng Nam Hub", Content = "Đã tắt Điều Khiển Bóng!", Duration = 2 })
        end
    end
})

-- Nút 2: TP BALL
Tabs.BallControl:AddButton({
    Title = "TP BALL (Dịch Chuyển Đến Bóng)",
    Callback = function()
        Fluent:Notify({ Title = "Hoàng Nam Hub", Content = "Đang dịch chuyển tới vị trí bóng...", Duration = 2 })
        local Ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("Football")
        local HumanoidRootPart = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if Ball and HumanoidRootPart then
            HumanoidRootPart.CFrame = Ball.CFrame + Vector3.new(0, 3, 0)
        else
            Fluent:Notify({ Title = "Lỗi", Content = "Không tìm thấy quả bóng trong sân!", Duration = 3 })
        end
    end
})

Window:SelectTab(1)
Window:Minimize() -- ẨN MENU CHÍNH ĐI KHI CHƯA NHẬP KEY

-- ==================== 2. HỆ THỐNG KIỂM TRA KEY ====================
local KeyWindow = Fluent:CreateWindow({
    Title = "Hoàng Nam Hub - Key System",
    SubTitle = "by Hoàng Nam Adr🍏",
    TabWidth = 160,
    Size = UDim2.fromOffset(450, 300),
    Acrylic = false,
    Theme = "Dark"
})

local KeyTab = KeyWindow:MakeTab({ Title = "Nhập Key", Icon = "rbxassetid://4483345998" })

KeyTab:AddParagraph({
    Title = "Hệ thống bảo mật",
    Content = "Vui lòng nhập chính xác Key để kích hoạt Script."
})

local EnteredKey = ""
KeyTab:AddInput("InputKey", {
    Title = "Nhập Key tại đây:",
    Default = "",
    Placeholder = "Nhập Key...",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        EnteredKey = Value
    end
})

KeyTab:AddButton({
    Title = "Kiểm Tra Key",
    Callback = function()
        if EnteredKey == "HoangNam" then
            Fluent:Notify({
                Title = "Hoàng Nam Hub",
                Content = "Key chính xác! Đang mở menu...",
                SubTitle = "Thành công",
                Duration = 3
            })
            task.wait(0.5)
            KeyWindow:Destroy() -- Xóa bảng nhập Key đi
            Window:Minimize()   -- Lệnh này của Fluent sẽ kích hoạt HIỆN lại Menu chính đầy đủ chức năng!
        else
            Fluent:Notify({
                Title = "Hoàng Nam Hub",
                Content = "Sai Key rồi bạn ơi! Vui lòng thử lại.",
                SubTitle = "Lỗi Key",
                Duration = 3
            })
        end
    end
})

KeyWindow:SelectTab(1)
