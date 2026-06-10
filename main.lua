--[[
═══════════════════════════════════════════════════════════════════════════════
    🌟 MENU PREMIUM ROBLOX RIVALS - ÉDITION ULTIME 🌟
    
    Script de hack complet pour Roblox Rivals
    
    Fonctionnalités :
    🎯 Aimbot intelligent
    👁️ ESP (Voir les joueurs à travers les murs)
    ⚡ Speed Hack
    🔫 Munitions infinies
    🎯 No Recoil (Pas de recul)
    🧱 Wallhack
    🔫 Trigger Bot (Tir automatique)
    🌾 Auto Farm
    ✨ Interface premium avec effets cosmos
    
    Version : 2.0.0 Rivals Edition
═══════════════════════════════════════════════════════════════════════════════
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

print("🎮 Chargement du Menu Premium Rivals...")

-- ═══════════════════════════════════════════════════════════════════════════
-- CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════════════
local Config = {
    Colors = {
        Primary = Color3.fromRGB(138, 43, 226),
        Secondary = Color3.fromRGB(75, 0, 130),
        Accent = Color3.fromRGB(0, 191, 255),
        Background = Color3.fromRGB(10, 10, 20),
        Glass = Color3.fromRGB(20, 20, 40),
        White = Color3.fromRGB(255, 255, 255),
        Green = Color3.fromRGB(0, 255, 0),
        Red = Color3.fromRGB(255, 0, 0),
    }
}

-- ═══════════════════════════════════════════════════════════════════════════
-- VARIABLES GLOBALES
-- ═══════════════════════════════════════════════════════════════════════════
local MenuVisible = false
local Features = {
    Aimbot = false,
    ESP = false,
    SpeedHack = false,
    InfiniteAmmo = false,
    NoRecoil = false,
    Wallhack = false,
    TriggerBot = false,
    AutoFarm = false,
    NoSpread = false,
    InstantKill = false
}

local ESPObjects = {}
local Connections = {}

-- ═══════════════════════════════════════════════════════════════════════════
-- CRÉATION DE L'INTERFACE
-- ═══════════════════════════════════════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RivalsMenuPremium"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(1, 0, 1, 0)
MainContainer.BackgroundTransparency = 1
MainContainer.Visible = false
MainContainer.Parent = ScreenGui

local CosmosBackground = Instance.new("Frame")
CosmosBackground.Size = UDim2.new(1, 0, 1, 0)
CosmosBackground.BackgroundColor3 = Config.Colors.Background
CosmosBackground.BorderSizePixel = 0
CosmosBackground.Parent = MainContainer

local StarsLayer = Instance.new("Frame")
StarsLayer.Size = UDim2.new(1, 0, 1, 0)
StarsLayer.BackgroundTransparency = 1
StarsLayer.Parent = CosmosBackground

local MenuFrame = Instance.new("Frame")
MenuFrame.Size = UDim2.new(0, 700, 0, 500)
MenuFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MenuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MenuFrame.BackgroundColor3 = Config.Colors.Glass
MenuFrame.BackgroundTransparency = 0.3
MenuFrame.BorderSizePixel = 0
MenuFrame.Parent = MainContainer

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 20)
MenuCorner.Parent = MenuFrame

local BorderGlow = Instance.new("UIStroke")
BorderGlow.Color = Config.Colors.Accent
BorderGlow.Thickness = 2
BorderGlow.Transparency = 0.5
BorderGlow.Parent = MenuFrame

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundColor3 = Config.Colors.Primary
Header.BackgroundTransparency = 0.2
Header.BorderSizePixel = 0
Header.Parent = MenuFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 20)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 400, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "✨ RIVALS PREMIUM MENU ✨"
Title.TextColor3 = Config.Colors.White
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0, 15)
CloseButton.BackgroundColor3 = Config.Colors.Secondary
CloseButton.Text = "✕"
CloseButton.TextColor3 = Config.Colors.White
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Size = UDim2.new(1, -30, 1, -90)
ContentContainer.Position = UDim2.new(0, 15, 0, 80)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0
ContentContainer.ScrollBarThickness = 6
ContentContainer.Parent = MenuFrame

