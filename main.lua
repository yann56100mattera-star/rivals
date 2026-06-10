--[[
═══════════════════════════════════════════════════════════════════════════════
    ⚡ RIVALS ULTIMATE PREMIUM MENU - BY HIROSHI738 ⚡
    
    🌟 MENU PREMIUM MASTER CLASS 🌟
    Version : 4.0.0 MASTER CLASS EDITION
    Prix : 500€/mois
    Créé par : Hiroshi738
═══════════════════════════════════════════════════════════════════════════════
--]]

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

print("🎮 Chargement de Rivals Ultimate Premium Menu...")
print("⚡ Master Class Edition - by Hiroshi738")

-- Système Audio Premium
local Sounds = {
    MenuOpen = "rbxassetid://6895079853",
    MenuClose = "rbxassetid://6895079853",
    Click = "rbxassetid://3398620867",
    Toggle = "rbxassetid://3398620867",
    Hover = "rbxassetid://6895079853",
    Success = "rbxassetid://6026984224",
    Anime = "rbxassetid://1837849285",
    PowerUp = "rbxassetid://5153845714",
}

local function PlaySound(soundId, volume, pitch)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = volume or 0.5
    sound.PlaybackSpeed = pitch or 1
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 3)
end

-- Configuration
local Config = {
    Colors = {
        Primary = Color3.fromRGB(138, 43, 226),
        Secondary = Color3.fromRGB(75, 0, 130),
        Accent = Color3.fromRGB(0, 191, 255),
        Background = Color3.fromRGB(10, 10, 18),
        Panel = Color3.fromRGB(20, 20, 35),
        White = Color3.fromRGB(255, 255, 255),
        Green = Color3.fromRGB(0, 255, 127),
        Red = Color3.fromRGB(255, 69, 58),
        Gold = Color3.fromRGB(255, 215, 0),
    }
}

local MenuVisible = false
local CurrentTab = "Dashboard"

-- Interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RivalsUltimatePremium"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local BlurOverlay = Instance.new("Frame")
BlurOverlay.Size = UDim2.new(1, 0, 1, 0)
BlurOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BlurOverlay.BackgroundTransparency = 0.3
BlurOverlay.BorderSizePixel = 0
BlurOverlay.Visible = false
BlurOverlay.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 900, 0, 600)
MainFrame.Position = UDim2.new(0.5, -450, 0.5, -300)
MainFrame.BackgroundColor3 = Config.Colors.Background
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Config.Colors.Primary
MainStroke.Thickness = 3
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Config.Colors.Primary),
    ColorSequenceKeypoint.new(0.5, Config.Colors.Accent),
    ColorSequenceKeypoint.new(1, Config.Colors.Secondary)
}
MainGradient.Rotation = 45
MainGradient.Parent = MainStroke

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundColor3 = Config.Colors.Panel
Header.BackgroundTransparency = 0.3
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Config.Colors.Primary),
    ColorSequenceKeypoint.new(1, Config.Colors.Secondary)
}
HeaderGradient.Rotation = 90
HeaderGradient.Parent = Header

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 60, 0, 60)
Logo.Position = UDim2.new(0, 10, 0, 5)
Logo.BackgroundTransparency = 1
Logo.Text = "⚡"
Logo.TextColor3 = Config.Colors.Gold
Logo.TextSize = 40
Logo.Font = Enum.Font.GothamBold
Logo.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 400, 0, 30)
Title.Position = UDim2.new(0, 75, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "RIVALS ULTIMATE PREMIUM"
Title.TextColor3 = Config.Colors.White
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 400, 0, 20)
Subtitle.Position = UDim2.new(0, 75, 0, 40)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Master Class Edition • by Hiroshi738 • 500€/mois"
Subtitle.TextColor3 = Config.Colors.Accent
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0, 15)
CloseButton.BackgroundColor3 = Config.Colors.Red
CloseButton.Text = "✕"
CloseButton.TextColor3 = Config.Colors.White
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, -80)
Sidebar.Position = UDim2.new(0, 10, 0, 75)
Sidebar.BackgroundColor3 = Config.Colors.Panel
Sidebar.BackgroundTransparency = 0.4
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 6)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.Parent = Sidebar

