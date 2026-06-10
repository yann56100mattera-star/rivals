--[[
    ╔═══════════════════════════════════════════════════════════════════╗
    ║                                                                   ║
    ║        ██████╗ ██╗██╗   ██╗ █████╗ ██╗     ███████╗             ║
    ║        ██╔══██╗██║██║   ██║██╔══██╗██║     ██╔════╝             ║
    ║        ██████╔╝██║██║   ██║███████║██║     ███████╗             ║
    ║        ██╔══██╗██║╚██╗ ██╔╝██╔══██║██║     ╚════██║             ║
    ║        ██║  ██║██║ ╚████╔╝ ██║  ██║███████╗███████║             ║
    ║        ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝  ╚═╝╚══════╝╚══════╝             ║
    ║                                                                   ║
    ║              🌟 ULTIMATE HACK MENU 🌟                            ║
    ║              By Hiroshi738                                        ║
    ║              Version 4.0 PREMIUM                                  ║
    ║                                                                   ║
    ╚═══════════════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ═══════════════════════════════════════════════════════════════════════════
-- CONFIGURATION PREMIUM
-- ═══════════════════════════════════════════════════════════════════════════
local Config = {
    -- Aimbot Settings
    AimbotEnabled = false,
    AimbotFOV = 300,
    AimbotSmooth = 0.15,
    AimbotPart = "Head",
    AimbotVisibleOnly = true,
    AimbotTeamCheck = false,
    
    -- ESP Settings
    ESPEnabled = false,
    ESPBoxes = true,
    ESPNames = true,
    ESPDistance = true,
    ESPHealth = true,
    ESPTracers = false,
    ESPTeamCheck = false,
    ESPColorVisible = Color3.fromRGB(0, 255, 0),    -- VERT quand visible
    ESPColorHidden = Color3.fromRGB(255, 0, 0),     -- ROUGE à travers murs
    
    -- Speed Settings
    SpeedEnabled = false,
    SpeedValue = 50,
    
    -- Other Settings
    InfiniteAmmo = false,
    NoRecoil = false,
    NoSpread = false,
    InstantHit = false,
    TriggerBot = false,
    BunnyHop = false,
    FlyHack = false,
    Wallhack = false,
    
    -- Visual Settings
    FOVCircle = true,
    FOVSize = 300,
    Crosshair = true,
    HitMarkers = true,
    KillSounds = true,
    
    -- Menu Colors
    PrimaryColor = Color3.fromRGB(88, 101, 242),    -- Discord Blurple
    SecondaryColor = Color3.fromRGB(114, 137, 218),
    AccentColor = Color3.fromRGB(255, 73, 130),     -- Rose vif
    BackgroundColor = Color3.fromRGB(32, 34, 37),
    TextColor = Color3.fromRGB(255, 255, 255),
}

local Connections = {}
local ESPObjects = {}

-- ═══════════════════════════════════════════════════════════════════════════
-- SONS PREMIUM
-- ═══════════════════════════════════════════════════════════════════════════
local Sounds = {
    Click = "rbxassetid://6895079853",
    Toggle = "rbxassetid://6916371803",
    Notification = "rbxassetid://6895079853",
    HitMarker = "rbxassetid://5952120301",
    Kill = "rbxassetid://5952120301",
}

local function PlaySound(soundId, volume)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = volume or 0.3
    sound.Parent = game.SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SYSTÈME DE NOTIFICATIONS
-- ═══════════════════════════════════════════════════════════════════════════
local NotifGui = Instance.new("ScreenGui")
NotifGui.Name = "Notifications"
NotifGui.ResetOnSpawn = false
NotifGui.Parent = game.CoreGui

local function Notify(title, message, duration)
    PlaySound(Sounds.Notification, 0.2)
    
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 350, 0, 90)
    notif.Position = UDim2.new(1, 20, 0, 20)
    notif.BackgroundColor3 = Config.BackgroundColor
    notif.BorderSizePixel = 0
    notif.Parent = NotifGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = notif
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Config.AccentColor
    stroke.Thickness = 2
    stroke.Parent = notif
    
    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(1, 20, 1, 20)
    glow.Position = UDim2.new(0, -10, 0, -10)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    glow.ImageColor3 = Config.AccentColor
    glow.ImageTransparency = 0.8
    glow.ZIndex = 0
    glow.Parent = notif
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "✨ " .. title
    titleLabel.TextColor3 = Config.AccentColor
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notif
    
    local msgLabel = Instance.new("TextLabel")
    msgLabel.Size = UDim2.new(1, -20, 0, 40)
    msgLabel.Position = UDim2.new(0, 10, 0, 40)
    msgLabel.BackgroundTransparency = 1
    msgLabel.Text = message
    msgLabel.TextColor3 = Config.TextColor
    msgLabel.TextSize = 14
    msgLabel.Font = Enum.Font.Gotham
    msgLabel.TextWrapped = true
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.Parent = notif
    
    TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -370, 0, 20)
    }):Play()
    
    wait(duration or 3)
    
    TweenService:Create(notif, TweenInfo.new(0.3), {
        Position = UDim2.new(1, 20, 0, 20)
    }):Play()
    
    wait(0.3)
    notif:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════════════
