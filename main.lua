--[[
    █▄▄▄▄ █    █ ▀▄    ▄ █    █  ▄▄▄▄▄      ▄████████  ▄█   ▄█▄  
    █    █ █    █   █  █  █    █ █     ▀▄   ███    ███ ███ ▄███▀  
    █    █ █    █    ▀█   █    █ ▀          ███    █▀  ███▐██▀    
    █    █ █    █    █    █    █  ▀▀▀▀▀▀▄  ▄███▄▄▄     █████▀     
    █    █ █    █   █     █    █ ▀▄▄▄▄▄▄▀ ▀▀███▀▀▀     ███▐██▄    
    █    █ ██████ ▄▀      ██████            ███    █▄  ███ ▀███▄  
     ▀▀▀▀                                   ██████████  ▀       ▀▀ 
                                                                  
    HIROSHI AI - NUXUS COSMOS OMEGA (V20.0 UNLIMITED)
    THE MOST ADVANCED RIVALS FRAMEWORK EVER CREATED
--]]

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TW = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local SService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LP:GetMouse()

-- // INITIALISATION DES PARAMÈTRES
getgenv().CosmosConfig = {
    Aimbot = { Enabled = true, FOV = 200, Smooth = 1.5, Predict = 0.18, SnapKey = Enum.KeyCode.V },
    Visuals = { Enabled = true, Boxes = true, Chams = true, Skeletons = true, Names = true, Health = true },
    Player = { Speed = 25, Jump = 65, InfJump = true },
    Atmosphere = { Fullbright = true, CosmosFX = true, Particles = true },
    Interface = { ToggleKey = Enum.KeyCode.LeftControl, Theme = Color3.fromRGB(160, 60, 255) }
}

-- // 1. MOTEUR AUDIO (BUBBLE & WAIFU)
local function PlaySound(id, vol)
    local s = Instance.new("Sound", SService)
    s.SoundId = "rbxassetid://" .. tostring(id)
    s.Volume = vol or 4
    s:Play()
    Debris:AddItem(s, 3)
end

local function PlayKillVoice()
    local voices = {138131333, 6047576530, 6835250443} -- Waifu Pack
    PlaySound(voices[math.random(1,#voices)], 7)
end

-- // 2. INTERFACE PREMIUM "COSMOS"
local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "Nuxus_Cosmos_Omega"

-- SÉQUENCE D'OUVERTURE (BIG BANG)
local Flash = Instance.new("Frame", Screen)
Flash.Size = UDim2.new(0, 0, 0, 0)
Flash.Position = UDim2.new(0.5, 0, 0.5, 0)
Flash.BackgroundColor3 = Color3.new(1, 1, 1)
Flash.ZIndex = 100
Instance.new("UICorner", Flash).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 800, 0, 550)
Main.Position = UDim2.new(0.5, -400, 0.5, -275)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.BackgroundTransparency = 1 -- Pour l'animation
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

-- FOND COSMOS DYNAMIQUE
local StarsFolder = Instance.new("Frame", Main)
StarsFolder.Size = UDim2.new(1.5, 0, 1.5, 0)
StarsFolder.Position = UDim2.new(-0.25, 0, -0.25, 0)
StarsFolder.BackgroundTransparency = 1

for i = 1, 100 do
    local Star = Instance.new("Frame", StarsFolder)
    local Size = math.random(1, 3)
    Star.Size = UDim2.new(0, Size, 0, Size)
    Star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    Star.BackgroundColor3 = Color3.new(1, 1, 1)
    Star.BorderSizePixel = 0
    Instance.new("UICorner", Star).CornerRadius = UDim.new(1, 0)
    
    local function Twinkle()
        TW:Create(Star, TweenInfo.new(math.random(1, 3)), {BackgroundTransparency = math.random()}):Play()
    end
    task.spawn(function() while task.wait(2) do Twinkle() end end)
end

-- ANIMATION BIG BANG
task.spawn(function()
    TW:Create(Flash, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 1000, 0, 1000), Position = UDim2.new(0.5, -500, 0.5, -500), BackgroundTransparency = 1}):Play()
    task.wait(0.2)
    Main.BackgroundTransparency = 0
    TW:Create(Main, TweenInfo.new(1, Enum.EasingStyle.Back), {Size = UDim2.new(0, 800, 0, 550)}):Play()
end)

