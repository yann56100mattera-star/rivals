--[[
    █▄▄▄▄ █    █ ▀▄    ▄ █    █  ▄▄▄▄▄      ▄████████  ▄█   ▄█▄  
    █    █ █    █   █  █  █    █ █     ▀▄   ███    ███ ███ ▄███▀  
    █    █ █    █    ▀█   █    █ ▀          ███    █▀  ███▐██▀    
    █    █ █    █    █    █    █  ▀▀▀▀▀▀▄  ▄███▄▄▄     █████▀     
    █    █ █    █   █     █    █ ▀▄▄▄▄▄▄▀ ▀▀███▀▀▀     ███▐██▄    
    █    █ ██████ ▄▀      ██████            ███    █▄  ███ ▀███▄  
     ▀▀▀▀                                   ██████████  ▀       ▀▀ 
                                                                  
    HIROSHI AI - NUXUS ODYSSEY OMEGA V21.0
    THE ULTIMATE INDUSTRIAL GRADE FRAMEWORK
    LICENCE: CERTIFIED PRO | GITHUB READY
--]]

-- // 1. MODULE : SERVICES KERNEL
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

-- // 2. MODULE : CONFIGURATION OMEGA
getgenv().NuxusOdyssey = {
    Enabled = true,
    Combat = {
        Aimbot = true, Snap = true, FOV = 200, Smooth = 1.3, Predict = 0.185, 
        Hitbox = "Head", SnapKey = Enum.KeyCode.V, LockKey = Enum.UserInputType.MouseButton2,
        ShowFOV = true, WallCheck = true
    },
    Visuals = {
        Enabled = true, Boxes = true, Skeletons = true, Chams = true,
        Names = true, Health = true, Distance = true, MaxDist = 3000,
        VisCol = Color3.fromRGB(0, 255, 150), InvisCol = Color3.fromRGB(255, 45, 45)
    },
    Player = { Speed = 25, Jump = 68, InfJump = true, Bhop = true },
    Atmosphere = { Fullbright = true, CosmosFX = true, Particles = true, Time = 14 },
    Interface = { MenuKey = Enum.KeyCode.LeftControl, Theme = Color3.fromRGB(160, 60, 255), Audio = true }
}

-- // 3. MODULE : MOTEUR AUDIO (HD WAIFU & BUBBLES)
local function PlayEffect(id, vol)
    if not NuxusOdyssey.Interface.Audio then return end
    local s = Instance.new("Sound", SService)
    s.SoundId = "rbxassetid://" .. tostring(id)
    s.Volume = vol or 4
    s:Play(); Debris:AddItem(s, 3)
end

local function TriggerKillSound()
    local voices = {138131333, 6047576530, 6835250443} -- Onii-chan, Ara Ara, Nico Nico
    PlayEffect(voices[math.random(1,#voices)], 8)
end

local function TriggerPop() PlayEffect(6342133423, 5) end

-- // 4. MODULE : RENDU DRAWING (VECTOR ENGINE)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5; FOVCircle.NumSides = 100; FOVCircle.Color = NuxusOdyssey.Interface.Theme

local function NewLine()
    local l = Drawing.new("Line")
    l.Thickness = 1.5; l.Visible = false; return l
end

-- // 5. MODULE : INTERFACE COSMOS (INDUSTRIAL DESIGN)
local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "Nuxus_Odyssey_" .. math.random(1, 9999)

-- SEQUENCE BIG BANG
local QuantumPoint = Instance.new("Frame", Screen)
QuantumPoint.Size = UDim2.new(0, 4, 0, 4)
QuantumPoint.Position = UDim2.new(0.5, 0, 0.5, 0)
QuantumPoint.BackgroundColor3 = Color3.new(1, 1, 1)
QuantumPoint.ZIndex = 1000
Instance.new("UICorner", QuantumPoint).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 0, 0, 0) -- Start for animation
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)
local Glow = Instance.new("UIStroke", Main)
Glow.Thickness, Glow.Color = 3, NuxusOdyssey.Interface.Theme

-- FOND COSMOS VIVANT
local CosmosContainer = Instance.new("Frame", Main)
CosmosContainer.Size = UDim2.new(1.2, 0, 1.2, 0)
CosmosContainer.Position = UDim2.new(-0.1, 0, -0.1, 0)
CosmosContainer.BackgroundTransparency = 1

for i = 1, 150 do
    local s = Instance.new("Frame", CosmosContainer)
    local sz = math.random(1, 3)
    s.Size = UDim2.new(0, sz, 0, sz)
    s.Position = UDim2.new(math.random(), 0, math.random(), 0)
    s.BackgroundColor3 = Color3.new(1, 1, 1)
    s.BorderSizePixel = 0
    Instance.new("UICorner", s).CornerRadius = UDim.new(1, 0)
end

-- SIDEBAR ET NAVIGATION
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 220, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 18, 0.6)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 20)