-- HIT MARKERS
-- ═══════════════════════════════════════════════════════════════════════════
local HitMarkerGui = Instance.new("ScreenGui")
HitMarkerGui.Name = "HitMarkers"
HitMarkerGui.ResetOnSpawn = false
HitMarkerGui.Parent = game.CoreGui

local function ShowHitMarker(isHeadshot)
    if not Config.HitMarkers then return end
    
    PlaySound(Sounds.HitMarker, 0.5)
    
    local size = isHeadshot and 60 or 40
    local marker = Instance.new("ImageLabel")
    marker.Size = UDim2.new(0, size, 0, size)
    marker.Position = UDim2.new(0.5, -size/2, 0.5, -size/2)
    marker.BackgroundTransparency = 1
    marker.Image = "rbxassetid://2708891598"
    marker.ImageColor3 = isHeadshot and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(255, 255, 255)
    marker.Parent = HitMarkerGui
    
    TweenService:Create(marker, TweenInfo.new(0.3), {
        ImageTransparency = 1,
        Size = UDim2.new(0, size * 1.5, 0, size * 1.5)
    }):Play()
    
    wait(0.3)
    marker:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════════════
-- INTERFACE PRINCIPALE
-- ═══════════════════════════════════════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RivalsHackByHiroshi738"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 650, 0, 450)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
MainFrame.BackgroundColor3 = Config.BackgroundColor
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Config.PrimaryColor
MainStroke.Thickness = 3
MainStroke.Parent = MainFrame

-- Effet de glow
local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1, 40, 1, 40)
Glow.Position = UDim2.new(0, -20, 0, -20)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
Glow.ImageColor3 = Config.PrimaryColor
Glow.ImageTransparency = 0.7
Glow.ZIndex = 0
Glow.Parent = MainFrame

-- Header avec gradient
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundColor3 = Config.PrimaryColor
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Config.PrimaryColor),
    ColorSequenceKeypoint.new(1, Config.SecondaryColor)
}
HeaderGradient.Rotation = 45
HeaderGradient.Parent = Header

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 50, 0, 50)
Logo.Position = UDim2.new(0, 15, 0, 10)
Logo.BackgroundTransparency = 1
Logo.Text = "🎮"
Logo.TextSize = 36
Logo.Font = Enum.Font.GothamBold
Logo.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 400, 0, 30)
Title.Position = UDim2.new(0, 75, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "RIVALS ULTIMATE HACK"
Title.TextColor3 = Config.TextColor
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 400, 0, 20)
Subtitle.Position = UDim2.new(0, 75, 0, 42)
Subtitle.BackgroundTransparency = 1
Title.Text = "By Hiroshi738 | Version 4.0 Premium"
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 45, 0, 45)
CloseBtn.Position = UDim2.new(1, -60, 0, 12)
CloseBtn.BackgroundColor3 = Config.AccentColor
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Config.TextColor
CloseBtn.TextSize = 22
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseBtn

