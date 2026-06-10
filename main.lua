--[[
═══════════════════════════════════════════════════════════════════════════════
    🌟 MENU PREMIUM ROBLOX - ÉDITION ULTIME 🌟
    
    Créé par Bob - Expert en développement d'interfaces premium
    
    Fonctionnalités :
    ✨ Animation d'ouverture spectaculaire
    🌌 Fond Cosmos cinématique avec parallaxe
    🎨 Effets premium avancés (verre, halos, réfractions)
    🖱️ Curseur nouvelle génération avec particules
    📊 Dashboard interactif complet
    ⚡ Optimisé pour performances maximales
    🎮 Effet Ctrl pour masquer/afficher
    
    Version : 1.0.0 Ultimate Edition
═══════════════════════════════════════════════════════════════════════════════
--]]

-- ═══════════════════════════════════════════════════════════════════════════
-- SERVICES ROBLOX
-- ═══════════════════════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

print("🌟 Menu Premium Roblox - Initialisation...")

-- ═══════════════════════════════════════════════════════════════════════════
-- CONFIGURATION PREMIUM
-- ═══════════════════════════════════════════════════════════════════════════
local Config = {
    Colors = {
        Primary = Color3.fromRGB(138, 43, 226),
        Secondary = Color3.fromRGB(75, 0, 130),
        Accent = Color3.fromRGB(0, 191, 255),
        Background = Color3.fromRGB(10, 10, 20),
        Glass = Color3.fromRGB(20, 20, 40),
        White = Color3.fromRGB(255, 255, 255),
    },
    Animation = {
        OpeningDuration = 1.5,
        CtrlToggleDuration = 0.5,
    },
    Particles = {
        MaxStars = 200,
        MaxCursorParticles = 20,
    }
}

-- ═══════════════════════════════════════════════════════════════════════════
-- VARIABLES GLOBALES
-- ═══════════════════════════════════════════════════════════════════════════
local MenuVisible = false
local IsAnimating = false
local MousePosition = Vector2.new(0, 0)
local UI = {}