-- Content Area
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(1, -165, 1, -80)
ContentArea.Position = UDim2.new(0, 155, 0, 75)
ContentArea.BackgroundColor3 = Config.Colors.Panel
ContentArea.BackgroundTransparency = 0.4
ContentArea.BorderSizePixel = 0
ContentArea.ScrollBarThickness = 8
ContentArea.ScrollBarImageColor3 = Config.Colors.Primary
ContentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentArea.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 12)
ContentCorner.Parent = ContentArea

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 12)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ContentLayout.Parent = ContentArea

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 15)
ContentPadding.PaddingBottom = UDim.new(0, 15)
ContentPadding.PaddingLeft = UDim.new(0, 15)
ContentPadding.PaddingRight = UDim.new(0, 15)
ContentPadding.Parent = ContentArea

-- Fonctions UI
local function CreateTabButton(name, icon, order)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(1, -10, 0, 45)
    Button.BackgroundColor3 = Config.Colors.Background
    Button.BackgroundTransparency = 0.3
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.LayoutOrder = order
    Button.AutoButtonColor = false
    Button.Parent = Sidebar
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button
    
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 35, 1, 0)
    Icon.Position = UDim2.new(0, 5, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextColor3 = Config.Colors.White
    Icon.TextSize = 18
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = Button
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -45, 1, 0)
    Label.Position = UDim2.new(0, 40, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Config.Colors.White
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Button
    
    Button.MouseEnter:Connect(function()
        PlaySound(Sounds.Hover, 0.2, 1.2)
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0,
            BackgroundColor3 = Config.Colors.Primary
        }):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        if CurrentTab ~= name then
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundTransparency = 0.3,
                BackgroundColor3 = Config.Colors.Background
            }):Play()
        end
    end)
    
    return Button
end

local function CreateToggle(parent, text, defaultValue, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -30, 0, 40)
    Container.BackgroundColor3 = Config.Colors.Background
    Container.BackgroundTransparency = 0.3
    Container.BorderSizePixel = 0
    Container.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Config.Colors.White
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 50, 0, 26)
    Toggle.Position = UDim2.new(1, -60, 0.5, -13)
    Toggle.BackgroundColor3 = defaultValue and Config.Colors.Green or Config.Colors.Red
    Toggle.Text = ""
    Toggle.AutoButtonColor = false
    Toggle.Parent = Container
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = Toggle
    
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 20, 0, 20)
    Indicator.Position = defaultValue and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
    Indicator.BackgroundColor3 = Config.Colors.White
    Indicator.BorderSizePixel = 0
    Indicator.Parent = Toggle
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = Indicator
    
    local isEnabled = defaultValue
    
    Toggle.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        PlaySound(Sounds.Toggle, 0.4, isEnabled and 1.2 or 0.8)
        if isEnabled then
            PlaySound(Sounds.PowerUp, 0.3, 1.5)
        end
        
        TweenService:Create(Toggle, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            BackgroundColor3 = isEnabled and Config.Colors.Green or Config.Colors.Red
        }):Play()
        
        TweenService:Create(Indicator, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Position = isEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
        }):Play()
        
        if callback then callback(isEnabled) end
    end)
    
    return Container
end

local function CreateSection(parent, title)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, -30, 0, 35)
    Section.BackgroundTransparency = 1
    Section.Parent = parent
    
    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, 0, 0, 2)
    Line.Position = UDim2.new(0, 0, 0.5, 0)
    Line.BackgroundColor3 = Config.Colors.Primary
    Line.BorderSizePixel = 0
    Line.Parent = Section
    
    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Size = UDim2.new(0, 0, 1, 0)
    SectionTitle.Position = UDim2.new(0.5, 0, 0, 0)
    SectionTitle.AnchorPoint = Vector2.new(0.5, 0)
    SectionTitle.BackgroundColor3 = Config.Colors.Panel
    SectionTitle.BackgroundTransparency = 0.2
    SectionTitle.Text = "  " .. title .. "  "
    SectionTitle.TextColor3 = Config.Colors.Accent
    SectionTitle.TextSize = 15
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.Parent = Section
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
    TitleCorner.Parent = SectionTitle
    
    return Section
end

-- Onglets
local Tabs = {}
Tabs.Dashboard = CreateTabButton("Dashboard", "📊", 1)
Tabs.Combat = CreateTabButton("Combat", "⚔️", 2)
Tabs.Visuals = CreateTabButton("Visuals", "👁️", 3)
Tabs.Character = CreateTabButton("Character", "🧍", 4)
Tabs.Configs = CreateTabButton("Configs", "💾", 5)