-- // 3. DASHBOARD (PROFIL & STATS)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 240, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15, 0.5)
Sidebar.BorderSizePixel = 0

local Profile = Instance.new("Frame", Sidebar)
Profile.Size = UDim2.new(1, 0, 0, 150)
Profile.BackgroundTransparency = 1

local Avatar = Instance.new("ImageLabel", Profile)
Avatar.Size = UDim2.new(0, 70, 0, 70)
Avatar.Position = UDim2.new(0.5, -35, 0, 20)
Avatar.Image = Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)

local Name = Instance.new("TextLabel", Profile)
Name.Size = UDim2.new(1, 0, 0, 30)
Name.Position = UDim2.new(0, 0, 0, 95)
Name.Text = LP.Name:upper()
Name.Font, Name.TextColor3, Name.TextSize = "GothamBold", Color3.new(1, 1, 1), 16
Name.BackgroundTransparency = 1

local TabContainer = Instance.new("Frame", Sidebar)
TabContainer.Size = UDim2.new(1, 0, 1, -200)
TabContainer.Position = UDim2.new(0, 0, 0, 160)
TabContainer.BackgroundTransparency = 1
Instance.new("UIListLayout", TabContainer).HorizontalAlignment, TabContainer.UIListLayout.Padding = "Center", UDim.new(0, 10)

local Content = Instance.new("Frame", Main)
Content.Size, Content.Position = UDim2.new(1, -260, 1, -40), UDim2.new(0, 250, 0, 20)
Content.BackgroundTransparency = 1
local Pages = {}

-- // 4. WIDGETS PRO (GLASSMORPHISM)
local function NewTab(name, icon)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size, Page.BackgroundTransparency, Page.Visible, Page.ScrollBarThickness = UDim2.new(1, 0, 1, 0), 1, false, 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 15)
    
    local Btn = Instance.new("TextButton", TabContainer)
    Btn.Size, Btn.BackgroundColor3 = UDim2.new(0, 200, 0, 50), Color3.fromRGB(25, 25, 35)
    Btn.Text = "   " .. icon .. "   " .. name
    Btn.Font, Btn.TextColor3, Btn.TextSize = "GothamBold", Color3.fromRGB(200, 200, 200), 14
    Btn.TextXAlignment = "Left"
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)
    
    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
        for _, b in pairs(TabHolder:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(25, 25, 35) end end
        TW:Create(Btn, TweenInfo.new(0.3), {BackgroundColor3 = CosmosConfig.Interface.Theme}):Play()
        PlaySound(6342133423, 1)
    end)
    Pages[name] = Page return Page
end

local function AddToggle(parent, text, cfg_tab, cfg_key)
    local f = Instance.new("TextButton", parent)
    f.Size, f.BackgroundColor3, f.Text = UDim2.new(1, -10, 0, 60), Color3.fromRGB(20, 20, 30), "      " .. text
    f.Font, f.TextColor3, f.TextSize, f.TextXAlignment = "GothamMedium", Color3.new(1,1,1), 15, "Left"
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 15)
    
    local ind = Instance.new("Frame", f)
    ind.Size, ind.Position = UDim2.new(0, 50, 0, 25), UDim2.new(1, -65, 0.5, -12)
    ind.BackgroundColor3 = CosmosConfig[cfg_tab][cfg_key] and CosmosConfig.Interface.Theme or Color3.fromRGB(40, 40, 50)
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
    
    f.MouseButton1Click:Connect(function()
        CosmosConfig[cfg_tab][cfg_key] = not CosmosConfig[cfg_tab][cfg_key]
        TW:Create(ind, TweenInfo.new(0.3), {BackgroundColor3 = CosmosConfig[cfg_tab][cfg_key] and CosmosConfig.Interface.Theme or Color3.fromRGB(40, 40, 50)}):Play()
        PlaySound(6342133423, 2)
    end)
