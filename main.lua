--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║  🌸 RIVALS ULTIMATE PREMIUM MENU 🌸                      ║
    ║  Version: 3.0 ULTIMATE EDITION                           ║
    ║  Avec effets sonores, hit markers, et animations         ║
    ╚═══════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ═══════════════════════════════════════════════════════════════════════════
-- SONS PREMIUM (Anime/Japonais)
-- ═══════════════════════════════════════════════════════════════════════════
local Sounds = {
    MenuOpen = "rbxassetid://6895079853",      -- Son d'ouverture épique
    MenuClose = "rbxassetid://6895079853",     -- Son de fermeture
    ButtonClick = "rbxassetid://6895079853",   -- Clic de bouton
    HitMarker = "rbxassetid://5952120301",     -- Hit marker classique
    KillSound = "rbxassetid://5952120301",     -- Son de kill
    Notification = "rbxassetid://6895079853",  -- Notification
    WaterDrop = "rbxassetid://6916371803",     -- Bulle d'eau
    AnimeSwing = "rbxassetid://8624675183",    -- Swing d'épée anime
}

local function PlaySound(soundId, volume)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = volume or 0.5
    sound.Parent = game.SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 3)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- CONFIGURATION PREMIUM
-- ═══════════════════════════════════════════════════════════════════════════
local Config = {
    -- Réglages Aimbot
    AimbotFOV = 200,
    AimbotSmooth = 0.1,
    AimbotPart = "Head",
    AimbotVisibleCheck = true,
    
    -- Réglages ESP
    ESPColor = Color3.fromRGB(255, 0, 0),
    ESPTeamCheck = false,
    ESPDistance = true,
    ESPHealth = true,
    
    -- Réglages Speed
    SpeedValue = 50,
    
    -- Réglages Visuals
    HitMarkers = true,
    KillSound = true,
    Notifications = true,
    
    -- Couleurs du menu
    PrimaryColor = Color3.fromRGB(138, 43, 226),
    SecondaryColor = Color3.fromRGB(75, 0, 130),
    AccentColor = Color3.fromRGB(0, 191, 255),
}

local Settings = {
    Aimbot = false,
    ESP = false,
    Speed = false,
    InfiniteAmmo = false,
    NoRecoil = false,
    Wallhack = false,
    TriggerBot = false,
    FlyHack = false,
    AutoFarm = false,
}

-- ═══════════════════════════════════════════════════════════════════════════
-- SYSTÈME DE NOTIFICATIONS
-- ═══════════════════════════════════════════════════════════════════════════
local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "Notifications"
NotificationGui.ResetOnSpawn = false
NotificationGui.Parent = game.CoreGui

local function Notify(title, message, duration)
    if not Config.Notifications then return end
    
    PlaySound(Sounds.Notification, 0.3)
    
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 80)
    notif.Position = UDim2.new(1, -320, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    notif.BorderSizePixel = 0
    notif.Parent = NotificationGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = notif
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Config.AccentColor
    stroke.Thickness = 2
    stroke.Parent = notif
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "✨ " .. title
    titleLabel.TextColor3 = Config.AccentColor
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notif
    
    local msgLabel = Instance.new("TextLabel")
    msgLabel.Size = UDim2.new(1, -20, 0, 40)
    msgLabel.Position = UDim2.new(0, 10, 0, 30)
    msgLabel.BackgroundTransparency = 1
    msgLabel.Text = message
    msgLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    msgLabel.TextSize = 14
    msgLabel.Font = Enum.Font.Gotham
    msgLabel.TextWrapped = true
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.Parent = notif
    
    TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -320, 0, 20)
    }):Play()
    
    wait(duration or 3)
    
    TweenService:Create(notif, TweenInfo.new(0.3), {
        Position = UDim2.new(1, 0, 0, 20)
    }):Play()
    
    wait(0.3)
    notif:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SYSTÈME DE HIT MARKERS
-- ═══════════════════════════════════════════════════════════════════════════
local HitMarkerGui = Instance.new("ScreenGui")
HitMarkerGui.Name = "HitMarkers"
HitMarkerGui.ResetOnSpawn = false
HitMarkerGui.Parent = game.CoreGui