-- ═══════════════════════════════════════════════════════════════════════════
-- CRÉATION DE L'INTERFACE
-- ═══════════════════════════════════════════════════════════════════════════
local function CreateUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PremiumMenuGui"
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
    CosmosBackground.Name = "CosmosBackground"
    CosmosBackground.Size = UDim2.new(1, 0, 1, 0)
    CosmosBackground.BackgroundColor3 = Config.Colors.Background
    CosmosBackground.BorderSizePixel = 0
    CosmosBackground.Parent = MainContainer
    
    local StarsLayer = Instance.new("Frame")
    StarsLayer.Name = "StarsLayer"
    StarsLayer.Size = UDim2.new(1, 0, 1, 0)
    StarsLayer.BackgroundTransparency = 1
    StarsLayer.Parent = CosmosBackground
    
    local MenuFrame = Instance.new("Frame")
    MenuFrame.Name = "MenuFrame"
    MenuFrame.Size = UDim2.new(0, 900, 0, 600)
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
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 80)
    Header.BackgroundColor3 = Config.Colors.Primary
    Header.BackgroundTransparency = 0.2
    Header.BorderSizePixel = 0
    Header.Parent = MenuFrame
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 20)
    HeaderCorner.Parent = Header
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 400, 1, 0)
    Title.Position = UDim2.new(0, 30, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "✨ MENU PREMIUM ULTIMATE ✨"
    Title.TextColor3 = Config.Colors.White
    Title.TextSize = 28
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 50, 0, 50)
    CloseButton.Position = UDim2.new(1, -65, 0, 15)
    CloseButton.BackgroundColor3 = Config.Colors.Secondary
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Config.Colors.White
    CloseButton.TextSize = 24
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = Header
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 12)
    CloseCorner.Parent = CloseButton
    
    local ContentContainer = Instance.new("ScrollingFrame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -40, 1, -120)
    ContentContainer.Position = UDim2.new(0, 20, 0, 100)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.BorderSizePixel = 0
    ContentContainer.ScrollBarThickness = 6
    ContentContainer.Parent = MenuFrame
    
    local CardsLayout = Instance.new("UIGridLayout")
    CardsLayout.CellSize = UDim2.new(0, 200, 0, 150)
    CardsLayout.CellPadding = UDim2.new(0, 15, 0, 15)
    CardsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    CardsLayout.Parent = ContentContainer
    
    return {
        ScreenGui = ScreenGui,
        MainContainer = MainContainer,
        CosmosBackground = CosmosBackground,
        StarsLayer = StarsLayer,
        MenuFrame = MenuFrame,
        BorderGlow = BorderGlow,
        CloseButton = CloseButton,
        ContentContainer = ContentContainer
    }
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SYSTÈME D'ÉTOILES
-- ═══════════════════════════════════════════════════════════════════════════
local function CreateStars(layer, count)
    for i = 1, count do
        local star = Instance.new("Frame")
        local size = math.random(1, 3)
        star.Size = UDim2.new(0, size, 0, size)
        star.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
        star.BackgroundColor3 = Config.Colors.White
        star.BackgroundTransparency = math.random(30, 70) / 100
        star.BorderSizePixel = 0
        star.Parent = layer
        
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
-- CRÉATION DES CARTES
-- ═══════════════════════════════════════════════════════════════════════════
local function CreateCard(parent, title, icon, description, order)
    local Card = Instance.new("TextButton")
    Card.LayoutOrder = order
    Card.BackgroundColor3 = Config.Colors.Glass
    Card.BackgroundTransparency = 0.4
    Card.BorderSizePixel = 0
    Card.Text = ""
    Card.Parent = parent
    
    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 15)
    CardCorner.Parent = Card
    
    local CardStroke = Instance.new("UIStroke")
    CardStroke.Color = Config.Colors.Primary
    CardStroke.Thickness = 1
    CardStroke.Transparency = 0.7
    CardStroke.Parent = Card
    
    local IconLabel = Instance.new("TextLabel")
    IconLabel.Size = UDim2.new(1, 0, 0, 50)
    IconLabel.Position = UDim2.new(0, 0, 0, 20)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Text = icon
    IconLabel.TextColor3 = Config.Colors.Accent
    IconLabel.TextSize = 36
    IconLabel.Font = Enum.Font.GothamBold
    IconLabel.Parent = Card
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 0, 25)
    TitleLabel.Position = UDim2.new(0, 10, 0, 75)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Config.Colors.White
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = Card
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -20, 0, 30)
    DescLabel.Position = UDim2.new(0, 10, 0, 100)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Config.Colors.White
    DescLabel.TextSize = 11
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextWrapped = true
    DescLabel.TextTransparency = 0.3
    DescLabel.Parent = Card
    
    Card.MouseEnter:Connect(function()
        TweenService:Create(Card, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
        TweenService:Create(CardStroke, TweenInfo.new(0.3), {Thickness = 2, Transparency = 0.3}):Play()
    end)
    
    Card.MouseLeave:Connect(function()
        TweenService:Create(Card, TweenInfo.new(0.3), {BackgroundTransparency = 0.4}):Play()
        TweenService:Create(CardStroke, TweenInfo.new(0.3), {Thickness = 1, Transparency = 0.7}):Play()
    end)
    
    return Card
end

-- ═══════════════════════════════════════════════════════════════════════════
-- ANIMATION D'OUVERTURE
-- ═══════════════════════════════════════════════════════════════════════════
local function PlayOpeningAnimation()
    if IsAnimating then return end
    IsAnimating = true
    
    UI.MainContainer.Visible = true
    UI.MenuFrame.Size = UDim2.new(0, 0, 0, 0)
    UI.MenuFrame.BackgroundTransparency = 1
    
    local centerPoint = Instance.new("Frame")
    centerPoint.Size = UDim2.new(0, 10, 0, 10)
    centerPoint.Position = UDim2.new(0.5, 0, 0.5, 0)
    centerPoint.AnchorPoint = Vector2.new(0.5, 0.5)
    centerPoint.BackgroundColor3 = Config.Colors.Accent
    centerPoint.BorderSizePixel = 0
    centerPoint.Parent = UI.MainContainer
    
    local pointCorner = Instance.new("UICorner")
    pointCorner.CornerRadius = UDim.new(1, 0)
    pointCorner.Parent = centerPoint
    
    TweenService:Create(centerPoint, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 100, 0, 100),
        BackgroundTransparency = 0.5
    }):Play()
    
    wait(0.3)
    
    CreateStars(UI.StarsLayer, Config.Particles.MaxStars)
    
    TweenService:Create(UI.MenuFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 900, 0, 600),
        BackgroundTransparency = 0.3
    }):Play()
    
    TweenService:Create(centerPoint, TweenInfo.new(0.4), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 300, 0, 300)
    }):Play()
    
    wait(0.6)
    centerPoint:Destroy()
    
    local cards = UI.ContentContainer:GetChildren()
    for i, card in ipairs(cards) do
        if card:IsA("TextButton") then
            card.BackgroundTransparency = 1
            spawn(function()
                wait(i * 0.05)
                TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0.4
                }):Play()
            end)
        end
    end
    
    IsAnimating = false
    MenuVisible = true
    print("✨ Menu ouvert avec succès!")