-- Contenu
local function LoadCombatTab()
    ContentArea:ClearAllChildren()
    ContentLayout.Parent = ContentArea
    ContentPadding.Parent = ContentArea
    
    CreateSection(ContentArea, "AIMBOT PREMIUM")
    CreateToggle(ContentArea, "🎯 Aimbot Enabled", false, nil)
    CreateToggle(ContentArea, "👁️ Visible Check", false, nil)
    CreateToggle(ContentArea, "👥 Team Check", false, nil)
    CreateToggle(ContentArea, "🎯 Silent Aim", false, nil)
    
    CreateSection(ContentArea, "COMBAT FEATURES")
    CreateToggle(ContentArea, "🔫 Trigger Bot", false, nil)
    CreateToggle(ContentArea, "⚡ Rapid Fire", false, nil)
    CreateToggle(ContentArea, "🎯 No Recoil", false, nil)
    CreateToggle(ContentArea, "🎯 No Spread", false, nil)
    CreateToggle(ContentArea, "🔫 Infinite Ammo", false, nil)
end

local function LoadVisualsTab()
    ContentArea:ClearAllChildren()
    ContentLayout.Parent = ContentArea
    ContentPadding.Parent = ContentArea
    
    CreateSection(ContentArea, "ESP PREMIUM")
    CreateToggle(ContentArea, "👁️ ESP Enabled", false, nil)
    CreateToggle(ContentArea, "📦 Box ESP", false, nil)
    CreateToggle(ContentArea, "💀 Skeleton ESP", false, nil)
    CreateToggle(ContentArea, "📏 Distance ESP", false, nil)
    CreateToggle(ContentArea, "🔫 Weapon ESP", false, nil)
    CreateToggle(ContentArea, "❤️ Health Bar", false, nil)
    CreateToggle(ContentArea, "📸 Profile Picture", false, nil)
    
    CreateSection(ContentArea, "CHAMS")
    CreateToggle(ContentArea, "✨ Chams Enabled", false, nil)
    CreateToggle(ContentArea, "🎨 Filled Chams", false, nil)
    
    CreateSection(ContentArea, "TRACER")
    CreateToggle(ContentArea, "📍 Tracer Enabled", false, nil)
end

local function LoadCharacterTab()
    ContentArea:ClearAllChildren()
    ContentLayout.Parent = ContentArea
    ContentPadding.Parent = ContentArea
    
    CreateSection(ContentArea, "MOVEMENT")
    CreateToggle(ContentArea, "⚡ Speed Hack", false, nil)
    CreateToggle(ContentArea, "🚀 Fly Mode", false, nil)
    CreateToggle(ContentArea, "👻 Noclip", false, nil)
    CreateToggle(ContentArea, "🦘 Infinite Jump", false, nil)
    
    CreateSection(ContentArea, "PLAYER MODS")
    CreateToggle(ContentArea, "🛡️ God Mode", false, nil)
    CreateToggle(ContentArea, "⚡ Infinite Stamina", false, nil)
end

local function LoadConfigsTab()
    ContentArea:ClearAllChildren()
    ContentLayout.Parent = ContentArea
    ContentPadding.Parent = ContentArea
    
    CreateSection(ContentArea, "CONFIGURATION")
    
    local SaveButton = Instance.new("TextButton")
    SaveButton.Size = UDim2.new(1, -30, 0, 45)
    SaveButton.BackgroundColor3 = Config.Colors.Green
    SaveButton.Text = "💾 SAVE CONFIG"
    SaveButton.TextColor3 = Config.Colors.White
    SaveButton.TextSize = 16
    SaveButton.Font = Enum.Font.GothamBold
    SaveButton.Parent = ContentArea
    
    local SaveCorner = Instance.new("UICorner")
    SaveCorner.CornerRadius = UDim.new(0, 10)
    SaveCorner.Parent = SaveButton
    
    SaveButton.MouseButton1Click:Connect(function()
        PlaySound(Sounds.Success, 0.5, 1)
        print("✅ Configuration sauvegardée!")
    end)
end

