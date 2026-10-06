--[[
    ██████╗ ██╗   ██╗██████╗ ██████╗  ██████╗ ███╗   ██╗
    ██╔════╝ ██║   ██║██╔══██╗██╔══██╗██╔═══██╗████╗  ██║
    ██║  ███╗██║   ██║██████╔╝██████╔╝██║   ██║██╔██╗ ██║
    ██║   ██║██║   ██║██╔═══╝ ██╔══██╗██║   ██║██║╚██╗██║
    ╚██████╔╝╚██████╔╝██║     ██║  ██║╚██████╔╝██║ ╚████║
     ╚═════╝  ╚═════╝ ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
     
    SOUTH BRONX DELTA SCRIPT
    Credit: gupron.exe
    Version: 2.0
    Toggle Key: H
--]]

local gupron = {
    Version = "2.0",
    Creator = "gupron.exe",
    Game = "South Bronx"
}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Settings
local Settings = {
    Aimbot = {
        Enabled = false,
        Key = "Q",
        Smoothness = 0.15,
        FOV = 150,
        TargetPart = "Head",
        TeamCheck = true,
        VisibilityCheck = true,
        WallCheck = false
    },
    Recoil = {
        Enabled = false,
        Reduction = 0.95,
        AntiShake = true,
        ShakeReduction = 0.8
    },
    ESP = {
        Enabled = false,
        Boxes = true,
        Names = true,
        Health = true,
        Distance = true,
        Tracers = false,
        Skeleton = false,
        TeamCheck = true,
        MaxDistance = 2000,
        BoxColor = Color3.fromRGB(255, 0, 0),
        TeamColor = Color3.fromRGB(0, 255, 0),
        EnemyColor = Color3.fromRGB(255, 0, 0)
    },
    Misc = {
        NoClip = false,
        SpeedHack = false,
        SpeedValue = 50,
        InfiniteJump = false
    }
}

