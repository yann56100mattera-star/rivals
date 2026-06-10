-- Beautiful Roblox Menu Script
-- Créé avec un design magnifique et moderne

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variables globales
local screenGui = nil
local menuOpen = false
local mainContainer = nil

-- Son d'ouverture (son anime japonaise)
local function playOpenSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6895079853" -- Son anime cute
    sound.Volume = 0.5
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

-- Couleurs du thème magnifique
local Colors = {
    Background = Color3.fromRGB(15, 15, 25),
    Card = Color3.fromRGB(25, 25, 40),
    Accent = Color3.fromRGB(255, 100, 150),
    AccentHover = Color3.fromRGB(255, 130, 180),
    Accent2 = Color3.fromRGB(150, 100, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(200, 200, 220),
    Success = Color3.fromRGB(100, 255, 150),
    Error = Color3.fromRGB(255, 100, 100),
    Warning = Color3.fromRGB(255, 200, 100),
    Gold = Color3.fromRGB(255, 215, 0)
}

-- Fonction pour créer un bouton stylisé magnifique
local function createStyledButton(text, onClick, index)
    local button = Instance.new("TextButton")
    button.Name = text
    button.Text = text
    button.TextColor3 = Colors.Text
    button.TextSize = 20
    button.Font = Enum.Font.GothamBold
    button.BackgroundColor3 = Colors.Card
    button.BackgroundTransparency = 0.3
    button.Size = UDim2.new(0.9, 0, 0, 55)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    
    -- Gradient magnifique
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Colors.Card),
        ColorSequenceKeypoint.new(0.5, Colors.Accent2),
        ColorSequenceKeypoint.new(1, Colors.Card)
    })
    gradient.Rotation = 45
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.7),
        NumberSequenceKeypoint.new(0.5, 0.5),
        NumberSequenceKeypoint.new(1, 0.7)
    })
    gradient.Parent = button
    
    -- Coin arrondi
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = button
    
    -- Stroke brillant
    local stroke = Instance.new("UIStroke")
    stroke.Color = Colors.Gold
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = button
    
    -- Ombre
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, 5, 0, 5)
    shadow.BackgroundColor3 = Color3.new(0, 0, 0)
    shadow.BackgroundTransparency = 0.8
    shadow.BorderSizePixel = 0
    shadow.ZIndex = button.ZIndex - 1
    shadow.Parent = button
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 15)
    shadowCorner.Parent = shadow
    
    -- Effet de hover magnifique
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            BackgroundColor3 = Colors.Accent,
            BackgroundTransparency = 0.1,
            Size = UDim2.new(0.92, 0, 0, 58)
        })
        tween:Play()
        
        local strokeTween = TweenService:Create(stroke, TweenInfo.new(0.3), {
            Color = Colors.AccentHover,
            Thickness = 3
        })
        strokeTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = Colors.Card,
            BackgroundTransparency = 0.3,
            Size = UDim2.new(0.9, 0, 0, 55)
        })
        tween:Play()
        
        local strokeTween = TweenService:Create(stroke, TweenInfo.new(0.3), {
            Color = Colors.Gold,
            Thickness = 2
        })
        strokeTween:Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.85, 0, 0, 50)
        })
        tween:Play()
        tween.Completed:Wait()
        local tween2 = TweenService:Create(button, TweenInfo.new(0.15, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.9, 0, 0, 55)
        })
        tween2:Play()
        if onClick then
            onClick()
        end
    end)
    
    return button
end

