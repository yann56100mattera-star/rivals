-- Beautiful Roblox Menu Script
-- Créé avec un design moderne et élégant

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Création du ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BeautifulMenu"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Couleurs du thème
local Colors = {
    Background = Color3.fromRGB(25, 25, 35),
    Card = Color3.fromRGB(35, 35, 50),
    Accent = Color3.fromRGB(100, 150, 255),
    AccentHover = Color3.fromRGB(120, 170, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 200),
    Success = Color3.fromRGB(100, 200, 100),
    Error = Color3.fromRGB(255, 100, 100),
    Warning = Color3.fromRGB(255, 200, 100)
}

-- Fonction pour créer un bouton stylisé
local function createStyledButton(text, onClick)
    local button = Instance.new("TextButton")
    button.Name = text
    button.Text = text
    button.TextColor3 = Colors.Text
    button.TextSize = 18
    button.Font = Enum.Font.GothamBold
    button.BackgroundColor3 = Colors.Card
    button.BackgroundTransparency = 0.5
    button.Size = UDim2.new(0.8, 0, 0, 50)
    button.Position = UDim2.new(0.1, 0, 0, 0)
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    
    -- Coin arrondi
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = button
    
    -- Stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Colors.Accent
    stroke.Thickness = 2
    stroke.Transparency = 0.5
    stroke.Parent = button
    
    -- Effet de hover
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = Colors.Accent,
            BackgroundTransparency = 0.3,
            TextColor3 = Color3.new(1, 1, 1)
        })
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.3), {
            BackgroundColor3 = Colors.Card,
            BackgroundTransparency = 0.5,
            TextColor3 = Colors.Text
        })
        tween:Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(0.78, 0, 0, 48)
        })
        tween:Play()
        tween.Completed:Wait()
        local tween2 = TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(0.8, 0, 0, 50)
        })
        tween2:Play()
        if onClick then
            onClick()
        end
    end)
    
    return button
end

-- Création du menu principal
local function createMainMenu()
    -- Fond avec effet de flou
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Colors.Background
    background.BackgroundTransparency = 0.1
    background.BorderSizePixel = 0
    background.Parent = screenGui
    
    local blur = Instance.new("BlurEffect")
    blur.Size = 24
    blur.Parent = background
    
    -- Conteneur principal
    local mainContainer = Instance.new("Frame")
    mainContainer.Name = "MainContainer"
    mainContainer.Size = UDim2.new(0, 400, 0, 500)
    mainContainer.Position = UDim2.new(0.5, -200, 0.5, -250)
    mainContainer.BackgroundColor3 = Colors.Card
    mainContainer.BackgroundTransparency = 0.2
    mainContainer.BorderSizePixel = 0
    mainContainer.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = mainContainer
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Colors.Accent
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = mainContainer
    
    -- Animation d'entrée
    mainContainer.Size = UDim2.new(0, 0, 0, 0)
    mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    local openTween = TweenService:Create(mainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 400, 0, 500),
        Position = UDim2.new(0.5, -200, 0.5, -250)
    })
    openTween:Play()
    
    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 80)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Colors.Accent
    header.BackgroundTransparency = 0.8
    header.BorderSizePixel = 0
    header.Parent = mainContainer
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 20)
    headerCorner.Parent = header
    
    -- Masquer le coin inférieur du header
    local headerPadding = Instance.new("UIPadding")
    headerPadding.PaddingBottom = UDim.new(0, 20)
    headerPadding.Parent = header
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Text = "✨ Menu Principal"
    titleLabel.TextColor3 = Colors.Text
    titleLabel.TextSize = 28
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Parent = header
    
    -- Conteneur des boutons
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Size = UDim2.new(1, -40, 1, -100)
    buttonContainer.Position = UDim2.new(0, 20, 0, 90)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = mainContainer
    
    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 15)
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
                local closeTween = TweenService:Create(mainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                })
                closeTween:Play()
                closeTween.Completed:Wait()
                screenGui:Destroy()
            end
        }
    }
    
    for i, buttonData in ipairs(buttons) do
        local button = createStyledButton(buttonData.text, buttonData.onClick)
        button.Parent = buttonContainer
    end
    
    -- Footer avec version
    local footer = Instance.new("TextLabel")
    footer.Name = "Footer"
    footer.Text = "v1.0 • Beautiful Menu"
    footer.TextColor3 = Colors.TextSecondary
    footer.TextSize = 12
    footer.Font = Enum.Font.Gotham
    footer.Size = UDim2.new(1, 0, 0, 30)
    footer.Position = UDim2.new(0, 0, 1, -30)
    footer.BackgroundTransparency = 1
    footer.TextXAlignment = Enum.TextXAlignment.Center
    footer.Parent = mainContainer
end

-- Toggle du menu avec touche
local menuOpen = false
local menuGui = nil

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.M then
        if not menuOpen then
            menuOpen = true
            createMainMenu()
        else
            menuOpen = false
            if screenGui:FindFirstChild("MainContainer") then
                local mainContainer = screenGui.MainContainer
                local closeTween = TweenService:Create(mainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                })
                closeTween:Play()
                closeTween.Completed:Wait()
                screenGui:Destroy()
            end
        end
    end
end)

-- Message de bienvenue
print("🎨 Beautiful Menu chargé!")
print("Appuyez sur [M] pour ouvrir/fermer le menu")

-- Notification de chargement
local notification = Instance.new("ScreenGui")
notification.Name = "Notification"
notification.Parent = playerGui

local notifFrame = Instance.new("Frame")
notifFrame.Size = UDim2.new(0, 300, 0, 60)
notifFrame.Position = UDim2.new(1, -320, 1, -80)
notifFrame.BackgroundColor3 = Colors.Success
notifFrame.BackgroundTransparency = 0.2
notifFrame.BorderSizePixel = 0
notifFrame.Parent = notification

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 12)
notifCorner.Parent = notifFrame

local notifLabel = Instance.new("TextLabel")
notifLabel.Text = "✅ Menu chargé avec succès!"
notifLabel.TextColor3 = Colors.Text
notifLabel.TextSize = 16
notifLabel.Font = Enum.Font.GothamBold
notifLabel.Size = UDim2.new(1, 0, 1, 0)
notifLabel.BackgroundTransparency = 1
notifLabel.TextXAlignment = Enum.TextXAlignment.Center
notifLabel.TextYAlignment = Enum.TextYAlignment.Center
notifLabel.Parent = notifFrame

-- Animation de notification
notifFrame.Position = UDim2.new(1, 50, 1, -80)
local notifTween = TweenService:Create(notifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(1, -320, 1, -80)
})
notifTween:Play()

-- Disparition après 3 secondes
task.wait(3)
local notifFade = TweenService:Create(notifFrame, TweenInfo.new(0.5), {
    Position = UDim2.new(1, 50, 1, -80),
    BackgroundTransparency = 1
})
notifFade:Play()
notifFade.Completed:Wait()
notification:Destroy()