-- UI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "gupron.exe"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 500, 0, 350)
Main.Position = UDim2.new(0.5, -250, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

-- Corner
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = Main

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Name = "Title"
TitleText.Size = UDim2.new(1, -100, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "gupron.exe | South Bronx"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 14
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(0, 100, 1, 0)
Credit.Position = UDim2.new(1, -100, 0, 0)
Credit.BackgroundTransparency = 1
Credit.Text = "v2.0 | Press H"
Credit.TextColor3 = Color3.fromRGB(100, 100, 100)
Credit.TextSize = 12
Credit.Font = Enum.Font.Gotham
Credit.TextXAlignment = Enum.TextXAlignment.Right
Credit.Parent = TitleBar

-- Tab Buttons
local TabHolder = Instance.new("Frame")
TabHolder.Name = "Tabs"
TabHolder.Size = UDim2.new(0, 120, 1, -35)
TabHolder.Position = UDim2.new(0, 0, 0, 35)
TabHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TabHolder.BorderSizePixel = 0
TabHolder.Parent = Main

local TabCorner2 = Instance.new("UICorner")
TabCorner2.CornerRadius = UDim.new(0, 8)
TabCorner2.Parent = TabHolder

-- Content Area
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -120, 1, -35)
Content.Position = UDim2.new(0, 120, 0, 35)
Content.BackgroundTransparency = 1
Content.Parent = Main

-- Function to Create Toggle
local function CreateToggle(parent, name, setting, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Name = name
    Toggle.Size = UDim2.new(1, -20, 0, 40)
    Toggle.Position = UDim2.new(0, 10, 0, (#parent:GetChildren() - 1) * 45)
    Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Toggle.BorderSizePixel = 0
    Toggle.Parent = parent
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = Toggle
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Toggle
    
    local Button = Instance.new("TextButton")
    Button.Name = "ToggleBtn"
    Button.Size = UDim2.new(0, 40, 0, 20)
    Button.Position = UDim2.new(1, -50, 0.5, -10)
    Button.BackgroundColor3 = setting and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.Parent = Toggle
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = Button
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = setting and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.BorderSizePixel = 0
    Circle.Parent = Button
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(0.5, 0)
    CircleCorner.Parent = Circle
    
    local toggled = setting
    
    Button.MouseButton1Click:Connect(function()
        toggled = not toggled
        local targetPos = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local targetColor = toggled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)
        
        TweenService:Create(Circle, TweenInfo.new(0.2), {Position = targetPos}):Play()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        
        if callback then
            callback(toggled)
        end
    end)
    
    return Toggle
end

-- Function to Create Slider
local function CreateSlider(parent, name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = name
    SliderFrame.Size = UDim2.new(1, -20, 0, 50)
    SliderFrame.Position = UDim2.new(0, 10, 0, (#parent:GetChildren() - 1) * 55)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 6)
    SliderCorner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 12
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local SliderBG = Instance.new("Frame")
    SliderBG.Name = "Background"
    SliderBG.Size = UDim2.new(1, -20, 0, 6)
    SliderBG.Position = UDim2.new(0, 10, 0, 32)
    SliderBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderBG.BorderSizePixel = 0
    SliderBG.Parent = SliderFrame
    
    local SliderBGCorner = Instance.new("UICorner")
    SliderBGCorner.CornerRadius = UDim.new(0, 3)
    SliderBGCorner.Parent = SliderBG
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "Fill"
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBG
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(0, 3)
    SliderFillCorner.Parent = SliderFill
    
    local SliderKnob = Instance.new("TextButton")
    SliderKnob.Name = "Knob"
    SliderKnob.Size = UDim2.new(0, 14, 0, 14)
    SliderKnob.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
    SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderKnob.BorderSizePixel = 0
    SliderKnob.Text = ""
    SliderKnob.Parent = SliderBG
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(0.5, 0)
    KnobCorner.Parent = SliderKnob
    
    local dragging = false
    
    SliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local sliderPos = SliderBG.AbsolutePosition.X
            local sliderSize = SliderBG.AbsoluteSize.X
            local percent = math.clamp((mousePos.X - sliderPos) / sliderSize, 0, 1)
            local value = math.floor(min + (max - min) * percent)
            
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            SliderKnob.Position = UDim2.new(percent, -7, 0.5, -7)
            Label.Text = name .. ": " .. value
            
            if callback then
                callback(value)
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return SliderFrame
end

-- Create Tabs
local Tabs = {"Aimbot", "ESP", "Recoil", "Misc"}
local TabContents = {}

for i, tabName in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tabName .. "Tab"
    TabBtn.Size = UDim2.new(1, -10, 0, 35)
    TabBtn.Position = UDim2.new(0, 5, 0, (i-1) * 40 + 10)
    TabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(35, 35, 35)
    TabBtn.BorderSizePixel = 0
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.TextSize = 13
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.Parent = TabHolder
    
    local TabBtnCorner = Instance.new("UICorner")
    TabBtnCorner.CornerRadius = UDim.new(0, 6)
    TabBtnCorner.Parent = TabBtn
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Name = tabName .. "Content"
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.ScrollBarThickness = 4
    TabContent.Visible = i == 1
    TabContent.Parent = Content
    
    local UIList = Instance.new("UIListLayout")
    UIList.Padding = UDim.new(0, 10)
    UIList.Parent = TabContent
    
    TabContents[tabName] = TabContent
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, content in pairs(TabContents) do
            content.Visible = false
        end
        for _, btn in pairs(TabHolder:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            end
        end
        TabContent.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    end)
end

-- AIMBOT TAB
CreateToggle(TabContents["Aimbot"], "Enable Aimbot", Settings.Aimbot.Enabled, function(val)
    Settings.Aimbot.Enabled = val
end)

CreateToggle(TabContents["Aimbot"], "Team Check", Settings.Aimbot.TeamCheck, function(val)
    Settings.Aimbot.TeamCheck = val
end)

CreateToggle(TabContents["Aimbot"], "Wall Check", Settings.Aimbot.WallCheck, function(val)
    Settings.Aimbot.WallCheck = val
end)

CreateSlider(TabContents["Aimbot"], "Smoothness", 1, 100, 15, function(val)
    Settings.Aimbot.Smoothness = val / 100
end)

CreateSlider(TabContents["Aimbot"], "FOV", 50, 500, 150, function(val)
    Settings.Aimbot.FOV = val
end)

-- ESP TAB
CreateToggle(TabContents["ESP"], "Enable ESP", Settings.ESP.Enabled, function(val)
    Settings.ESP.Enabled = val
end)

CreateToggle(TabContents["ESP"], "Boxes", Settings.ESP.Boxes, function(val)
    Settings.ESP.Boxes = val
end)

CreateToggle(TabContents["ESP"], "Names", Settings.ESP.Names, function(val)
    Settings.ESP.Names = val
end)

CreateToggle(TabContents["ESP"], "Health", Settings.ESP.Health, function(val)
    Settings.ESP.Health = val
end)

CreateToggle(TabContents["ESP"], "Distance", Settings.ESP.Distance, function(val)
    Settings.ESP.Distance = val
end)

CreateToggle(TabContents["ESP"], "Tracers", Settings.ESP.Tracers, function(val)
    Settings.ESP.Tracers = val
end)

CreateToggle(TabContents["ESP"], "Team Check", Settings.ESP.TeamCheck, function(val)
    Settings.ESP.TeamCheck = val
end)

-- RECOIL TAB
CreateToggle(TabContents["Recoil"], "Anti Recoil", Settings.Recoil.Enabled, function(val)
    Settings.Recoil.Enabled = val
end)

CreateToggle(TabContents["Recoil"], "Anti Shake", Settings.Recoil.AntiShake, function(val)
    Settings.Recoil.AntiShake = val
end)

CreateSlider(TabContents["Recoil"], "Recoil Reduction", 50, 100, 95, function(val)
    Settings.Recoil.Reduction = val / 100
end)

CreateSlider(TabContents["Recoil"], "Shake Reduction", 50, 100, 80, function(val)
    Settings.Recoil.ShakeReduction = val / 100
end)

-- MISC TAB
CreateToggle(TabContents["Misc"], "Speed Hack", Settings.Misc.SpeedHack, function(val)
    Settings.Misc.SpeedHack = val
end)

CreateSlider(TabContents["Misc"], "Speed Value", 16, 200, 50, function(val)
    Settings.Misc.SpeedValue = val
end)

CreateToggle(TabContents["Misc"], "Infinite Jump", Settings.Misc.InfiniteJump, function(val)
    Settings.Misc.InfiniteJump = val
end)

-- FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(0, 170, 255)
FOVCircle.Transparency = 0.5
FOVCircle.Filled = false

-- ESP Drawing Objects
local ESPObjects = {}

-- Get Closest Player
local function GetClosestPlayer()
    local closest = nil
    local shortestDistance = Settings.Aimbot.FOV
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(Settings.Aimbot.TargetPart) then
            if Settings.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end
            
            local targetPart = player.Character[Settings.Aimbot.TargetPart]
            local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
            
            if onScreen then
                local distance = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if distance < shortestDistance then
                    if Settings.Aimbot.WallCheck then
                        local ray = Ray.new(Camera.CFrame.Position, (targetPart.Position - Camera.CFrame.Position).Unit)
                        local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
                        if hit and hit:IsDescendantOf(player.Character) then
                            closest = player
                            shortestDistance = distance
                        end
                    else
                        closest = player
                        shortestDistance = distance
                    end
                end
            end
        end
    end
    
    return closest
end

-- Aimbot Loop
RunService.RenderStepped:Connect(function()
    -- Update FOV Circle
    FOVCircle.Visible = Settings.Aimbot.Enabled
    FOVCircle.Radius = Settings.Aimbot.FOV
    FOVCircle.Position = UserInputService:GetMouseLocation()
    
    -- Aimbot
    if Settings.Aimbot.Enabled then
        if UserInputService:IsKeyDown(Enum.KeyCode[Settings.Aimbot.Key]) or Settings.Aimbot.Key == "MouseButton2" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            local target = GetClosestPlayer()
            if target and target.Character and target.Character:FindFirstChild(Settings.Aimbot.TargetPart) then
                local targetPos = target.Character[Settings.Aimbot.TargetPart].Position
                local screenPos = Camera:WorldToViewportPoint(targetPos)
                local mousePos = UserInputService:GetMouseLocation()
                local moveVec = Vector2.new(screenPos.X - mousePos.X, screenPos.Y - mousePos.Y)
                
                mousemoverel(moveVec.X * Settings.Aimbot.Smoothness, moveVec.Y * Settings.Aimbot.Smoothness)
            end
        end
    end
    
    -- Speed Hack
    if Settings.Misc.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Settings.Misc.SpeedValue
    end
end)

-- ESP System
local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local esp = {
        Box = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        Health = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        Tracer = Drawing.new("Line")
    }
    
    esp.Box.Visible = false
    esp.Box.Color = Settings.ESP.EnemyColor
    esp.Box.Thickness = 1
    esp.Box.Filled = false
    
    esp.Name.Visible = false
    esp.Name.Color = Color3.new(1, 1, 1)
    esp.Name.Size = 14
    esp.Name.Center = true
    esp.Name.Outline = true
    
    esp.Health.Visible = false
    esp.Health.Color = Color3.new(0, 1, 0)
    esp.Health.Size = 12
    esp.Health.Center = true
    esp.Health.Outline = true
    
    esp.Distance.Visible = false
    esp.Distance.Color = Color3.new(1, 1, 0)
    esp.Distance.Size = 12
    esp.Distance.Center = true
    esp.Distance.Outline = true
    
    esp.Tracer.Visible = false
    esp.Tracer.Color = Settings.ESP.EnemyColor
    esp.Tracer.Thickness = 1
    
    ESPObjects[player] = esp
end

local function UpdateESP()
    for player, esp in pairs(ESPObjects) do
        if not Settings.ESP.Enabled or not player.Character or not player.Parent then
            for _, obj in pairs(esp) do
                obj.Visible = false
            end
            continue
        end
        
        local character = player.Character
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChild("Humanoid")
        
        if not hrp or not head or not humanoid then
            for _, obj in pairs(esp) do
                obj.Visible = false
            end
            continue
        end
        
        if Settings.ESP.TeamCheck and player.Team == LocalPlayer.Team then
            for _, obj in pairs(esp) do
                obj.Visible = false
            end
            continue
        end
        
        local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude or 0)
        
        if onScreen and distance <= Settings.ESP.MaxDistance then
            local size = (Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)).Y - Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 2, 0)).Y) / 2
            local width = size * 0.6
            
            -- Box ESP
            if Settings.ESP.Boxes then
                esp.Box.Size = Vector2.new(width * 2, size * 2)
                esp.Box.Position = Vector2.new(pos.X - width, pos.Y - size)
                esp.Box.Color = player.Team == LocalPlayer.Team and Settings.ESP.TeamColor or Settings.ESP.EnemyColor
                esp.Box.Visible = true
            else
                esp.Box.Visible = false
            end
            
            -- Name ESP
            if Settings.ESP.Names then
                esp.Name.Text = player.Name
                esp.Name.Position = Vector2.new(pos.X, pos.Y - size - 15)
                esp.Name.Visible = true
            else
                esp.Name.Visible = false
            end
            
            -- Health ESP
            if Settings.ESP.Health then
                esp.Health.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
                esp.Health.Position = Vector2.new(pos.X, pos.Y + size + 5)
                esp.Health.Color = Color3.fromRGB(255 - (humanoid.Health/humanoid.MaxHealth) * 255, (humanoid.Health/humanoid.MaxHealth) * 255, 0)
                esp.Health.Visible = true
            else
                esp.Health.Visible = false
            end
            
            -- Distance ESP
            if Settings.ESP.Distance then
                esp.Distance.Text = math.floor(distance) .. "m"
                esp.Distance.Position = Vector2.new(pos.X, pos.Y + size + 18)
                esp.Distance.Visible = true
            else
                esp.Distance.Visible = false
            end
            
            -- Tracers
            if Settings.ESP.Tracers then
                esp.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                esp.Tracer.To = Vector2.new(pos.X, pos.Y)
                esp.Tracer.Color = player.Team == LocalPlayer.Team and Settings.ESP.TeamColor or Settings.ESP.EnemyColor
                esp.Tracer.Visible = true
            else
                esp.Tracer.Visible = false
            end
        else
            for _, obj in pairs(esp) do
                obj.Visible = false
            end
        end
    end
end

-- Initialize ESP for existing players
for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end

Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        for _, obj in pairs(ESPObjects[player]) do
            obj:Remove()
        end
        ESPObjects[player] = nil
    end
end)