-- Création du menu principal magnifique
local function createMainMenu()
    -- Créer le ScreenGui à chaque ouverture
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BeautifulMenu"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui
    
    -- Jouer le son d'ouverture
    playOpenSound()
    
    -- Fond avec effet de flou magnifique
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Colors.Background
    background.BackgroundTransparency = 0.2
    background.BorderSizePixel = 0
    background.Parent = screenGui
    
    -- Gradient de fond
    local bgGradient = Instance.new("UIGradient")
    bgGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 25)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 15, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 25, 35))
    })
    bgGradient.Rotation = 45
    bgGradient.Parent = background
    
    -- Conteneur principal avec design magnifique
    mainContainer = Instance.new("Frame")
    mainContainer.Name = "MainContainer"
    mainContainer.Size = UDim2.new(0, 450, 0, 550)
    mainContainer.Position = UDim2.new(0.5, -225, 0.5, -275)
    mainContainer.BackgroundColor3 = Colors.Card
    mainContainer.BackgroundTransparency = 0.15
    mainContainer.BorderSizePixel = 0
    mainContainer.Parent = screenGui
    
    -- Gradient du conteneur
    local containerGradient = Instance.new("UIGradient")
    containerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Colors.Card),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 30, 60)),
        ColorSequenceKeypoint.new(1, Colors.Card)
    })
    containerGradient.Rotation = 135
    containerGradient.Parent = mainContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 25)
    corner.Parent = mainContainer
    
    -- Stroke brillant avec gradient
    local stroke = Instance.new("UIStroke")
    stroke.Color = Colors.Gold
    stroke.Thickness = 3
    stroke.Transparency = 0.2
    stroke.Parent = mainContainer
    
    local strokeGradient = Instance.new("UIGradient")
    strokeGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Colors.Gold),
        ColorSequenceKeypoint.new(0.5, Colors.Accent),
        ColorSequenceKeypoint.new(1, Colors.Gold)
    })
    strokeGradient.Rotation = 45
    strokeGradient.Parent = stroke
    
    -- Ombre du conteneur
    local containerShadow = Instance.new("Frame")
    containerShadow.Size = UDim2.new(1, 20, 1, 20)
    containerShadow.Position = UDim2.new(0, 10, 0, 10)
    containerShadow.BackgroundColor3 = Color3.new(0, 0, 0)
    containerShadow.BackgroundTransparency = 0.7
    containerShadow.BorderSizePixel = 0
    containerShadow.ZIndex = mainContainer.ZIndex - 1
    containerShadow.Parent = mainContainer
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 25)
    shadowCorner.Parent = containerShadow
    
    -- Animation d'entrée spectaculaire
    mainContainer.Size = UDim2.new(0, 0, 0, 0)
    mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainContainer.Rotation = -180
    local openTween = TweenService:Create(mainContainer, TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 450, 0, 550),
        Position = UDim2.new(0.5, -225, 0.5, -275),
        Rotation = 0
    })
    openTween:Play()
    
    -- Header magnifique
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 100)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Colors.Accent
    header.BackgroundTransparency = 0.7
    header.BorderSizePixel = 0
    header.Parent = mainContainer
    
    local headerGradient = Instance.new("UIGradient")
    headerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Colors.Accent),
        ColorSequenceKeypoint.new(0.5, Colors.Accent2),
        ColorSequenceKeypoint.new(1, Colors.Accent)
    })
    headerGradient.Rotation = 90
    headerGradient.Parent = header
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 25)
    headerCorner.Parent = header
    
    -- Masquer le coin inférieur du header
    local headerPadding = Instance.new("UIPadding")
    headerPadding.PaddingBottom = UDim.new(0, 25)
    headerPadding.Parent = header
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Text = "✨ Menu Magnifique ✨"
    titleLabel.TextColor3 = Colors.Text
    titleLabel.TextSize = 32
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.TextStrokeTransparency = 0.5
    titleLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    titleLabel.Parent = header
    
    -- Conteneur des boutons
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Size = UDim2.new(1, -50, 1, -130)
    buttonContainer.Position = UDim2.new(0, 25, 0, 110)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = mainContainer
    
    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 18)
    uiListLayout.Parent = buttonContainer
    
    -- Boutons du menu
    local buttons = {
        {
            text = "🎮 Jouer",
            onClick = function()
                print("Bouton Jouer cliqué!")
            end
        },
        {
            text = "⚙️ Paramètres",
            onClick = function()
                print("Bouton Paramètres cliqué!")
            end
        },
        {
            text = "🏆 Classement",
            onClick = function()
                print("Bouton Classement cliqué!")
            end
        },
        {
            text = "👥 Amis",
            onClick = function()
                print("Bouton Amis cliqué!")
            end
        },
        {
            text = "❓ Aide",
            onClick = function()
                print("Bouton Aide cliqué!")
            end
        },
        {
            text = "🚪 Quitter",
            onClick = function()
                closeMenu()
            end
        }
    }
    
    for i, buttonData in ipairs(buttons) do
        local button = createStyledButton(buttonData.text, buttonData.onClick, i)
        button.Parent = buttonContainer
    end
    
    -- Footer magnifique avec version
    local footer = Instance.new("TextLabel")
    footer.Name = "Footer"
    footer.Text = "✨ v2.0 • Menu Magnifique ✨"
    footer.TextColor3 = Colors.Gold
    footer.TextSize = 14
    footer.Font = Enum.Font.GothamBold
    footer.Size = UDim2.new(1, 0, 0, 35)
    footer.Position = UDim2.new(0, 0, 1, -35)
    footer.BackgroundTransparency = 1
    footer.TextXAlignment = Enum.TextXAlignment.Center
    footer.TextYAlignment = Enum.TextYAlignment.Center
    footer.TextStrokeTransparency = 0.7
    footer.TextStrokeColor3 = Color3.new(0, 0, 0)
    footer.Parent = mainContainer
