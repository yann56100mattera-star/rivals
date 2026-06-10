--[[
    RIVALS HACK MENU - VERSION SIMPLE ET FONCTIONNELLE
    Appuyez sur INSERT pour ouvrir/fermer
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Variables
local MenuOpen = false
local Settings = {
    Aimbot = false,
    ESP = false,
    Speed = false,
    InfiniteAmmo = false,
    NoRecoil = false,
    SilentAim = false
}

-- Créer l'interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RivalsHack"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(100, 100, 255)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
Title.Text = "RIVALS HACK MENU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame

-- Fonction pour créer un bouton
local function CreateButton(name, yPos, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 180, 0, 35)
    Button.Position = UDim2.new(0, 10, 0, yPos)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Text = name .. ": OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 16
    Button.Font = Enum.Font.Gotham
    Button.Parent = MainFrame
    
    Button.MouseButton1Click:Connect(function()
        callback(Button)
    end)
    
    return Button
end

-- AIMBOT
local AimbotConnection
CreateButton("Aimbot", 50, function(btn)
    Settings.Aimbot = not Settings.Aimbot
    btn.Text = "Aimbot: " .. (Settings.Aimbot and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Aimbot and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 50)
    
    if Settings.Aimbot then
        AimbotConnection = RunService.RenderStepped:Connect(function()
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
                            if distance < shortestDistance and distance < 500 then
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
        if AimbotConnection then
            AimbotConnection:Disconnect()
        end
    end
end)

-- ESP
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "ESP"
ESPFolder.Parent = game.CoreGui

local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local function AddHighlight(char)
        if char:FindFirstChild("ESPHighlight") then return end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = char
    end
    
    if player.Character then
        AddHighlight(player.Character)
    end
    
    player.CharacterAdded:Connect(AddHighlight)
end

CreateButton("ESP", 95, function(btn)
    Settings.ESP = not Settings.ESP
    btn.Text = "ESP: " .. (Settings.ESP and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.ESP and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 50)
    
    if Settings.ESP then
        for _, player in pairs(Players:GetPlayers()) do
            CreateESP(player)
        end
        
        Players.PlayerAdded:Connect(CreateESP)
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("ESPHighlight") then
                player.Character.ESPHighlight:Destroy()
            end
        end
    end
end)

-- SPEED HACK
local SpeedConnection
CreateButton("Speed Hack", 140, function(btn)
    Settings.Speed = not Settings.Speed
    btn.Text = "Speed Hack: " .. (Settings.Speed and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.Speed and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 50)
    
    if Settings.Speed then
        SpeedConnection = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 50
            end
        end)
    else
        if SpeedConnection then
            SpeedConnection:Disconnect()
        end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- INFINITE AMMO
local AmmoConnection
CreateButton("Infinite Ammo", 185, function(btn)
    Settings.InfiniteAmmo = not Settings.InfiniteAmmo
    btn.Text = "Infinite Ammo: " .. (Settings.InfiniteAmmo and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.InfiniteAmmo and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 50)
    
    if Settings.InfiniteAmmo then
        AmmoConnection = RunService.Heartbeat:Connect(function()
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
                
                for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
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
        if AmmoConnection then
            AmmoConnection:Disconnect()
        end
    end
end)

-- NO RECOIL
CreateButton("No Recoil", 230, function(btn)
    Settings.NoRecoil = not Settings.NoRecoil
    btn.Text = "No Recoil: " .. (Settings.NoRecoil and "ON" or "OFF")
    btn.BackgroundColor3 = Settings.NoRecoil and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 50)
    
    if Settings.NoRecoil then
        -- Implémentation du no recoil
        local mt = getrawmetatable(game)
        local oldIndex = mt.__index
        setreadonly(mt, false)
        
        mt.__index = newcclosure(function(t, k)
            if Settings.NoRecoil and (k == "Recoil" or k == "RecoilSpring") then
                return 0
            end
            return oldIndex(t, k)
        end)
        
        setreadonly(mt, true)
    end
end)

-- Bouton INFO
local InfoBtn = Instance.new("TextButton")
InfoBtn.Size = UDim2.new(0, 180, 0, 35)
InfoBtn.Position = UDim2.new(0, 210, 0, 50)
InfoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
InfoBtn.Text = "INFO"
InfoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoBtn.TextSize = 16
InfoBtn.Font = Enum.Font.Gotham
InfoBtn.Parent = MainFrame

InfoBtn.MouseButton1Click:Connect(function()
    local info = [[
RIVALS HACK MENU

Touches:
- INSERT: Ouvrir/Fermer

Fonctionnalités:
- Aimbot: Visée auto
- ESP: Voir joueurs
- Speed: Vitesse x3
- Infinite Ammo: Munitions ∞
- No Recoil: Pas de recul

Créé par Bob
Version 1.0
]]
    print(info)
end)

-- Rendre le menu draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Title.InputBegan:Connect(function(input)
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

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Toggle menu
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MenuOpen = false
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        MenuOpen = not MenuOpen
        MainFrame.Visible = MenuOpen
    end
end)

-- Message de démarrage
print("=================================")
print("RIVALS HACK MENU CHARGÉ")
print("Appuyez sur INSERT pour ouvrir")
print("=================================")

wait(1)
MainFrame.Visible = true
MenuOpen = true

-- Made with Bob