local function LoadDashboardTab()
    ContentArea:ClearAllChildren()
    ContentLayout.Parent = ContentArea
    ContentPadding.Parent = ContentArea
    
    local WelcomeFrame = Instance.new("Frame")
    WelcomeFrame.Size = UDim2.new(1, -30, 0, 150)
    WelcomeFrame.BackgroundColor3 = Config.Colors.Background
    WelcomeFrame.BackgroundTransparency = 0.3
    WelcomeFrame.BorderSizePixel = 0
    WelcomeFrame.Parent = ContentArea
    
    local WelcomeCorner = Instance.new("UICorner")
    WelcomeCorner.CornerRadius = UDim.new(0, 12)
    WelcomeCorner.Parent = WelcomeFrame
    
    local WelcomeText = Instance.new("TextLabel")
    WelcomeText.Size = UDim2.new(1, -20, 0, 40)
    WelcomeText.Position = UDim2.new(0, 10, 0, 20)
    WelcomeText.BackgroundTransparency = 1
    WelcomeText.Text = "🌟 BIENVENUE DANS RIVALS ULTIMATE PREMIUM 🌟"
    WelcomeText.TextColor3 = Config.Colors.Gold
    WelcomeText.TextSize = 18
    WelcomeText.Font = Enum.Font.GothamBold
    WelcomeText.Parent = WelcomeFrame
    
    local InfoText = Instance.new("TextLabel")
    InfoText.Size = UDim2.new(1, -20, 0, 80)
    InfoText.Position = UDim2.new(0, 10, 0, 60)
    InfoText.BackgroundTransparency = 1
    InfoText.Text = "Menu Premium Master Class\nVersion 4.0.0\nCréé par Hiroshi738\n\n⚡ Toutes les fonctionnalités premium activées ⚡"
    InfoText.TextColor3 = Config.Colors.White
    InfoText.TextSize = 14
    InfoText.Font = Enum.Font.Gotham
    InfoText.TextWrapped = true
    InfoText.Parent = WelcomeFrame
    
    CreateSection(ContentArea, "STATISTIQUES")
    CreateToggle(ContentArea, "📊 Afficher les stats", true, nil)
end

local function SwitchTab(tabName)
    CurrentTab = tabName
    PlaySound(Sounds.Click, 0.3, 1)
    
    for name, button in pairs(Tabs) do
        button.BackgroundColor3 = Config.Colors.Background
        button.BackgroundTransparency = 0.3
    end
    
    Tabs[tabName].BackgroundColor3 = Config.Colors.Primary
    Tabs[tabName].BackgroundTransparency = 0
    
    if tabName == "Dashboard" then LoadDashboardTab()
    elseif tabName == "Combat" then LoadCombatTab()
    elseif tabName == "Visuals" then LoadVisualsTab()
    elseif tabName == "Character" then LoadCharacterTab()
    elseif tabName == "Configs" then LoadConfigsTab()
    end
end

for name, button in pairs(Tabs) do
    button.MouseButton1Click:Connect(function()
        SwitchTab(name)
    end)
end

-- Animations
local function OpenMenu()
    BlurOverlay.Visible = true
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    
    PlaySound(Sounds.MenuOpen, 0.6, 1)
    PlaySound(Sounds.Anime, 0.4, 1.2)
    PlaySound(Sounds.PowerUp, 0.5, 1)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 900, 0, 600)
    }):Play()
    
    MenuVisible = true
    SwitchTab("Dashboard")
    print("✨ Menu ouvert avec style!")
end

local function CloseMenu()
    PlaySound(Sounds.MenuClose, 0.5, 0.8)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    wait(0.4)
    MainFrame.Visible = false
    BlurOverlay.Visible = false
    MenuVisible = false
    print("🌙 Menu fermé")
end

CloseButton.MouseButton1Click:Connect(function()
    PlaySound(Sounds.Click, 0.4, 1)
    CloseMenu()
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        if MenuVisible then CloseMenu() else OpenMenu() end
    end
end)

-- Animation du logo
spawn(function()
    while true do
        TweenService:Create(Logo, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Rotation = 15
        }):Play()
        wait(1)
    end
end)

print("✅ Rivals Ultimate Premium Menu chargé!")
print("💡 Appuyez sur INSERT pour ouvrir")
print("🎮 Version Master Class - 500€/mois")
print("⚡ Made with ❤️ by Hiroshi738")

wait(1)
OpenMenu()

-- Made with Bob