end

-- ═══════════════════════════════════════════════════════════════════════════
-- ANIMATION DE FERMETURE
-- ═══════════════════════════════════════════════════════════════════════════
local function PlayClosingAnimation()
    if IsAnimating then return end
    IsAnimating = true
    
    for _, star in ipairs(UI.StarsLayer:GetChildren()) do
        TweenService:Create(star, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    
    TweenService:Create(UI.MenuFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }):Play()
    
    wait(0.5)
    
    UI.MainContainer.Visible = false
    
    for _, star in ipairs(UI.StarsLayer:GetChildren()) do
        star:Destroy()
    end
    
    IsAnimating = false
    MenuVisible = false
    print("🌙 Menu fermé")
end

-- ═══════════════════════════════════════════════════════════════════════════
-- INITIALISATION
-- ═══════════════════════════════════════════════════════════════════════════
UI = CreateUI()

CreateCard(UI.ContentContainer, "Joueur", "👤", "Gestion du joueur", 1)
CreateCard(UI.ContentContainer, "Combat", "⚔️", "Options de combat", 2)
CreateCard(UI.ContentContainer, "Téléport", "🌐", "Téléportation rapide", 3)
CreateCard(UI.ContentContainer, "Visuel", "🎨", "Effets visuels", 4)
CreateCard(UI.ContentContainer, "ESP", "👁️", "Vision avancée", 5)
CreateCard(UI.ContentContainer, "Vitesse", "⚡", "Boost de vitesse", 6)
CreateCard(UI.ContentContainer, "Vol", "🚀", "Mode vol", 7)
CreateCard(UI.ContentContainer, "Armes", "🔫", "Arsenal complet", 8)
CreateCard(UI.ContentContainer, "Items", "📦", "Inventaire", 9)
CreateCard(UI.ContentContainer, "Auto-Farm", "🌾", "Farming auto", 10)
CreateCard(UI.ContentContainer, "Paramètres", "⚙️", "Configuration", 11)
CreateCard(UI.ContentContainer, "Info", "ℹ️", "Informations", 12)

UI.CloseButton.MouseButton1Click:Connect(function()
    PlayClosingAnimation()
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
        if MenuVisible then
            PlayClosingAnimation()
        else
            PlayOpeningAnimation()
        end
    end
end)

RunService.RenderStepped:Connect(function()
    MousePosition = UserInputService:GetMouseLocation()
end)

print("🎮 Menu Premium Roblox chargé!")
print("💡 Appuyez sur CTRL pour ouvrir/fermer le menu")
print("✨ Profitez de l'expérience premium!")

PlayOpeningAnimation()

-- Made with Bob


-- ═══════════════════════════════════════════════════════════════════════════
-- SYSTÈME DE PARTICULES DU CURSEUR
-- ═══════════════════════════════════════════════════════════════════════════
local CursorParticles = {}
local CursorContainer = Instance.new("Frame")
CursorContainer.Name = "CursorContainer"
CursorContainer.Size = UDim2.new(1, 0, 1, 0)
CursorContainer.BackgroundTransparency = 1
CursorContainer.ZIndex = 100
CursorContainer.Parent = UI.ScreenGui