RunService.RenderStepped:Connect(UpdateESP)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if Settings.Misc.InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Drag UI
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Notification
local function Notify(text)
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(0, 250, 0, 40)
    Notif.Position = UDim2.new(1, -260, 1, -50)
    Notif.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Notif.BorderSizePixel = 0
    Notif.Parent = ScreenGui
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 6)
    NotifCorner.Parent = Notif
    
    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -10, 1, 0)
    NotifText.Position = UDim2.new(0, 5, 0, 0)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = text
    NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotifText.TextSize = 12
    NotifText.Font = Enum.Font.Gotham
    NotifText.Parent = Notif
    
    TweenService:Create(Notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -260, 1, -60)}):Play()
    
    task.delay(3, function()
        TweenService:Create(Notif, TweenInfo.new(0.5), {Position = UDim2.new(1, 10, 1, -50)}):Play()
        task.delay(0.5, function()
            Notif:Destroy()
        end)
    end)
end

-- Keybind to Toggle UI (CHANGED TO H)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.H then
        Main.Visible = not Main.Visible
    end
end)

Notify("gupron.exe loaded! | Press H to toggle menu")

print([[
    ╔══════════════════════════════════════════╗
    ║         gupron.exe Loaded                ║
    ║    South Bronx Script v2.0              ║
    ║    Toggle Key: H                         ║
    ╚══════════════════════════════════════════╝
]])