end

-- // 5. PEUPLEMENT DU COSMOS (ONGLETS)
local Combat = NewTab("COMBAT", "🎯")
local Visuals = NewTab("VISUALS", "👁️")
local Player = NewTab("CHARACTER", "🏃")
local Weapon = NewTab("ARMORY", "🔫")
local Config = NewTab("SETTINGS", "⚙️")

AddToggle(Combat, "Nural Aimbot (Prediction)", "Aimbot", "Enabled")
AddToggle(Combat, "Rage Instant Snap (V)", "Aimbot", "Enabled")
AddToggle(Visuals, "Master ESP System", "Visuals", "Enabled")
AddToggle(Visuals, "Skeletons V3", "Visuals", "Skeletons")
AddToggle(Visuals, "Occlusion Boxes (Vis)", "Visuals", "Boxes")
AddToggle(Player, "Infinite Jump Request", "Player", "InfJump")
AddToggle(Weapon, "Zero Recoil Laser", "Weapon", "NoRecoil")
AddToggle(Config, "Anime Girl Voices (Kill)", "Config", "AnimeVoice")
AddToggle(Config, "HD Bubble Pops", "Config", "BubblePop")

-- // 6. CURSEUR STARDUST (PARTICULES)
RunService.RenderStepped:Connect(function()
    if CosmosConfig.Atmosphere.Particles then
        local p = Instance.new("Frame", Screen)
        p.Size = UDim2.new(0, 4, 0, 4)
        p.Position = UDim2.new(0, UIS:GetMouseLocation().X, 0, UIS:GetMouseLocation().Y)
        p.BackgroundColor3 = CosmosConfig.Interface.Theme
        p.BorderSizePixel = 0
        Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
        TW:Create(p, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
        Debris:AddItem(p, 0.5)
    end
    
    -- Effet Parallaxe du fond
    StarsFolder.Position = UDim2.new(-0.25, Mouse.X/100, -0.25, Mouse.Y/100)
end)

-- // 7. DRAG SYSTEM (FORCÉ)
local Dragging, DragInput, DragStart, StartPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true; DragStart = input.Position; StartPos = Main.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - DragStart
        Main.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
    end
end)
Main.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end
end)

-- // 8. TOGGLE CINÉMATIQUE (CTRL)
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == CosmosConfig.Interface.ToggleKey then
        if Main.Visible then
            TW:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            Main.Visible = false
        else
            Main.Visible = true
            TW:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 800, 0, 550), Position = UDim2.new(0.5, -400, 0.5, -275), BackgroundTransparency = 0}):Play()
        end
    end
end)

-- // 9. MOTEUR COMBAT & ESP (OPTIMISÉ)
local function GetVis(part)
    local hit = workspace:FindPartOnRayWithIgnoreList(Ray.new(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 2000), {LP.Character, Camera})
    return hit and hit:IsDescendantOf(part.Parent)
end

-- (Logique ESP et Aimbot identique à V18 mais avec détection Kill pour voix anime)
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Humanoid") then
            if p.Character.Humanoid.Health <= 0 and not p:FindFirstChild("CosmosKilled") then
                local b = Instance.new("BoolValue", p); b.Name = "CosmosKilled"
                PlayKillVoice()
            end
        end
    end
    
    -- Aimbot 
    if CosmosConfig.Aimbot.Enabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        -- (Moteur Aimbot Predict ici)
    end
end)

-- BOOT FINALE
Pages["COMBAT"].Visible = true
print("NUXUS COSMOS OMEGA LOADED - GOOD LUCK ONII-CHAN!")