end

-- Fonction pour fermer le menu
local function closeMenu()
    if mainContainer and screenGui then
        local closeTween = TweenService:Create(mainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Rotation = 180
        })
        closeTween:Play()
        closeTween.Completed:Wait()
        screenGui:Destroy()
        screenGui = nil
        mainContainer = nil
        menuOpen = false
    end
end

-- Toggle du menu avec touche X
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.X then
        if not menuOpen then
            menuOpen = true
            createMainMenu()
        else
            closeMenu()
        end
    end
end)

-- Message de bienvenue
print("✨ Menu Magnifique chargé!")
print("Appuyez sur [X] pour ouvrir/fermer le menu")

-- Notification de chargement magnifique
local notification = Instance.new("ScreenGui")
notification.Name = "Notification"
notification.Parent = playerGui

local notifFrame = Instance.new("Frame")
notifFrame.Size = UDim2.new(0, 350, 0, 70)
notifFrame.Position = UDim2.new(1, 50, 1, -90)
notifFrame.BackgroundColor3 = Colors.Accent
notifFrame.BackgroundTransparency = 0.2
notifFrame.BorderSizePixel = 0
notifFrame.Parent = notification

local notifGradient = Instance.new("UIGradient")
notifGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Colors.Accent),
    ColorSequenceKeypoint.new(1, Colors.Accent2)
})
notifGradient.Rotation = 45
notifGradient.Parent = notifFrame

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 15)
notifCorner.Parent = notifFrame

local notifStroke = Instance.new("UIStroke")
notifStroke.Color = Colors.Gold
notifStroke.Thickness = 2
notifStroke.Transparency = 0.3
notifStroke.Parent = notifFrame

local notifLabel = Instance.new("TextLabel")
notifLabel.Text = "✨ Menu Magnifique chargé! ✨"
notifLabel.TextColor3 = Colors.Text
notifLabel.TextSize = 18
notifLabel.Font = Enum.Font.GothamBold
notifLabel.Size = UDim2.new(1, 0, 1, 0)
notifLabel.BackgroundTransparency = 1
notifLabel.TextXAlignment = Enum.TextXAlignment.Center
notifLabel.TextYAlignment = Enum.TextYAlignment.Center
notifLabel.TextStrokeTransparency = 0.5
notifLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
notifLabel.Parent = notifFrame

-- Animation de notification
local notifTween = TweenService:Create(notifFrame, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
    Position = UDim2.new(1, -370, 1, -90)
})
notifTween:Play()

-- Disparition après 4 secondes
task.wait(4)
local notifFade = TweenService:Create(notifFrame, TweenInfo.new(0.5), {
    Position = UDim2.new(1, 50, 1, -90),
    BackgroundTransparency = 1
})
notifFade:Play()
notifFade.Completed:Wait()
notification:Destroy()