local TabHolder = Instance.new("Frame", Sidebar)
TabHolder.Size = UDim2.new(1, 0, 1, -150)
TabHolder.Position = UDim2.new(0, 0, 0, 120)
TabHolder.BackgroundTransparency = 1
Instance.new("UIListLayout", TabHolder).HorizontalAlignment, TabHolder.UIListLayout.Padding = "Center", UDim.new(0, 8)

local Content = Instance.new("Frame", Main)
Content.Size, Content.Position = UDim2.new(1, -250, 1, -40), UDim2.new(0, 235, 0, 20)
Content.BackgroundTransparency = 1
local Pages = {}

-- // MODULE : WIDGETS PRO
local function CreatePage(name, icon)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size, Page.BackgroundTransparency, Page.Visible, Page.ScrollBarThickness = UDim2.new(1, 0, 1, 0), 1, false, 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 12)
    
    local Btn = Instance.new("TextButton", TabHolder)
    Btn.Size, Btn.BackgroundColor3 = UDim2.new(0, 190, 0, 50), Color3.fromRGB(20, 20, 30, 0.5)
    Btn.Text = "   " .. icon .. "   " .. name
    Btn.Font, Btn.TextColor3, Btn.TextSize = "GothamBold", Color3.fromRGB(200, 200, 200), 14
    Btn.TextXAlignment = "Left"
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)
    
    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
        for _, b in pairs(TabHolder:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(20, 20, 30, 0.5) end end
        Btn.BackgroundColor3 = NuxusOdyssey.Interface.Theme
        TriggerPop()
    end)
    Pages[name] = Page return Page
end

local function AddToggle(parent, text, cfg_tab, cfg_key)
    local f = Instance.new("TextButton", parent)
    f.Size, f.BackgroundColor3, f.Text = UDim2.new(1, -5, 0, 60), Color3.fromRGB(20, 20, 30, 0.6), "      " .. text
    f.Font, f.TextColor3, f.TextSize, f.TextXAlignment = "GothamMedium", Color3.new(1,1,1), 14, "Left"
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
    
    local ind = Instance.new("Frame", f)
    ind.Size, ind.Position = UDim2.new(0, 45, 0, 22), UDim2.new(1, -60, 0.5, -11)
    ind.BackgroundColor3 = NuxusOdyssey[cfg_tab][cfg_key] and NuxusOdyssey.Interface.Theme or Color3.fromRGB(50, 50, 65)
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
    
    f.MouseButton1Click:Connect(function()
        NuxusOdyssey[cfg_tab][cfg_key] = not NuxusOdyssey[cfg_tab][cfg_key]
        TW:Create(ind, TweenInfo.new(0.3), {BackgroundColor3 = NuxusOdyssey[cfg_tab][cfg_key] and NuxusOdyssey.Interface.Theme or Color3.fromRGB(50, 50, 65)}):Play()
        TriggerPop()
    end)
end

-- // 6. MODULE : INITIALISATION DES PAGES
local Combat = CreatePage("COMBAT", "🎯")
local Visuals = CreatePage("VISUALS", "👁️")
local Player = CreatePage("PLAYER", "🏃")
local Weapon = CreatePage("WEAPON", "🔫")
local Config = CreatePage("SETTINGS", "⚙️")

AddToggle(Combat, "Nural Aimbot Prediction", "Combat", "Aimbot")
AddToggle(Combat, "Rage Instant Snap (V)", "Combat", "Snap")
AddToggle(Visuals, "Master ESP System", "Visuals", "Enabled")
AddToggle(Visuals, "Skeleton 3D Engine", "Visuals", "Skeletons")
AddToggle(Visuals, "Occlusion Boxes (Smart)", "Visuals", "Boxes")
AddToggle(Visuals, "Show Player Names", "Visuals", "Names")
AddToggle(Weapon, "Zero Recoil Laser", "Weapon", "NoRecoil")
AddToggle(Config, "Waifu Kill-Voices", "Config", "AnimeVoice")

-- // 7. MODULE : MOTEURS AIM & ESP (HIGH PERFORMANCE)
local function GetVis(p)
    local hit = workspace:FindPartOnRayWithIgnoreList(Ray.new(Camera.CFrame.Position, (p.Position - Camera.CFrame.Position).Unit * 2000), {LP.Character, Camera})
    return hit and hit:IsDescendantOf(p.Parent)