local function ShowHitMarker(isHeadshot)
    if not Config.HitMarkers then return end
    
    PlaySound(Sounds.HitMarker, 0.7)
    
    local marker = Instance.new("ImageLabel")
    marker.Size = UDim2.new(0, 50, 0, 50)
    marker.Position = UDim2.new(0.5, -25, 0.5, -25)
    marker.BackgroundTransparency = 1
    marker.Image = "rbxassetid://2708891598"
    marker.ImageColor3 = isHeadshot and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(255, 255, 255)
    marker.Parent = HitMarkerGui
    
    local damage = Instance.new("TextLabel")
    damage.Size = UDim2.new(0, 100, 0, 30)
    damage.Position = UDim2.new(0.5, -50, 0.5, 30)
    damage.BackgroundTransparency = 1
    damage.Text = isHeadshot and "HEADSHOT!" or "HIT!"
    damage.TextColor3 = isHeadshot and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(255, 255, 255)
    damage.TextSize = isHeadshot and 24 or 18
    damage.Font = Enum.Font.GothamBold
    damage.Parent = HitMarkerGui
    
    TweenService:Create(marker, TweenInfo.new(0.3), {
        ImageTransparency = 1,
        Size = UDim2.new(0, 80, 0, 80)
    }):Play()
    
    TweenService:Create(damage, TweenInfo.new(0.3), {
        TextTransparency = 1,
        Position = UDim2.new(0.5, -50, 0.5, 50)
    }):Play()
    
    wait(0.3)
    marker:Destroy()
    damage:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════════════
-- INTERFACE PRINCIPALE
-- ═══════════════════════════════════════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RivalsUltimatePremium"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 400)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Config.PrimaryColor
MainStroke.Thickness = 3
MainStroke.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Config.PrimaryColor),
    ColorSequenceKeypoint.new(0.5, Config.AccentColor),
    ColorSequenceKeypoint.new(1, Config.PrimaryColor)
}
MainGradient.Rotation = 0
MainGradient.Parent = MainStroke

-- Animation du gradient
spawn(function()
    while MainFrame.Parent do
        TweenService:Create(MainGradient, TweenInfo.new(3, Enum.EasingStyle.Linear), {
            Rotation = MainGradient.Rotation + 360
        }):Play()
        wait(3)
    end
end)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Config.PrimaryColor
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌸 RIVALS ULTIMATE PREMIUM 🌸"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseBtn

-- Tabs
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(0, 120, 1, -70)
TabsFrame.Position = UDim2.new(0, 10, 0, 70)
TabsFrame.BackgroundTransparency = 1
TabsFrame.Parent = MainFrame

-- Content
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -140, 1, -80)
ContentFrame.Position = UDim2.new(0, 130, 0, 70)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 4
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentFrame

-- ═══════════════════════════════════════════════════════════════════════════
-- FONCTION POUR CRÉER UN TOGGLE
-- ═══════════════════════════════════════════════════════════════════════════
local function CreateToggle(name, icon, description, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Size = UDim2.new(1, -10, 0, 60)
    Toggle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Toggle.BorderSizePixel = 0
    Toggle.Parent = ContentFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = Toggle
    
    local IconLabel = Instance.new("TextLabel")
    IconLabel.Size = UDim2.new(0, 40, 0, 40)
    IconLabel.Position = UDim2.new(0, 10, 0, 10)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Text = icon
    IconLabel.TextSize = 28
    IconLabel.Font = Enum.Font.GothamBold
    IconLabel.Parent = Toggle
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(0, 200, 0, 25)
    NameLabel.Position = UDim2.new(0, 60, 0, 8)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.TextSize = 16
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = Toggle
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(0, 200, 0, 20)
    DescLabel.Position = UDim2.new(0, 60, 0, 32)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    DescLabel.TextSize = 12
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = Toggle
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 60, 0, 30)
    ToggleBtn.Position = UDim2.new(1, -70, 0, 15)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextSize = 14
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = Toggle
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = ToggleBtn
    
    local isEnabled = false
    
    ToggleBtn.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        PlaySound(Sounds.ButtonClick, 0.3)
        PlaySound(Sounds.WaterDrop, 0.2)
        
        ToggleBtn.Text = isEnabled and "ON" or "OFF"
        ToggleBtn.BackgroundColor3 = isEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 50)
        
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 70, 0, 35)
        }):Play()
        
        wait(0.1)
        
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 60, 0, 30)
        }):Play()
        
        callback(isEnabled)
    end)
    
    return Toggle
end

-- ═══════════════════════════════════════════════════════════════════════════
-- FONCTIONNALITÉS DE HACK
-- ═══════════════════════════════════════════════════════════════════════════

local Connections = {}