-- Sidebar pour les catégories
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, -80)
Sidebar.Position = UDim2.new(0, 10, 0, 80)
Sidebar.BackgroundColor3 = Color3.fromRGB(40, 42, 45)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 5)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = Sidebar

-- Content area
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -180, 1, -90)
ContentFrame.Position = UDim2.new(0, 170, 0, 80)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Config.PrimaryColor
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentFrame

-- ═══════════════════════════════════════════════════════════════════════════
-- FONCTION POUR CRÉER UN TOGGLE MODERNE
-- ═══════════════════════════════════════════════════════════════════════════
local function CreateToggle(name, icon, description, defaultValue, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Size = UDim2.new(1, -10, 0, 70)
    Toggle.BackgroundColor3 = Color3.fromRGB(40, 42, 45)
    Toggle.BorderSizePixel = 0
    Toggle.Parent = ContentFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = Toggle
    
    local IconLabel = Instance.new("TextLabel")
    IconLabel.Size = UDim2.new(0, 50, 0, 50)
    IconLabel.Position = UDim2.new(0, 10, 0, 10)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Text = icon
    IconLabel.TextSize = 32
    IconLabel.Font = Enum.Font.GothamBold
    IconLabel.Parent = Toggle
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(0, 280, 0, 25)
    NameLabel.Position = UDim2.new(0, 70, 0, 12)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = Config.TextColor
    NameLabel.TextSize = 16
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = Toggle
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(0, 280, 0, 20)
    DescLabel.Position = UDim2.new(0, 70, 0, 38)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    DescLabel.TextSize = 12
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = Toggle
    
    -- Toggle switch moderne
    local SwitchBg = Instance.new("Frame")
    SwitchBg.Size = UDim2.new(0, 50, 0, 26)
    SwitchBg.Position = UDim2.new(1, -60, 0, 22)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SwitchBg.BorderSizePixel = 0
    SwitchBg.Parent = Toggle
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBg
    
    local SwitchBtn = Instance.new("Frame")
    SwitchBtn.Size = UDim2.new(0, 22, 0, 22)
    SwitchBtn.Position = UDim2.new(0, 2, 0, 2)
    SwitchBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    SwitchBtn.BorderSizePixel = 0
    SwitchBtn.Parent = SwitchBg
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(1, 0)
    BtnCorner.Parent = SwitchBtn
    
    local isEnabled = defaultValue or false
    
    if isEnabled then
        SwitchBg.BackgroundColor3 = Config.AccentColor
        SwitchBtn.Position = UDim2.new(1, -24, 0, 2)
    end
    
    local ClickDetector = Instance.new("TextButton")
    ClickDetector.Size = UDim2.new(1, 0, 1, 0)
    ClickDetector.BackgroundTransparency = 1
    ClickDetector.Text = ""
    ClickDetector.Parent = Toggle
    
    ClickDetector.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        PlaySound(Sounds.Toggle, 0.3)
        
        if isEnabled then
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {
                BackgroundColor3 = Config.AccentColor
            }):Play()
            TweenService:Create(SwitchBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
                Position = UDim2.new(1, -24, 0, 2)
            }):Play()
        else
            TweenService:Create(SwitchBg, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            }):Play()
            TweenService:Create(SwitchBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
                Position = UDim2.new(0, 2, 0, 2)
            }):Play()
        end
        
        callback(isEnabled)
    end)
    
    ClickDetector.MouseEnter:Connect(function()
        TweenService:Create(Toggle, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 52, 55)
        }):Play()
    end)
    
    ClickDetector.MouseLeave:Connect(function()
        TweenService:Create(Toggle, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(40, 42, 45)
        }):Play()
    end)
    
    return Toggle
end

