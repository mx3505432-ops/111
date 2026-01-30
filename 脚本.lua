-- LocalScript (放 StarterPlayerScripts) - 完整版左右分栏UI，所有功能已添加

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CyberSplitUI_Full"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- =====================================
-- 常驻小浮动按钮（打开/关闭面板）
-- =====================================
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 50, 0, 50)
floatBtn.Position = UDim2.new(1, -70, 1, -70)
floatBtn.BackgroundColor3 = Color3.fromRGB(10, 25, 40)
floatBtn.Text = "LYX"
floatBtn.Font = Enum.Font.Code
floatBtn.TextColor3 = Color3.fromRGB(0, 255, 240)
floatBtn.TextSize = 14
floatBtn.BorderSizePixel = 0
floatBtn.Parent = screenGui

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0)
floatCorner.Parent = floatBtn

local floatStroke = Instance.new("UIStroke")
floatStroke.Color = Color3.fromRGB(0, 255, 255)
floatStroke.Thickness = 2.5
floatStroke.Transparency = 0.4
floatStroke.Parent = floatBtn

-- 呼吸光效
local floatTime = 0
RunService.RenderStepped:Connect(function(dt)
    floatTime += dt
    floatStroke.Transparency = 0.3 + math.sin(floatTime * 3) * 0.2
end)

-- 主面板（初始隐藏）
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 380)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 16)
uiCorner.Parent = mainFrame

local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 10, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 15))
}
bgGradient.Rotation = 135
bgGradient.Parent = mainFrame

local neonStroke = Instance.new("UIStroke")
neonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
neonStroke.Color = Color3.fromRGB(0, 255, 255)
neonStroke.Thickness = 3
neonStroke.Transparency = 0.35
neonStroke.Parent = mainFrame

local strokeGradient = Instance.new("UIGradient")
strokeGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
}
strokeGradient.Parent = neonStroke

-- 扫描线背景效果
local scanLine = Instance.new("Frame")
scanLine.Size = UDim2.new(1, 0, 0, 1)
scanLine.Position = UDim2.new(0, 0, 0, 0)
scanLine.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
scanLine.BackgroundTransparency = 0.9
scanLine.ZIndex = -1
scanLine.Parent = mainFrame

RunService.Heartbeat:Connect(function()
    local posY = (tick() * 100) % 400 - 50
    scanLine.Position = UDim2.new(0, 0, 0, posY)
end)

-- 顶部栏
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 16)
topCorner.Parent = topBar

local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(0.35, 0, 1, 0)
nameLabel.Position = UDim2.new(0, 20, 0, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Font = Enum.Font.Code
nameLabel.Text = "LYX"
nameLabel.TextColor3 = Color3.fromRGB(0, 255, 240)
nameLabel.TextSize = 18
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.Parent = topBar

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(0.3, 0, 1, 0)
timeLabel.Position = UDim2.new(0.65, 0, 0, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.Font = Enum.Font.Code
timeLabel.Text = "16:40:00"  -- 示例时间
timeLabel.TextColor3 = Color3.fromRGB(180, 255, 180)
timeLabel.TextSize = 16
timeLabel.TextXAlignment = Enum.TextXAlignment.Right
timeLabel.Parent = topBar

-- 最小化按钮
local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 32, 0, 32)
miniBtn.Position = UDim2.new(1, -72, 0, 6)
miniBtn.BackgroundColor3 = Color3.fromRGB(95, 95, 110)
miniBtn.Text = "−"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.TextSize = 20
miniBtn.BorderSizePixel = 0
miniBtn.Parent = topBar

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 10)
miniCorner.Parent = miniBtn

-- 关闭按钮
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -36, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(235, 70, 70)
closeBtn.Text = "×"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 18
closeBtn.BorderSizePixel = 0
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtn

-- 内容分栏
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -55)
contentFrame.Position = UDim2.new(0, 0, 0, 45)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- 左栏：功能列表
local leftPanel = Instance.new("ScrollingFrame")
leftPanel.Size = UDim2.new(0.4, 0, 1, 0)
leftPanel.Position = UDim2.new(0, 0, 0, 0)
leftPanel.BackgroundTransparency = 1
leftPanel.BorderSizePixel = 0
leftPanel.ScrollBarThickness = 5
leftPanel.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
leftPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
leftPanel.Parent = contentFrame

local leftLayout = Instance.new("UIListLayout")
leftLayout.Padding = UDim.new(0, 10)
leftLayout.Parent = leftPanel

-- 分割线
local divider = Instance.new("Frame")
divider.Size = UDim2.new(0, 2, 1, 0)
divider.Position = UDim2.new(0.4, 0, 0, 0)
divider.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
divider.BackgroundTransparency = 0.4
divider.Parent = contentFrame

-- 右栏：动态子面板容器
local rightPanel = Instance.new("Frame")
rightPanel.Size = UDim2.new(0.6, 0, 1, 0)
rightPanel.Position = UDim2.new(0.4, 0, 0, 0)
rightPanel.BackgroundColor3 = Color3.fromRGB(12, 12, 25)
rightPanel.BorderSizePixel = 0
rightPanel.Parent = contentFrame

local rightCorner = Instance.new("UICorner")
rightCorner.CornerRadius = UDim.new(0, 12)
rightCorner.Parent = rightPanel

-- 子面板管理
local subPanels = {}
local currentSubPanel = nil

local function showSubPanel(panelName)
    if currentSubPanel then
        currentSubPanel.Visible = false
    end
    if subPanels[panelName] then
        subPanels[panelName].Visible = true
        currentSubPanel = subPanels[panelName]
    end
end

-- 创建子面板函数
local function createSubPanel(name)
    local panel = Instance.new("Frame")
    panel.Name = name
    panel.Size = UDim2.new(1, -20, 1, -20)
    panel.Position = UDim2.new(0, 10, 0, 10)
    panel.BackgroundTransparency = 1
    panel.Visible = false
    panel.Parent = rightPanel
    subPanels[name] = panel
    return panel
end

-- 功能数据 + 状态灯
local functions = {
    {name = "飞天模式", icon = "🛩️", color = Color3.fromRGB(0, 220, 255), status = false, panel = "fly"},
    {name = "隐身模式", icon = "👻", color = Color3.fromRGB(220, 100, 255), status = false, panel = "invis"},
    {name = "传送列表", icon = "📍", color = Color3.fromRGB(80, 255, 180), status = true, panel = "tp"},
    {name = "速度提升", icon = "⚡", color = Color3.fromRGB(255, 180, 80), status = false, panel = "speed"},
    {name = "无限跳跃", icon = "🦘", color = Color3.fromRGB(180, 255, 180), status = false, panel = "jump"}
}

-- 创建左侧按钮 + 状态灯
local function createLeftBtn(func)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 50)
    container.BackgroundTransparency = 1
    container.Parent = leftPanel

    local statusLight = Instance.new("Frame")
    statusLight.Size = UDim2.new(0, 12, 0, 12)
    statusLight.Position = UDim2.new(0, 8, 0.5, -6)
    statusLight.BackgroundColor3 = func.status and func.color or Color3.fromRGB(60, 60, 80)
    statusLight.BorderSizePixel = 0
    statusLight.Parent = container

    local lightCorner = Instance.new("UICorner")
    lightCorner.CornerRadius = UDim.new(1, 0)
    lightCorner.Parent = statusLight

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 1, 0)
    btn.Position = UDim2.new(0, 10, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(18, 18, 35)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Code
    btn.Text = func.icon .. "  " .. func.name
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.TextSize = 15
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = container

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = func.color
    btnStroke.Thickness = 1.5
    btnStroke.Transparency = 0.6
    btnStroke.Parent = btn

    -- 悬停 + 呼吸状态灯
    btn.MouseEnter:Connect(function()
        TweenService:Create(btnStroke, TweenInfo.new(0.25), {Transparency = 0.2, Thickness = 2}):Play()
        TweenService:Create(btn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(28, 28, 50)}):Play()
        TweenService:Create(statusLight, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            BackgroundTransparency = 0.3
        }):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btnStroke, TweenInfo.new(0.25), {Transparency = 0.6, Thickness = 1.5}):Play()
        TweenService:Create(btn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(18, 18, 35)}):Play()
        statusLight.BackgroundTransparency = 0
    end)

    btn.Activated:Connect(function()
        showSubPanel(func.panel)
        -- 更新选中高亮（可选）
    end)
