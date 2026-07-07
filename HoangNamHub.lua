local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Biến kiểm tra xem đã nhập đúng key chưa (Mặc định ban đầu = false)
_G.KeyHopLe = false

-- ==================== 1. KHỞI TẠO MENU CHÍNH ====================
local Window = Fluent:CreateWindow({
    Title = "Hoàng Nam Hub",
    SubTitle = "by Hoàng Nam Adr🍏",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Sửa lỗi Menu trên Mobile (Nút tròn ẩn hiện thần thánh)
Fluent:AddMinimizeButton({
    Button = { Image = "rbxassetid://4483345998" },
    Corner = { CornerRadius = UDim.new(0, 8) }
})

-- Tạo các Tab tính năng hiện rõ ràng ngay từ đầu để tránh lỗi kẹt giao diện
local Tabs = {
    KeySystem = Window:MakeTab({ Title = "Hệ Thống Key", Icon = "rbxassetid://4483345998" }),
    BallControl = Window:MakeTab({ Title = "Điều Khiển Bóng", Icon = "rbxassetid://4483345998" })
}

-- ==================== TAB 1: KHU VỰC NHẬP KEY ====================
Tabs.KeySystem:AddParagraph({
    Title = "Xác thực người dùng",
    Content = "Hệ thống yêu cầu Key mới. Hãy nhập chính xác Key để mở khóa tính năng điều khiển bóng!"
})

local EnteredKey = ""
Tabs.KeySystem:AddInput("InputKey", {
    Title = "Nhập Key mới tại đây:",
    Default = "",
    Placeholder = "Nhập Key...",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        EnteredKey = Value
    end
})

Tabs.KeySystem:AddButton({
    Title = "Kiểm Tra Key",
    Callback = function()
        -- KIỂM TRA KEY MỚI CỦA BẠN TẠI ĐÂY
        if EnteredKey == "HoangNam-972-GGB" then
            _G.KeyHopLe = true -- Mở khóa tính năng thành công!
            Fluent:Notify({
                Title = "Hoàng Nam Hub",
                Content = "Key CHÍNH XÁC! Hãy chuyển sang Tab 'Điều Khiển Bóng' để bật chức năng nhé.",
                SubTitle = "Thành công",
                Duration = 4
            })
        else
            _G.KeyHopLe = false
            Fluent:Notify({
                Title = "Hoàng Nam Hub",
                Content = "Sai Key rồi! Hãy kiểm tra lại từng ký tự.",
                SubTitle = "Lỗi Key",
                Duration = 3
            })
        end
    end
})

-- ==================== TAB 2: KHU VỰC ĐIỀU KHIỂN BÓNG ====================
Tabs.BallControl:AddParagraph({
    Title = "Tính Năng Đá Bóng",
    Content = "Điều khiển và dịch chuyển bóng theo ý muốn của bạn (Chỉ hoạt động khi nhập đúng key)."
})

-- Nút Controll Ball
Tabs.BallControl:AddToggle("ControllBall", {
    Title = "Controll Ball (Điều Khiển Bóng)",
    Default = false,
    Callback = function(Value)
        -- Chặn nếu chưa nhập key thành công
        if not _G.KeyHopLe then
            Fluent:Notify({ Title = "Cảnh Báo", Content = "Bạn chưa nhập đúng Key mới! Vui lòng quay lại Tab Hệ Thống Key.", Duration = 3 })
            return
        end
        
        _G.ControllBall = Value
        if Value then
            Fluent:Notify({ Title = "Hoàng Nam Hub", Content = "Đã bật Điều Khiển Bóng!", Duration = 2 })
            spawn(function()
                while _G.ControllBall and _G.KeyHopLe do
                    task.wait(0.1)
                    -- Luồng code điều khiển bóng nằm ở đây
                end
            end)
        else
            Fluent:Notify({ Title = "Hoàng Nam Hub", Content = "Đã tắt Điều Khiển Bóng!", Duration = 2 })
        end
    end
})

-- Nút TP BALL
Tabs.BallControl:AddButton({
    Title = "TP BALL (Dịch Chuyển Đến Bóng)",
    Callback = function()
        -- Chặn nếu chưa nhập key thành công
        if not _G.KeyHopLe then
            Fluent:Notify({ Title = "Cảnh Báo", Content = "Bạn chưa nhập đúng Key mới! Vui lòng quay lại Tab Hệ Thống Key.", Duration = 3 })
            return
        end
        
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

Window:SelectTab(1) -- Mặc định mở tab nhập Key lên trước