local function CreateCursorParticle()
    local particle = Instance.new("Frame")
    local size = math.random(2, 6)
    particle.Size = UDim2.new(0, size, 0, size)
    particle.Position = UDim2.new(0, MousePosition.X, 0, MousePosition.Y)
    particle.BackgroundColor3 = Config.Colors.White
    particle.BackgroundTransparency = 0.3
    particle.BorderSizePixel = 0
    particle.ZIndex = 101
    particle.Parent = CursorContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = particle
    
    local data = {
        particle = particle,
        velocity = Vector2.new(math.random(-20, 20), math.random(-20, 20)),
        lifetime = 1.2,
        age = 0
    }
    table.insert(CursorParticles, data)
end

local function UpdateCursorParticles(deltaTime)
    if not MenuVisible then return end
    
    if #CursorParticles < Config.Particles.MaxCursorParticles then
        if math.random() > 0.7 then
            CreateCursorParticle()
        end
    end
    
    for i = #CursorParticles, 1, -1 do
        local data = CursorParticles[i]
        data.age = data.age + deltaTime
        
        if data.age >= data.lifetime then
            data.particle:Destroy()
            table.remove(CursorParticles, i)
        else
            local progress = data.age / data.lifetime
            local currentPos = data.particle.Position
            local newX = currentPos.X.Offset + data.velocity.X * deltaTime
            local newY = currentPos.Y.Offset + data.velocity.Y * deltaTime
            
            data.particle.Position = UDim2.new(0, newX, 0, newY)
            data.particle.BackgroundTransparency = 0.3 + (progress * 0.7)
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SYSTÈME DE NÉBULEUSES
-- ═══════════════════════════════════════════════════════════════════════════
local function CreateNebulas()
    local colors = {
        Config.Colors.Primary,
        Config.Colors.Secondary,
        Color3.fromRGB(255, 20, 147),
        Config.Colors.Accent
    }
    
    for i = 1, 3 do
        local nebula = Instance.new("Frame")
        nebula.Name = "Nebula_" .. i
        nebula.Size = UDim2.new(0, math.random(400, 700), 0, math.random(400, 700))
        nebula.Position = UDim2.new(
            math.random(-10, 110) / 100,
            0,
            math.random(-10, 110) / 100,
            0
        )
        nebula.BackgroundColor3 = colors[math.random(1, #colors)]
        nebula.BackgroundTransparency = 0.85
        nebula.BorderSizePixel = 0
        nebula.Parent = UI.CosmosBackground
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = nebula
        
        local gradient = Instance.new("UIGradient")
        gradient.Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(1, 1)
        }
        gradient.Parent = nebula
        
        spawn(function()
            while nebula.Parent do
                TweenService:Create(gradient, TweenInfo.new(40, Enum.EasingStyle.Linear), {
                    Rotation = gradient.Rotation + 360
                }):Play()
                wait(40)
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- ÉTOILES FILANTES
-- ═══════════════════════════════════════════════════════════════════════════
local function CreateShootingStar()
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, 3, 0, 3)
    star.BackgroundColor3 = Config.Colors.White
    star.BorderSizePixel = 0
    
    local startX = math.random(0, 100) / 100
    local startY = math.random(0, 50) / 100
    star.Position = UDim2.new(startX, 0, startY, 0)
    star.Parent = UI.StarsLayer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = star
    
    local trail = Instance.new("Frame")
    trail.Size = UDim2.new(0, 60, 0, 2)
    trail.Position = UDim2.new(0, -60, 0.5, 0)
    trail.AnchorPoint = Vector2.new(0, 0.5)
    trail.BackgroundColor3 = Config.Colors.White
    trail.BorderSizePixel = 0
    trail.Parent = star
    
    local trailGradient = Instance.new("UIGradient")
    trailGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    }
    trailGradient.Rotation = 180
    trailGradient.Parent = trail
    
    local endX = startX + 0.3
    local endY = startY + 0.3
    local duration = 1.5
    
    TweenService:Create(star, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Position = UDim2.new(endX, 0, endY, 0)
    }):Play()
    
    TweenService:Create(star, TweenInfo.new(duration * 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play()
    
    wait(duration)
    star:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════════════
-- EFFET DE PARALLAXE
-- ═══════════════════════════════════════════════════════════════════════════
local ParallaxEnabled = false
local ScreenCenter = Vector2.new(0, 0)

local function UpdateParallax()
    if not MenuVisible or not ParallaxEnabled then return end
    
    local offset = (MousePosition - ScreenCenter) * 0.02
    
    TweenService:Create(UI.StarsLayer, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, offset.X, 0, offset.Y)
    }):Play()