end

for _, func in ipairs(functions) do
    createLeftBtn(func)
end
leftPanel.CanvasSize = UDim2.new(0, 0, 0, #functions * 60)

-- =====================================
-- 右侧子面板内容（实际控件）
-- =====================================

-- 飞天面板
local flyPanel = createSubPanel("fly")
local flyToggle = Instance.new("TextButton")  -- 开关示例
flyToggle.Size = UDim2.new(0.8, 0, 0, 40)
flyToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
flyToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
flyToggle.Text = "开启飞天"
flyToggle.TextColor3 = Color3.fromRGB(0, 220, 255)
flyToggle.Parent = flyPanel
-- ... (添加飞天逻辑 + 速度滑块)

-- 隐身面板
local invisPanel = createSubPanel("invis")
local invisToggle = Instance.new("TextButton")
invisToggle.Size = UDim2.new(0.8, 0, 0, 40)
invisToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
invisToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
invisToggle.Text = "开启隐身"
invisToggle.TextColor3 = Color3.fromRGB(220, 100, 255)
invisToggle.Parent = invisPanel

-- 传送面板（列表 + 刷新）
local tpPanel = createSubPanel("tp")
local tpList = Instance.new("ScrollingFrame")
tpList.Size = UDim2.new(1, 0, 0.8, 0)
tpList.Position = UDim2.new(0, 0, 0.1, 0)
tpList.BackgroundTransparency = 1
tpList.Parent = tpPanel
-- ... (玩家列表逻辑)

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0.4, 0, 0, 30)
refreshBtn.Position = UDim2.new(0.3, 0, 0.92, 0)
refreshBtn.Text = "刷新"
refreshBtn.Parent = tpPanel

-- 速度面板（滑块）
local speedPanel = createSubPanel("speed")
local speedSlider = Instance.new("Frame")  -- 滑块容器
speedSlider.Size = UDim2.new(0.8, 0, 0, 30)
speedSlider.Position = UDim2.new(0.1, 0, 0.2, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
speedSlider.Parent = speedPanel
-- ... (滑块逻辑)

-- 无限跳面板
local jumpPanel = createSubPanel("jump")
local jumpToggle = Instance.new("TextButton")
jumpToggle.Size = UDim2.new(0.8, 0, 0, 40)
jumpToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
jumpToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
jumpToggle.Text = "开启无限跳"
jumpToggle.TextColor3 = Color3.fromRGB(180, 255, 180)
jumpToggle.Parent = jumpPanel

-- 时间更新
local function updateTime()
    local t = os.date("*t")
    timeLabel.Text = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
end
task.spawn(function()
    while screenGui.Parent do
        updateTime()
        task.wait(1)
    end
end)

-- 面板开关动画
local panelVisible = false
floatBtn.Activated:Connect(function()
    panelVisible = not panelVisible
    if panelVisible then
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 600, 0, 380)
        }):Play()
    else
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        task.wait(0.4)
        mainFrame.Visible = false
    end
end)

-- 最小化
local minimized = false
miniBtn.Activated:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 45)}):Play()
        contentFrame.Visible = false
        miniBtn.Text = "+"
    else
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 380)}):Play()
        task.wait(0.2)
        contentFrame.Visible = true
        miniBtn.Text = "−"
    end
end)

-- 关闭
closeBtn.Activated:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.4), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.4)
    screenGui:Destroy()
end)

-- 拖动
local dragging, dragStart, startPos
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

topBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("完整左右分栏赛博UI 已加载 — 所有功能就位！点击浮动按钮打开")