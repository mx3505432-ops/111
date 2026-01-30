-- LocalScript (放 StarterPlayerScripts 或 StarterGui)

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CyberNeonUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- 主框架（高度增加以容纳玩家列表）
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 360, 0, 280)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 16)
uiCorner.Parent = mainFrame

-- 背景漸變
local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 10, 40)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 5, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 15))
}
bgGradient.Rotation = 135
bgGradient.Parent = mainFrame

-- 霓虹邊框
local neonStroke = Instance.new("UIStroke")
neonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
neonStroke.Color = Color3.fromRGB(0, 255, 255)
neonStroke.Thickness = 3
neonStroke.Transparency = 0.3
neonStroke.Parent = mainFrame

local strokeGradient = Instance.new("UIGradient")
strokeGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
}
strokeGradient.Rotation = 0
strokeGradient.Parent = neonStroke

-- 標題欄
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 18, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.Code
titleLabel.Text = "NEON CONTROL v3.2"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 240)
titleLabel.TextSize = 17
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- 實時時間顯示
local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(0.4, 0, 1, 0)
timeLabel.Position = UDim2.new(0.6, 0, 0, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.Font = Enum.Font.Code
timeLabel.Text = "00:00:00"
timeLabel.TextColor3 = Color3.fromRGB(180, 255, 180)
timeLabel.TextSize = 16
timeLabel.TextXAlignment = Enum.TextXAlignment.Right
timeLabel.TextTransparency = 0.1
timeLabel.Parent = titleBar

local timeStroke = Instance.new("UIStroke")
timeStroke.Color = Color3.fromRGB(180, 255, 180)
timeStroke.Thickness = 1
timeStroke.Transparency = 0.6
timeStroke.Parent = timeLabel

-- Neon 按鈕生成器
local function createNeonButton(pos, text, color, clickFunc)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 32, 0, 32)
    btn.Position = pos
    btn.BackgroundTransparency = 1
    btn.Font = Enum.Font.Code
    btn.Text = text
    btn.TextColor3 = color
    btn.TextSize = 22
    btn.Parent = titleBar

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = color
    btnStroke.Thickness = 2
    btnStroke.Transparency = 0.4
    btnStroke.Parent = btn

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0, Thickness = 3}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.4, Thickness = 2}):Play()
    end)

    btn.Activated:Connect(clickFunc)
    return btn
end

-- 關閉按鈕
createNeonButton(UDim2.new(1, -40, 0, 6), "×", Color3.fromRGB(255, 80, 80), function()
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -180, 1.5, 0)
    })
    tween:Play()
    tween.Completed:Connect(function() screenGui:Destroy() end)
end)

-- 最小化按鈕
local miniBtn = createNeonButton(UDim2.new(1, -78, 0, 6), "−", Color3.fromRGB(180, 180, 255), nil)
local minimized = false

miniBtn.Activated:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 360, 0, 45)}):Play()
        content.Visible = false
        miniBtn.Text = "+"
    else
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 360, 0, 280)}):Play()
        task.wait(0.25)
        content.Visible = true
        miniBtn.Text = "−"
    end
end)

-- 內容區
local content = Instance.new("Frame")
content.Size = UDim2.new(1, 0, 1, -55)
content.Position = UDim2.new(0, 0, 0, 45)
content.BackgroundTransparency = 1
content.Parent = mainFrame

-- 传送面板标题
local tpTitle = Instance.new("TextLabel")
tpTitle.Size = UDim2.new(1, -24, 0, 32)
tpTitle.Position = UDim2.new(0, 12, 0, 12)
tpTitle.BackgroundColor3 = Color3.fromRGB(12, 12, 25)
tpTitle.BorderSizePixel = 0
tpTitle.Font = Enum.Font.Code
tpTitle.Text = " TELEPORT TO PLAYERS "
tpTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
tpTitle.TextSize = 15
tpTitle.Parent = content

local tpTitleCorner = Instance.new("UICorner")
tpTitleCorner.CornerRadius = UDim.new(0, 10)
tpTitleCorner.Parent = tpTitle

local tpTitleStroke = Instance.new("UIStroke")
tpTitleStroke.Color = Color3.fromRGB(0, 255, 255)
tpTitleStroke.Thickness = 1.5
tpTitleStroke.Transparency = 0.5
tpTitleStroke.Parent = tpTitle