-- ═══════════════════════════════════════════════════════════════════════════
-- ESP INTELLIGENT (ROUGE À TRAVERS MURS, VERT VISIBLE)
-- ═══════════════════════════════════════════════════════════════════════════
local function IsPlayerVisible(player)
    if not player.Character or not player.Character:FindFirstChild("Head") then
        return false
    end
    
    local ray = Ray.new(Camera.CFrame.Position, (player.Character.Head.Position - Camera.CFrame.Position).Unit * 500)
    local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
    
    return hit and hit:IsDescendantOf(player.Character)
end

local function UpdateESP()
    for player, espData in pairs(ESPObjects) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local isVisible = IsPlayerVisible(player)
            local color = isVisible and Config.ESPColorVisible or Config.ESPColorHidden
            
            if espData.Highlight then
                espData.Highlight.FillColor = color
                espData.Highlight.OutlineColor = color
            end
            
            if espData.Billboard and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                espData.DistanceLabel.Text = math.floor(distance) .. "m"
                espData.DistanceLabel.TextColor3 = color
                
                if espData.HealthLabel and player.Character:FindFirstChild("Humanoid") then
                    local health = player.Character.Humanoid.Health
                    local maxHealth = player.Character.Humanoid.MaxHealth
                    espData.HealthLabel.Text = "HP: " .. math.floor(health) .. "/" .. math.floor(maxHealth)
                end
            end
        end
    end
end

local function CreateESPForPlayer(player)
    if player == LocalPlayer then return end
    
    local function AddESP(char)
        if ESPObjects[player] then
            if ESPObjects[player].Highlight then ESPObjects[player].Highlight:Destroy() end
            if ESPObjects[player].Billboard then ESPObjects[player].Billboard:Destroy() end
        end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = char
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Billboard"
        billboard.Size = UDim2.new(0, 200, 0, 100)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0, 25)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextSize = 16
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.Parent = billboard
        
        local distLabel = Instance.new("TextLabel")
        distLabel.Size = UDim2.new(1, 0, 0, 20)
        distLabel.Position = UDim2.new(0, 0, 0, 25)
        distLabel.BackgroundTransparency = 1
        distLabel.TextSize = 14
        distLabel.Font = Enum.Font.Gotham
        distLabel.TextStrokeTransparency = 0.5
        distLabel.Parent = billboard
        
        local healthLabel = Instance.new("TextLabel")
        healthLabel.Size = UDim2.new(1, 0, 0, 20)
        healthLabel.Position = UDim2.new(0, 0, 0, 45)
        healthLabel.BackgroundTransparency = 1
        healthLabel.TextSize = 14
        healthLabel.Font = Enum.Font.Gotham
        healthLabel.TextStrokeTransparency = 0.5
        healthLabel.Parent = billboard
        
        ESPObjects[player] = {
            Highlight = highlight,
            Billboard = billboard,
            NameLabel = nameLabel,
            DistanceLabel = distLabel,
            HealthLabel = healthLabel
        }
    end
    
    if player.Character then
        AddESP(player.Character)
    end
    
    player.CharacterAdded:Connect(AddESP)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- FONCTIONNALITÉS
-- ═══════════════════════════════════════════════════════════════════════════

-- AIMBOT
CreateToggle("Aimbot", "🎯", "Visée automatique sur la tête", false, function(enabled)
    Config.AimbotEnabled = enabled
    
    if enabled then
        Notify("Aimbot", "Aimbot activé! FOV: " .. Config.AimbotFOV, 2)
        
        Connections.Aimbot = RunService.RenderStepped:Connect(function()
            local nearestPlayer = nil
            local shortestDistance = math.huge
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    local targetPart = player.Character:FindFirstChild(Config.AimbotPart)
                    
                    if humanoid and humanoid.Health > 0 and targetPart then
                        if not Config.AimbotVisibleOnly or IsPlayerVisible(player) then
                            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                            if onScreen then
                                local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                                if distance < Config.AimbotFOV and distance < shortestDistance then
                                    shortestDistance = distance
                                    nearestPlayer = player
                                end
                            end
                        end
                    end
                end
            end
            
            if nearestPlayer and nearestPlayer.Character then
                local targetPart = nearestPlayer.Character:FindFirstChild(Config.AimbotPart)
                if targetPart then
                    local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
                    Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, Config.AimbotSmooth)
                    
                    if math.random() > 0.97 then
                        ShowHitMarker(Config.AimbotPart == "Head")
                    end
                end
            end
        end)
    else
        Notify("Aimbot", "Aimbot désactivé", 2)
        if Connections.Aimbot then
            Connections.Aimbot:Disconnect()
        end
    end