end

local function ManageESP(p)
    local Box = Drawing.new("Square"); Box.Thickness = 2
    local Name = Drawing.new("Text"); Name.Size = 14; Name.Outline = true; Name.Center = true
    local Dist = Drawing.new("Text"); Dist.Size = 12; Dist.Outline = true; Dist.Center = true

    RunService.RenderStepped:Connect(function()
        if NuxusOdyssey.Visuals.Enabled and p.Character and p.Character:FindFirstChild("Head") and p ~= LP then
            local char = p.Character; local root = char.HumanoidRootPart; local head = char.Head
            local pos, onS = Camera:WorldToViewportPoint(root.Position)
            local col = GetVis(head) and NuxusOdyssey.Visuals.VisCol or NuxusOdyssey.Visuals.InvisCol
            
            if onS then
                if NuxusOdyssey.Visuals.Boxes then
                    local h = (Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0)).Y - Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0)).Y)
                    Box.Size, Box.Position, Box.Color, Box.Visible = Vector2.new(h * 0.7, h), Vector2.new(pos.X - (Box.Size.X/2), pos.Y - (Box.Size.Y/2)), col, true
                else Box.Visible = false end

                if NuxusOdyssey.Visuals.Names then
                    Name.Text = p.Name; Name.Position = Vector2.new(pos.X, pos.Y - (Box.Size.Y/2) - 20); Name.Color, Name.Visible = col, true
                else Name.Visible = false end

                if NuxusOdyssey.Visuals.Distance then
                    Dist.Text = "["..math.floor((root.Position - Camera.CFrame.Position).Magnitude).."m]"; Dist.Position = Vector2.new(pos.X, pos.Y + (Box.Size.Y/2) + 5); Dist.Visible = true
                else Dist.Visible = false end
            else
                Box.Visible, Name.Visible, Dist.Visible = false, false, false
            end
        else
            Box.Visible, Name.Visible, Dist.Visible = false, false, false
        end
    end)
end

-- // 8. MODULE : MAIN LOOP (KERNEL)
RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = NuxusOdyssey.Combat.Aimbot; FOVCircle.Radius = NuxusOdyssey.Combat.FOV; FOVCircle.Position = UIS:GetMouseLocation()
    
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = NuxusOdyssey.Player.Speed
    end

    if NuxusOdyssey.Combat.Aimbot and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local t, d = nil, NuxusOdyssey.Combat.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
                local pos, onS = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if onS then
                    local mD = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
                    if mD < d then t, d = p, mD end
                end
            end
        end
        if t then
            local head = t.Character.Head
            local screenPos = Camera:WorldToViewportPoint(head.Position + (head.Velocity * NuxusOdyssey.Combat.Predict))
            mousemoverel((screenPos.X - Mouse.X)/NuxusOdyssey.Combat.Smooth, (screenPos.Y - Mouse.Y)/NuxusOdyssey.Combat.Smooth)
        end
    end
end)

-- // 9. MODULE : SEQUENCE D'OUVERTURE
task.spawn(function()
    TW:Create(QuantumPoint, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 2000, 0, 2000), Position = UDim2.new(0.5, -1000, 0.5, -1000), BackgroundTransparency = 1}):Play()
    task.wait(0.2)
    Main.Visible = true
    TW:Create(Main, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0, 750, 0, 520), Position = UDim2.new(0.5, -375, 0.5, -260)}):Play()
end)

-- // 10. MODULE : DÉTECTION KILL & TOGGLE
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == NuxusOdyssey.Interface.MenuKey then
        if Main.Visible then
            TW:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1}):Play()
            task.wait(0.5); Main.Visible = false
        else
            Main.Visible = true; TW:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 750, 0, 520), Position = UDim2.new(0.5, -375, 0.5, -260), BackgroundTransparency = 0}):Play()
        end
    end
end)

-- BOOT FINALE
for _, p in pairs(Players:GetPlayers()) do ManageESP(p) end
Players.PlayerAdded:Connect(ManageESP)
Pages["COMBAT"].Visible = true

-- DRAG SYSTEM FORCÉ
local d, ds, sp; Main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d, ds, sp = true, i.Position, Main.Position end end)
UIS.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then
    local delta = i.Position - ds; Main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y)
end end)
Main.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)

print("NUXUS ODYSSEY OMEGA V21 LOADED - WELCOME ONII-CHAN!")