-- 刷新按钮
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0, 80, 0, 28)
refreshBtn.Position = UDim2.new(1, -92, 0, 14)
refreshBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
refreshBtn.BorderSizePixel = 0
refreshBtn.Font = Enum.Font.Code
refreshBtn.Text = "REFRESH"
refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 180)
refreshBtn.TextSize = 13
refreshBtn.Parent = content

local refreshCorner = Instance.new("UICorner")
refreshCorner.CornerRadius = UDim.new(0, 8)
refreshCorner.Parent = refreshBtn

local refreshStroke = Instance.new("UIStroke")
refreshStroke.Color = Color3.fromRGB(255, 255, 180)
refreshStroke.Thickness = 1.5
refreshStroke.Transparency = 0.4
refreshStroke.Parent = refreshBtn

-- Hover for refresh
refreshBtn.MouseEnter:Connect(function()
    TweenService:Create(refreshStroke, TweenInfo.new(0.2), {Transparency = 0, Thickness = 2.5}):Play()
end)
refreshBtn.MouseLeave:Connect(function()
    TweenService:Create(refreshStroke, TweenInfo.new(0.2), {Transparency = 0.4, Thickness = 1.5}):Play()
end)

-- 玩家列表 ScrollingFrame
local playerList = Instance.new("ScrollingFrame")
playerList.Size = UDim2.new(1, -24, 1, -70)
playerList.Position = UDim2.new(0, 12, 0, 52)
playerList.BackgroundTransparency = 1
playerList.BorderSizePixel = 0
playerList.ScrollBarThickness = 6
playerList.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.Parent = content

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Padding = UDim.new(0, 6)
listLayout.Parent = playerList

-- 传送函数
local function teleportTo(targetPlayer)
    if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") 
    and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        -- 可选：添加传送特效（粒子或Tween）
        local tween = TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
            CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        })
        tween:Play()
    end
end

-- 生成玩家列表
local function refreshPlayerList()
    -- 清空旧按钮
    for _, child in pairs(playerList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local players = Players:GetPlayers()
    local ySize = 0
    
    for _, target in pairs(players) do
        if target ~= player then
            local playerBtn = Instance.new("TextButton")
            playerBtn.Size = UDim2.new(1, 0, 0, 36)
            playerBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 25)
            playerBtn.BorderSizePixel = 0
            playerBtn.Font = Enum.Font.Code
            playerBtn.Text = " " .. target.DisplayName .. " (" .. target.Name .. ")"
            playerBtn.TextColor3 = Color3.fromRGB(180, 255, 180)
            playerBtn.TextSize = 14
            playerBtn.TextXAlignment = Enum.TextXAlignment.Left
            playerBtn.Parent = playerList

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 8)
            btnCorner.Parent = playerBtn

            local btnStroke = Instance.new("UIStroke")
            btnStroke.Color = Color3.fromRGB(180, 255, 180)
            btnStroke.Thickness = 1.5
            btnStroke.Transparency = 0.5
            btnStroke.Parent = playerBtn

            -- Hover 效果
            playerBtn.MouseEnter:Connect(function()
                TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0, Thickness = 2.5}):Play()
                TweenService:Create(playerBtn, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 40)}):Play()
            end)
            playerBtn.MouseLeave:Connect(function()
                TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.5, Thickness = 1.5}):Play()
                TweenService:Create(playerBtn, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 36)}):Play()
            end)

            playerBtn.Activated:Connect(function()
                teleportTo(target)
            end)
            
            ySize = ySize + 42  -- 按钮高 + padding
        end
    end
    
    playerList.CanvasSize = UDim2.new(0, 0, 0, ySize)
end

-- 刷新事件
refreshBtn.Activated:Connect(refreshPlayerList)

-- 初始刷新
refreshPlayerList()

-- 實時時間更新
local function updateTime()
    local t = os.date("*t")
    local timeStr = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
    timeLabel.Text = timeStr
end

task.spawn(function()
    while true do
        updateTime()
        task.wait(1)
    end
end)

-- 動態效果
local time = 0
RunService.RenderStepped:Connect(function(dt)
    time += dt
    
    strokeGradient.Rotation = (time * 40) % 360
    local breath = 0.3 + math.sin(time * 2) * 0.15
    neonStroke.Transparency = breath
    titleLabel.TextTransparency = 0.05 + math.abs(math.sin(time * 5)) * 0.08
    timeLabel.TextTransparency = 0.05 + math.sin(time * 3) * 0.08
end)

-- 拖動功能
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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

titleBar.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- 初始時間
updateTime()

print("CyberNeon UI + Player Teleport List 已加載 — 點擊玩家傳送！")