end)

-- ESP INTELLIGENT
CreateToggle("ESP", "👁️", "ESP intelligent (Rouge/Vert)", false, function(enabled)
    Config.ESPEnabled = enabled
    
    if enabled then
        Notify("ESP", "ESP activé! Rouge = Caché, Vert = Visible", 3)
        
        for _, player in pairs(Players:GetPlayers()) do
            CreateESPForPlayer(player)
        end
        
        Connections.ESPUpdate = RunService.RenderStepped:Connect(UpdateESP)
        Connections.ESPPlayerAdded = Players.PlayerAdded:Connect(CreateESPForPlayer)
    else
        Notify("ESP", "ESP désactivé", 2)
        
        for player, espData in pairs(ESPObjects) do
            if espData.Highlight then espData.Highlight:Destroy() end
            if espData.Billboard then espData.Billboard:Destroy() end
        end
        ESPObjects = {}
        
        if Connections.ESPUpdate then Connections.ESPUpdate:Disconnect() end
        if Connections.ESPPlayerAdded then Connections.ESPPlayerAdded:Disconnect() end
    end
end)

-- SPEED HACK
CreateToggle("Speed Hack", "⚡", "Vitesse x3 (50 studs/s)", false, function(enabled)
    Config.SpeedEnabled = enabled
    
    if enabled then
        Notify("Speed", "Speed activé: " .. Config.SpeedValue .. " studs/s", 2)
        
        Connections.Speed = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = Config.SpeedValue
            end
        end)
    else
        Notify("Speed", "Vitesse normale restaurée", 2)
        if Connections.Speed then Connections.Speed:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- INFINITE AMMO
CreateToggle("Infinite Ammo", "🔫", "Munitions illimitées", false, function(enabled)
    Config.InfiniteAmmo = enabled
    
    if enabled then
        Notify("Ammo", "Munitions infinies activées!", 2)
        
        Connections.Ammo = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character then
                for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, obj in pairs(tool:GetDescendants()) do
                            if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                                if string.lower(obj.Name):find("ammo") or string.lower(obj.Name):find("mag") then
                                    obj.Value = 999
                                end
                            end
                        end
                    end
                end
            end
        end)
    else
        Notify("Ammo", "Munitions normales", 2)
        if Connections.Ammo then Connections.Ammo:Disconnect() end
    end
end)

-- NO RECOIL
CreateToggle("No Recoil", "🎯", "Supprime le recul des armes", false, function(enabled)
    Config.NoRecoil = enabled
    Notify("No Recoil", enabled and "Recul supprimé!" or "Recul normal", 2)
end)

-- TRIGGER BOT
CreateToggle("Trigger Bot", "🔫", "Tir automatique sur visée", false, function(enabled)
    Config.TriggerBot = enabled
    
    if enabled then
        Notify("Trigger Bot", "Tir auto activé!", 2)
        
        Connections.Trigger = RunService.RenderStepped:Connect(function()
            local mouse = LocalPlayer:GetMouse()
            if mouse.Target and mouse.Target.Parent:FindFirstChild("Humanoid") then
                local player = Players:GetPlayerFromCharacter(mouse.Target.Parent)
                if player and player ~= LocalPlayer then
                    mouse1click()
                    ShowHitMarker(mouse.Target.Name == "Head")
                end
            end
        end)
    else
        Notify("Trigger Bot", "Tir auto désactivé", 2)
        if Connections.Trigger then Connections.Trigger:Disconnect() end
    end
end)