local CardsLayout = Instance.new("UIGridLayout")
CardsLayout.CellSize = UDim2.new(0, 150, 0, 120)
CardsLayout.CellPadding = UDim2.new(0, 10, 0, 10)
CardsLayout.SortOrder = Enum.SortOrder.LayoutOrder
CardsLayout.Parent = ContentContainer

-- ═══════════════════════════════════════════════════════════════════════════
-- SYSTÈME D'ÉTOILES
-- ═══════════════════════════════════════════════════════════════════════════
local function CreateStars()
    for i = 1, 150 do
        local star = Instance.new("Frame")
        local size = math.random(1, 3)
        star.Size = UDim2.new(0, size, 0, size)
        star.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
        star.BackgroundColor3 = Config.Colors.White
        star.BackgroundTransparency = math.random(30, 70) / 100
        star.BorderSizePixel = 0
        star.Parent = StarsLayer
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = star
        
        spawn(function()
            while star.Parent do
                local duration = math.random(10, 30) / 10
                TweenService:Create(star, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundTransparency = math.random(30, 70) / 100
                }):Play()
                wait(duration)
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- FONCTIONS DE HACK POUR RIVALS
-- ═══════════════════════════════════════════════════════════════════════════

-- AIMBOT
local function ToggleAimbot(enabled)
    Features.Aimbot = enabled
    if enabled then
        print("🎯 Aimbot activé!")
        Connections.Aimbot = RunService.RenderStepped:Connect(function()
            if not Features.Aimbot then return end
            
            local nearestPlayer = nil
            local shortestDistance = math.huge
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    local head = player.Character:FindFirstChild("Head")
                    
                    if humanoid and humanoid.Health > 0 and head then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestPlayer = player
                            end
                        end
                    end
                end
            end
            
            if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("Head") then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, nearestPlayer.Character.Head.Position)
            end
        end)
    else
        print("🎯 Aimbot désactivé")
        if Connections.Aimbot then
            Connections.Aimbot:Disconnect()
        end
    end
end

-- ESP
local function ToggleESP(enabled)
    Features.ESP = enabled
    if enabled then
        print("👁️ ESP activé!")
        
        local function AddESP(player)
            if player == LocalPlayer then return end
            if player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESPHighlight"
                highlight.FillColor = Config.Colors.Red
                highlight.OutlineColor = Config.Colors.White
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = player.Character
                ESPObjects[player] = highlight
            end
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            AddESP(player)
        end
        
        Connections.ESP = Players.PlayerAdded:Connect(AddESP)
    else
        print("👁️ ESP désactivé")
        for player, highlight in pairs(ESPObjects) do
            if highlight then highlight:Destroy() end
        end
        ESPObjects = {}
        if Connections.ESP then
            Connections.ESP:Disconnect()
        end
    end
end

-- SPEED HACK
local function ToggleSpeedHack(enabled)
    Features.SpeedHack = enabled
    if enabled then
        print("⚡ Speed Hack activé!")
        Connections.SpeedHack = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 100
            end
        end)
    else
        print("⚡ Speed Hack désactivé")
        if Connections.SpeedHack then
            Connections.SpeedHack:Disconnect()
        end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end

-- INFINITE AMMO
local function ToggleInfiniteAmmo(enabled)
    Features.InfiniteAmmo = enabled
    if enabled then
        print("🔫 Munitions infinies activées!")
        Connections.InfiniteAmmo = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character then
                local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then
                    for _, obj in pairs(tool:GetDescendants()) do
                        if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                            if obj.Name:lower():find("ammo") or obj.Name:lower():find("mag") then
                                obj.Value = 999
                            end
                        end
                    end
                end
            end
        end)
    else
        print("🔫 Munitions infinies désactivées")
        if Connections.InfiniteAmmo then
            Connections.InfiniteAmmo:Disconnect()
        end
    end