end

-- ═══════════════════════════════════════════════════════════════════════════
-- ANIMATION DU GRADIENT DE BORDURE
-- ═══════════════════════════════════════════════════════════════════════════
local function AnimateBorderGradient()
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Config.Colors.Primary),
        ColorSequenceKeypoint.new(0.5, Config.Colors.Accent),
        ColorSequenceKeypoint.new(1, Config.Colors.Primary)
    }
    gradient.Rotation = 0
    gradient.Parent = UI.BorderGlow
    
    spawn(function()
        while UI.MenuFrame.Parent do
            TweenService:Create(gradient, TweenInfo.new(3, Enum.EasingStyle.Linear), {
                Rotation = gradient.Rotation + 360
            }):Play()
            wait(3)
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SYSTÈME D'ÉTOILES FILANTES AUTOMATIQUE
-- ═══════════════════════════════════════════════════════════════════════════
local function StartShootingStars()
    spawn(function()
        while true do
            if MenuVisible then
                CreateShootingStar()
            end
            wait(math.random(5, 10))
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- EFFET D'ONDE LUMINEUSE (RÉACTIVATION)
-- ═══════════════════════════════════════════════════════════════════════════
local function CreateLightWave()
    local wave = Instance.new("Frame")
    wave.Size = UDim2.new(0, 50, 0, 50)
    wave.Position = UDim2.new(0.5, 0, 0.5, 0)
    wave.AnchorPoint = Vector2.new(0.5, 0.5)
    wave.BackgroundTransparency = 1
    wave.BorderSizePixel = 0
    wave.Parent = UI.MainContainer
    
    local waveStroke = Instance.new("UIStroke")
    waveStroke.Color = Config.Colors.Accent
    waveStroke.Thickness = 3
    waveStroke.Transparency = 0
    waveStroke.Parent = wave
    
    local waveCorner = Instance.new("UICorner")
    waveCorner.CornerRadius = UDim.new(1, 0)
    waveCorner.Parent = wave
    
    TweenService:Create(wave, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 1000, 0, 1000)
    }):Play()
    
    TweenService:Create(waveStroke, TweenInfo.new(0.8), {
        Transparency = 1
    }):Play()
    
    wait(0.8)
    wave:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════════════
-- MISE À JOUR DE L'ANIMATION D'OUVERTURE AVEC ONDE
-- ═══════════════════════════════════════════════════════════════════════════
local originalPlayOpeningAnimation = PlayOpeningAnimation
PlayOpeningAnimation = function()
    if MenuVisible then
        CreateLightWave()
    end
    originalPlayOpeningAnimation()
    CreateNebulas()
    AnimateBorderGradient()
    ParallaxEnabled = true
    
    local screenSize = UI.ScreenGui.AbsoluteSize
    ScreenCenter = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- BOUCLE DE RENDU PRINCIPALE
-- ═══════════════════════════════════════════════════════════════════════════
local lastFrameTime = tick()
RunService.RenderStepped:Connect(function()
    local currentTime = tick()
    local deltaTime = currentTime - lastFrameTime
    lastFrameTime = currentTime
    
    MousePosition = UserInputService:GetMouseLocation()
    UpdateCursorParticles(deltaTime)
    UpdateParallax()
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- DÉMARRAGE DES SYSTÈMES AUTOMATIQUES
-- ═══════════════════════════════════════════════════════════════════════════
StartShootingStars()

print("🌠 Système de particules activé!")
print("🌌 Nébuleuses cosmiques créées!")
print("✨ Effets premium chargés!")