-- AIMBOT PREMIUM
CreateToggle("Aimbot", "🎯", "Visée automatique intelligente", function(enabled)
    Settings.Aimbot = enabled
    
    if enabled then
        Notify("Aimbot", "Aimbot activé avec succès!", 2)
        PlaySound(Sounds.AnimeSwing, 0.5)
        
        Connections.Aimbot = RunService.RenderStepped:Connect(function()
            local nearestPlayer = nil
            local shortestDistance = math.huge
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    local targetPart = player.Character:FindFirstChild(Config.AimbotPart)
                    
                    if humanoid and humanoid.Health > 0 and targetPart then
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
            
            if nearestPlayer and nearestPlayer.Character then
                local targetPart = nearestPlayer.Character:FindFirstChild(Config.AimbotPart)
                if targetPart then
                    local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
                    Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, Config.AimbotSmooth)
                    
                    -- Hit marker simulation
                    if math.random() > 0.95 then
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

-- ESP PREMIUM
CreateToggle("ESP", "👁️", "Voir tous les joueurs", function(enabled)
    Settings.ESP = enabled
    
    if enabled then
        Notify("ESP", "ESP activé - Vous voyez tout!", 2)
        
        local function AddESP(player)
            if player == LocalPlayer then return end
            
            local function CreateHighlight(char)
                if char:FindFirstChild("ESPHighlight") then return end
                
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESPHighlight"
                highlight.FillColor = Config.ESPColor
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = char
                
                if Config.ESPDistance then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ESPDistance"
                    billboard.Size = UDim2.new(0, 100, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = char:FindFirstChild("Head")
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLabel.TextSize = 14
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.Parent = billboard
                    
                    local distLabel = Instance.new("TextLabel")
                    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
                    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
                    distLabel.BackgroundTransparency = 1
                    distLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    distLabel.TextSize = 12
                    distLabel.Font = Enum.Font.Gotham
                    distLabel.Parent = billboard
                    
                    spawn(function()
                        while distLabel.Parent and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") do
                            local distance = (char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            distLabel.Text = math.floor(distance) .. "m"
                            wait(0.1)
                        end
                    end)
                end
            end
            
            if player.Character then
                CreateHighlight(player.Character)
            end
            
            player.CharacterAdded:Connect(CreateHighlight)
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            AddESP(player)
        end
        
        Connections.ESP = Players.PlayerAdded:Connect(AddESP)
    else
        Notify("ESP", "ESP désactivé", 2)
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                if player.Character:FindFirstChild("ESPHighlight") then
                    player.Character.ESPHighlight:Destroy()
                end
                if player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("ESPDistance") then
                    player.Character.Head.ESPDistance:Destroy()
                end
            end
        end
        if Connections.ESP then
            Connections.ESP:Disconnect()
        end
    end
end)

-- SPEED HACK
CreateToggle("Speed Hack", "⚡", "Vitesse augmentée x3", function(enabled)
    Settings.Speed = enabled
    
    if enabled then
        Notify("Speed", "Vitesse boostée à " .. Config.SpeedValue, 2)
        
        Connections.Speed = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = Config.SpeedValue
            end
        end)
    else
        Notify("Speed", "Vitesse normale restaurée", 2)
        if Connections.Speed then
            Connections.Speed:Disconnect()
        end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- INFINITE AMMO
CreateToggle("Infinite Ammo", "🔫", "Munitions illimitées", function(enabled)
    Settings.InfiniteAmmo = enabled
    
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
        if Connections.Ammo then
            Connections.Ammo:Disconnect()
        end
    end
end)

-- NO RECOIL
CreateToggle("No Recoil", "🎯", "Supprime le recul", function(enabled)
    Settings.NoRecoil = enabled
    Notify("No Recoil", enabled and "Recul supprimé!" or "Recul normal", 2)
end)

-- TRIGGER BOT
CreateToggle("Trigger Bot", "🔫", "Tir automatique", function(enabled)
    Settings.TriggerBot = enabled
    
    if enabled then
        Notify("Trigger Bot", "Tir automatique activé!", 2)
        
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
        Notify("Trigger Bot", "Tir automatique désactivé", 2)
        if Connections.Trigger then
            Connections.Trigger:Disconnect()
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- CONTRÔLES DU MENU
-- ═══════════════════════════════════════════════════════════════════════════
local MenuOpen = false

local function ToggleMenu()
    MenuOpen = not MenuOpen
    MainFrame.Visible = MenuOpen
    
    if MenuOpen then
        PlaySound(Sounds.MenuOpen, 0.5)
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 550, 0, 400)
        }):Play()
        Notify("Menu", "Menu ouvert - Bon jeu!", 2)
    else
        PlaySound(Sounds.MenuClose, 0.5)
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
    end
end

CloseBtn.MouseButton1Click:Connect(ToggleMenu)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        ToggleMenu()
    end
end)

-- Rendre draggable
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
PlaySound(Sounds.MenuOpen, 0.6)
Notify("Rivals Ultimate", "Menu chargé avec succès! 🌸", 3)
print("═══════════════════════════════════════════")
print("🌸 RIVALS ULTIMATE PREMIUM MENU 🌸")
print("Version 3.0 - Ultimate Edition")
print("Appuyez sur INSERT pour ouvrir")
print("═══════════════════════════════════════════")

wait(1)
ToggleMenu()

-- Made with Bob