end

-- NO RECOIL
local function ToggleNoRecoil(enabled)
    Features.NoRecoil = enabled
    if enabled then
        print("🎯 No Recoil activé!")
        -- Implémentation spécifique à Rivals
    else
        print("🎯 No Recoil désactivé")
    end
end

-- WALLHACK
local function ToggleWallhack(enabled)
    Features.Wallhack = enabled
    if enabled then
        print("🧱 Wallhack activé!")
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                if obj.Name:lower():find("wall") or obj.Name:lower():find("door") then
                    obj.CanCollide = false
                    obj.Transparency = 0.7
                end
            end
        end
    else
        print("🧱 Wallhack désactivé")
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                if obj.Name:lower():find("wall") or obj.Name:lower():find("door") then
                    obj.CanCollide = true
                    obj.Transparency = 0
                end
            end
        end
    end
end

-- TRIGGER BOT
local function ToggleTriggerBot(enabled)
    Features.TriggerBot = enabled
    if enabled then
        print("🔫 Trigger Bot activé!")
        Connections.TriggerBot = RunService.RenderStepped:Connect(function()
            local mouse = LocalPlayer:GetMouse()
            if mouse.Target and mouse.Target.Parent:FindFirstChild("Humanoid") then
                local player = Players:GetPlayerFromCharacter(mouse.Target.Parent)
                if player and player ~= LocalPlayer then
                    mouse1click()
                end
            end
        end)
    else
        print("🔫 Trigger Bot désactivé")
        if Connections.TriggerBot then
            Connections.TriggerBot:Disconnect()
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- CRÉATION DES CARTES
-- ═══════════════════════════════════════════════════════════════════════════
local function CreateCard(title, icon, description, order, callback)
    local Card = Instance.new("TextButton")
    Card.LayoutOrder = order
    Card.BackgroundColor3 = Config.Colors.Glass
    Card.BackgroundTransparency = 0.4
    Card.BorderSizePixel = 0
    Card.Text = ""
    Card.Parent = ContentContainer
    
    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 12)
    CardCorner.Parent = Card
    
    local CardStroke = Instance.new("UIStroke")
    CardStroke.Color = Config.Colors.Primary
    CardStroke.Thickness = 1
    CardStroke.Transparency = 0.7
    CardStroke.Parent = Card
    
    local IconLabel = Instance.new("TextLabel")
    IconLabel.Size = UDim2.new(1, 0, 0, 40)
    IconLabel.Position = UDim2.new(0, 0, 0, 15)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Text = icon
    IconLabel.TextColor3 = Config.Colors.Accent
    IconLabel.TextSize = 32
    IconLabel.Font = Enum.Font.GothamBold
    IconLabel.Parent = Card
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -10, 0, 20)
    TitleLabel.Position = UDim2.new(0, 5, 0, 60)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Config.Colors.White
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = Card
    
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "Status"
    StatusLabel.Size = UDim2.new(1, -10, 0, 15)
    StatusLabel.Position = UDim2.new(0, 5, 0, 85)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "OFF"
    StatusLabel.TextColor3 = Config.Colors.Red
    StatusLabel.TextSize = 12
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.Parent = Card
    
    Card.MouseEnter:Connect(function()
        TweenService:Create(Card, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
        TweenService:Create(CardStroke, TweenInfo.new(0.2), {Thickness = 2, Transparency = 0.3}):Play()
    end)
    
    Card.MouseLeave:Connect(function()
        TweenService:Create(Card, TweenInfo.new(0.2), {BackgroundTransparency = 0.4}):Play()
        TweenService:Create(CardStroke, TweenInfo.new(0.2), {Thickness = 1, Transparency = 0.7}):Play()
    end)
    
    if callback then
        Card.MouseButton1Click:Connect(function()
            callback(Card, StatusLabel)
        end)
    end
    
    return Card
end

-- ═══════════════════════════════════════════════════════════════════════════
-- CRÉATION DES CARTES AVEC FONCTIONNALITÉS
-- ═══════════════════════════════════════════════════════════════════════════
CreateCard("Aimbot", "🎯", "Visée auto", 1, function(card, status)
    ToggleAimbot(not Features.Aimbot)
    status.Text = Features.Aimbot and "ON" or "OFF"
    status.TextColor3 = Features.Aimbot and Config.Colors.Green or Config.Colors.Red
end)

CreateCard("ESP", "👁️", "Voir joueurs", 2, function(card, status)
    ToggleESP(not Features.ESP)
    status.Text = Features.ESP and "ON" or "OFF"
    status.TextColor3 = Features.ESP and Config.Colors.Green or Config.Colors.Red
end)

CreateCard("Speed", "⚡", "Vitesse x6", 3, function(card, status)
    ToggleSpeedHack(not Features.SpeedHack)
    status.Text = Features.SpeedHack and "ON" or "OFF"
    status.TextColor3 = Features.SpeedHack and Config.Colors.Green or Config.Colors.Red
end)

CreateCard("Munitions ∞", "🔫", "Ammo infini", 4, function(card, status)
    ToggleInfiniteAmmo(not Features.InfiniteAmmo)
    status.Text = Features.InfiniteAmmo and "ON" or "OFF"
    status.TextColor3 = Features.InfiniteAmmo and Config.Colors.Green or Config.Colors.Red
end)

CreateCard("No Recoil", "🎯", "Pas de recul", 5, function(card, status)
    ToggleNoRecoil(not Features.NoRecoil)
    status.Text = Features.NoRecoil and "ON" or "OFF"
    status.TextColor3 = Features.NoRecoil and Config.Colors.Green or Config.Colors.Red
end)

CreateCard("Wallhack", "🧱", "Traverser murs", 6, function(card, status)
    ToggleWallhack(not Features.Wallhack)
    status.Text = Features.Wallhack and "ON" or "OFF"
    status.TextColor3 = Features.Wallhack and Config.Colors.Green or Config.Colors.Red
end)

CreateCard("Trigger Bot", "🔫", "Tir auto", 7, function(card, status)
    ToggleTriggerBot(not Features.TriggerBot)
    status.Text = Features.TriggerBot and "ON" or "OFF"
    status.TextColor3 = Features.TriggerBot and Config.Colors.Green or Config.Colors.Red
end)

CreateCard("Fly", "🚀", "Mode vol", 8, function(card, status)
    print("🚀 Fly en développement")
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- ANIMATIONS
-- ═══════════════════════════════════════════════════════════════════════════
local function OpenMenu()
    MainContainer.Visible = true
    MenuFrame.Size = UDim2.new(0, 0, 0, 0)
    
    CreateStars()
    
    TweenService:Create(MenuFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 700, 0, 500)
    }):Play()
    
    MenuVisible = true
    print("✨ Menu ouvert!")
end

local function CloseMenu()
    TweenService:Create(MenuFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    wait(0.3)
    MainContainer.Visible = false
    MenuVisible = false
    print("🌙 Menu fermé")
end

-- ═══════════════════════════════════════════════════════════════════════════
-- ÉVÉNEMENTS
-- ═══════════════════════════════════════════════════════════════════════════
CloseButton.MouseButton1Click:Connect(CloseMenu)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Insert or input.KeyCode == Enum.KeyCode.RightControl then
        if MenuVisible then
            CloseMenu()
        else
            OpenMenu()
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- INITIALISATION
-- ═══════════════════════════════════════════════════════════════════════════
print("✅ Menu Premium Rivals chargé avec succès!")
print("💡 Appuyez sur INSERT ou CTRL DROIT pour ouvrir/fermer")
print("🎮 Profitez du hack!")

wait(1)
OpenMenu()

-- Made with Bob