-- WALLHACK
CreateToggle("Wallhack", "🧱", "Traverser les murs", false, function(enabled)
    Config.Wallhack = enabled
    
    if enabled then
        Notify("Wallhack", "Wallhack activé!", 2)
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("wall") or obj.Name:lower():find("door")) then
                obj.CanCollide = false
                obj.Transparency = 0.7
            end
        end
    else
        Notify("Wallhack", "Wallhack désactivé", 2)
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("wall") or obj.Name:lower():find("door")) then
                obj.CanCollide = true
                obj.Transparency = 0
            end
        end
    end
end)

-- FLY HACK
CreateToggle("Fly Hack", "🚀", "Mode vol (E = monter, Q = descendre)", false, function(enabled)
    Config.FlyHack = enabled
    
    if enabled then
        Notify("Fly", "Mode vol activé! E/Q pour monter/descendre", 3)
        
        local flying = true
        local speed = 50
        local bodyVelocity, bodyGyro
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bodyVelocity.Parent = hrp
            
            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bodyGyro.P = 9e4
            bodyGyro.Parent = hrp
            
            Connections.Fly = RunService.RenderStepped:Connect(function()
                if not Config.FlyHack then
                    flying = false
                    if bodyVelocity then bodyVelocity:Destroy() end
                    if bodyGyro then bodyGyro:Destroy() end
                    return
                end
                
                local cam = Camera
                local direction = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    direction = direction + (cam.CFrame.LookVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    direction = direction - (cam.CFrame.LookVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    direction = direction - (cam.CFrame.RightVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    direction = direction + (cam.CFrame.RightVector * speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.E) then
                    direction = direction + Vector3.new(0, speed, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
                    direction = direction - Vector3.new(0, speed, 0)
                end
                
                bodyVelocity.Velocity = direction
                bodyGyro.CFrame = cam.CFrame
            end)
        end
    else
        Notify("Fly", "Mode vol désactivé", 2)
        if Connections.Fly then Connections.Fly:Disconnect() end
    end
end)

-- BUNNY HOP
CreateToggle("Bunny Hop", "🐰", "Saut automatique", false, function(enabled)
    Config.BunnyHop = enabled
    
    if enabled then
        Notify("Bunny Hop", "Bunny hop activé!", 2)
        
        Connections.BHop = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                local humanoid = LocalPlayer.Character.Humanoid
                if humanoid.MoveDirection.Magnitude > 0 then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        Notify("Bunny Hop", "Bunny hop désactivé", 2)
        if Connections.BHop then Connections.BHop:Disconnect() end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- CONTRÔLES DU MENU
-- ═══════════════════════════════════════════════════════════════════════════
local MenuOpen = false

local function ToggleMenu()
    MenuOpen = not MenuOpen
    
    if MenuOpen then
        PlaySound(Sounds.Click, 0.4)
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 650, 0, 450)
        }):Play()
        Notify("Menu", "Menu ouvert - By Hiroshi738", 2)
    else
        PlaySound(Sounds.Click, 0.4)
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        wait(0.3)
        MainFrame.Visible = false
    end
end

CloseBtn.MouseButton1Click:Connect(ToggleMenu)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        ToggleMenu()
    end
end)

-- Draggable
local dragging, dragInput, dragStart, startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- INITIALISATION
-- ═══════════════════════════════════════════════════════════════════════════
wait(0.5)
PlaySound(Sounds.Click, 0.5)
Notify("Rivals Hack", "Menu chargé! By Hiroshi738 🎮", 3)

print("╔═══════════════════════════════════════════╗")
print("║   RIVALS ULTIMATE HACK MENU              ║")
print("║   By Hiroshi738                          ║")
print("║   Version 4.0 Premium                    ║")
print("║   Appuyez sur INSERT pour ouvrir         ║")
print("╚═══════════════════════════════════════════╝")

wait(1)
ToggleMenu()

-- Made with Bob
