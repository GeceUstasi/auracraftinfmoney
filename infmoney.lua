local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI Oluşturma
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FuseGui"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 250, 0, 120)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.4
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true

-- Çerçeveye gölge efekti (UIStroke)
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 255, 128)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Başlık Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Infinite Money"
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 24
titleLabel.Parent = mainFrame

-- "Get inf Money" Butonu
local fireButton = Instance.new("TextButton")
fireButton.Name = "FireButton"
fireButton.Text = "Get inf Money"
fireButton.Size = UDim2.new(0, 200, 0, 50)
fireButton.Position = UDim2.new(0.5, -100, 0, 40)
fireButton.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
fireButton.TextColor3 = Color3.fromRGB(20, 20, 20)
fireButton.Font = Enum.Font.GothamBold
fireButton.TextSize = 22
fireButton.AutoButtonColor = true
fireButton.Parent = mainFrame

-- Kapat Butonu
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.Parent = mainFrame

-- Buton fonksiyonları
fireButton.MouseButton1Click:Connect(function()
    local fuse = game:GetService("ReplicatedStorage"):FindFirstChild("FUSE")
    if fuse then
        for i = 1, 100 do
            fuse:FireServer()
            wait(0.03) -- Çok hızlı spamlama olmaması için ufak bekleme, isteğe bağlı
        end
    else
        warn("FUSE isimli RemoteEvent bulunamadı!")
    end
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Hareket ettirme (drag) fonksiyonu
local UserInputService = game:GetService("UserInputService")

local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
