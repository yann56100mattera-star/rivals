--[[
    █▄▄▄▄ █    █ ▀▄    ▄ █    █  ▄▄▄▄▄      ▄████████  ▄█   ▄█▄  
    █    █ █    █   █  █  █    █ █     ▀▄   ███    ███ ███ ▄███▀  
    █    █ █    █    ▀█   █    █ ▀          ███    █▀  ███▐██▀    
    █    █ █    █    █    █    █  ▀▀▀▀▀▀▄  ▄███▄▄▄     █████▀     
    █    █ █    █   █     █    █ ▀▄▄▄▄▄▄▀ ▀▀███▀▀▀     ███▐██▄    
    █    █ ██████ ▄▀      ██████            ███    █▄  ███ ▀███▄  
     ▀▀▀▀                                   ██████████  ▀       ▀▀ 
                                                                  
    HIROSHI AI - NUXUS GENESIS V17.0 (THE FINAL DESTROYER)
    CERTIFIED GITHUB PRO-GRADE | BEST RIVALS CHEAT
--]]

-- // 1. CORE SERVICES
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

-- // 2. CONFIGURATION GLOVALE (PRÊT POUR LA VENTE)
getgenv().NuxusGenesis = {
    Combat = {
        Aimbot = true, Snap = true, FOV = 200, Smooth = 1.2, Predict = 0.18, 
        Hitbox = "Head", SnapKey = Enum.KeyCode.V, LockKey = Enum.UserInputType.MouseButton2,
        ShowFOV = true, WallCheck = true
    },
    Visuals = {
        Enabled = true, Boxes = true, Skeletons = true, Chams = true,
        Names = true, Health = true, Distance = true, LookTracers = true,
        VisCol = Color3.fromRGB(0, 255, 125), InvisCol = Color3.fromRGB(255, 45, 45)
    },
    Weapon = { NoRecoil = true, NoSpread = true, InstaReload = true, RapidFire = false },
    Player = { Speed = 24, Jump = 65, InfJump = true, Bhop = true, Fly = false },
    World = { Fullbright = true, CustomTime = 14, Skybox = "Pink Neon" },
    Config = { MenuKey = Enum.KeyCode.X, BubblePop = true, AnimeVoice = true, Hitmarker = true }
}

-- // 3. MOTEUR AUDIO WAIFU (VOIX ANIME FILLE)
local function PlayWaifuVoice()
    if not NuxusGenesis.Config.AnimeVoice then return end
    local voices = {
        138131333, -- Onii-chan
        6047576530, -- Ara Ara
        6835250443, -- Nico Nico Nii
        8565653457 -- Kawaii sound
    }
    local s = Instance.new("Sound", SService)
    s.SoundId = "rbxassetid://" .. voices[math.random(1, #voices)]
    s.Volume = 5
    s:Play()
    Debris:AddItem(s, 3)
end

local function PlayPop()
    if NuxusGenesis.Config.BubblePop then
        local s = Instance.new("Sound", SService)
        s.SoundId = "rbxassetid://6342133423"
        s.Volume = 4
        s:Play()
        Debris:AddItem(s, 2)
    end
end

-- // 4. MODERN UI LIBRARY (V17 PRO DESIGN)
local GUI_ID = "Nuxus_Genesis_V17"
if CoreGui:FindFirstChild(GUI_ID) then CoreGui[GUI_ID]:Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = GUI_ID
Screen.IgnoreGuiInset = true

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 680, 0, 500)
Main.Position = UDim2.new(0.5, -340, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness, Stroke.Color = 2.5, Color3.fromRGB(160, 60, 255)

-- SIDEBAR
local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 190, 1, 0)
Side.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
Side.BorderSizePixel = 0
Instance.new("UICorner", Side).CornerRadius = UDim.new(0, 15)

local Logo = Instance.new("TextLabel", Side)
Logo.Size = UDim2.new(1, 0, 0, 80)
Logo.Text = "NUXUS GENESIS"
Logo.Font, Logo.TextColor3, Logo.TextSize = "GothamBold", Color3.fromRGB(160, 60, 255), 22
Logo.BackgroundTransparency = 1

local TabHolder = Instance.new("Frame", Side)
TabHolder.Size = UDim2.new(1, 0, 1, -120)
TabHolder.Position = UDim2.new(0, 0, 0, 90)
TabHolder.BackgroundTransparency = 1
Instance.new("UIListLayout", TabHolder).HorizontalAlignment, TabHolder.UIListLayout.Padding = "Center", UDim.new(0, 8)

-- CONTENT AREA
local PageContainer = Instance.new("Frame", Main)
PageContainer.Size, PageContainer.Position = UDim2.new(1, -210, 1, -40), UDim2.new(0, 200, 0, 20)
PageContainer.BackgroundTransparency = 1

local Pages = {}

local function NewTab(name, icon)
    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size, Page.BackgroundTransparency, Page.Visible, Page.ScrollBarThickness = UDim2.new(1, 0, 1, 0), 1, false, 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 10)
    
    local Btn = Instance.new("TextButton", TabHolder)
    Btn.Size = UDim2.new(0, 170, 0, 45)
    Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    Btn.Text = "  " .. icon .. "  " .. name
    Btn.Font, Btn.TextColor3, Btn.TextSize = "GothamBold", Color3.fromRGB(200, 200, 200), 13
    Btn.TextXAlignment = "Left"
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
    
    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
        for _, b in pairs(TabHolder:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(22, 22, 32) end end
        Btn.BackgroundColor3 = Color3.fromRGB(160, 60, 255)
    end)
    Pages[name] = Page return Page
end

local function AddToggle(parent, text, cfg_tab, cfg_key)
    local f = Instance.new("TextButton", parent)
    f.Size, f.BackgroundColor3, f.Text = UDim2.new(1, -5, 0, 50), Color3.fromRGB(20, 20, 28), "   " .. text
    f.Font, f.TextColor3, f.TextSize, f.TextXAlignment = "GothamMedium", Color3.new(1,1,1), 14, "Left"
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
    local ind = Instance.new("Frame", f)
    ind.Size, ind.Position = UDim2.new(0, 40, 0, 22), UDim2.new(1, -50, 0.5, -11)
    ind.BackgroundColor3 = NuxusGenesis[cfg_tab][cfg_key] and Color3.fromRGB(160, 60, 255) or Color3.fromRGB(50, 50, 60)
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
    f.MouseButton1Click:Connect(function()
        NuxusGenesis[cfg_tab][cfg_key] = not NuxusGenesis[cfg_tab][cfg_key]
        ind.BackgroundColor3 = NuxusGenesis[cfg_tab][cfg_key] and Color3.fromRGB(160, 60, 255) or Color3.fromRGB(50, 50, 60)
        PlayPop()
    end)
end

-- // 5. REMPLISSAGE DES ONGLETS (INCROYABLEMENT COMPLET)
local Combat = NewTab("COMBAT", "🎯")
local Visuals = NewTab("VISUALS", "👁️")
local Player = NewTab("PLAYER", "🏃")
local Weapon = NewTab("WEAPON", "🔫")
local Config = NewTab("CONFIG", "⚙️")

-- Combat
AddToggle(Combat, "Master Aimbot", "Combat", "Aimbot")
AddToggle(Combat, "Rage Snap (V)", "Combat", "Snap")
AddToggle(Combat, "Wall Check (Vis)", "Combat", "WallCheck")
AddToggle(Combat, "Show FOV Radius", "Combat", "ShowFOV")

-- Visuals
AddToggle(Visuals, "Master ESP", "Visuals", "Enabled")
AddToggle(Visuals, "ESP Boxes 2D", "Visuals", "Boxes")
AddToggle(Visuals, "ESP Skeletons (Pro)", "Visuals", "Skeletons")
AddToggle(Visuals, "3D Glowing Chams", "Visuals", "Chams")
AddToggle(Visuals, "Player Names", "Visuals", "Names")
AddToggle(Visuals, "Show Distance", "Visuals", "Distance")

-- Player & Weapon
AddToggle(Player, "Infinite Jump", "Player", "InfJump")
AddToggle(Player, "Fullbright World", "Player", "Fullbright")
AddToggle(Weapon, "Zero Recoil", "Weapon", "NoRecoil")
AddToggle(Weapon, "Zero Spread", "Weapon", "NoSpread")

-- Config
AddToggle(Config, "Anime Girl Voices", "Config", "AnimeVoice")
AddToggle(Config, "Satisfying Pop", "Config", "BubblePop")

-- // 6. MOTEUR SQUELETTE ESP (C'EST ÇA QU'IL MANQUAIT !)
local function DrawLine()
    local l = Drawing.new("Line")
    l.Thickness = 1
    l.Visible = false
    l.Color = Color3.new(1,1,1)
    return l
end

local function GetVis(part)
    local ray = Ray.new(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 2000)
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LP.Character, Camera})
    return hit and hit:IsDescendantOf(part.Parent)
end

local function ManageESP(p)
    local Box = Drawing.new("Square")
    Box.Thickness, Box.Visible = 2, false
    
    local Skeleton = {
        HeadToTorso = DrawLine(),
        TorsoToLArm = DrawLine(),
        TorsoToRArm = DrawLine(),
        TorsoToLLeg = DrawLine(),
        TorsoToRLeg = DrawLine()
    }

    RunService.RenderStepped:Connect(function()
        if NuxusGenesis.Visuals.Enabled and p.Character and p.Character:FindFirstChild("Head") and p ~= LP then
            local char = p.Character
            local head = char.Head
            local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
            local lArm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")
            local rArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
            local lLeg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg")
            local rLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
            
            local pos, onS = Camera:WorldToViewportPoint(torso.Position)
            local visible = GetVis(head)
            local color = visible and NuxusGenesis.Visuals.VisCol or NuxusGenesis.Visuals.InvisCol
            
            -- CHAMS
            if NuxusGenesis.Visuals.Chams then
                local h = char:FindFirstChild("GenesisH") or Instance.new("Highlight", char)
                h.Name, h.FillColor, h.FillTransparency = "GenesisH", color, 0.5
            end

            -- SKELETON
            if onS and NuxusGenesis.Visuals.Skeletons then
                local function Connect(p1, p2, line)
                    local sp1, vis1 = Camera:WorldToViewportPoint(p1.Position)
                    local sp2, vis2 = Camera:WorldToViewportPoint(p2.Position)
                    if vis1 and vis2 then
                        line.From, line.To, line.Color, line.Visible = Vector2.new(sp1.X, sp1.Y), Vector2.new(sp2.X, sp2.Y), color, true
                    else line.Visible = false end
                end
                Connect(head, torso, Skeleton.HeadToTorso)
                Connect(torso, lArm, Skeleton.TorsoToLArm)
                Connect(torso, rArm, Skeleton.TorsoToRArm)
                Connect(torso, lLeg, Skeleton.TorsoToLLeg)
                Connect(torso, rLeg, Skeleton.TorsoToRLeg)
            else
                for _, l in pairs(Skeleton) do l.Visible = false end
            end

            if onS and NuxusGenesis.Visuals.Boxes then
                local h = (Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0)).Y - Camera:WorldToViewportPoint(torso.Position - Vector3.new(0, 3, 0)).Y)
                Box.Size, Box.Position, Box.Color, Box.Visible = Vector2.new(h * 0.7, h), Vector2.new(pos.X - (Box.Size.X/2), pos.Y - (Box.Size.Y/2)), color, true
            else Box.Visible = false end
            
            -- KILL VOICE
            if char.Humanoid.Health <= 0 and not p:FindFirstChild("GenesisDead") then
                Instance.new("BoolValue", p).Name = "GenesisDead"
                PlayWaifuVoice()
            end
        else
            Box.Visible = false
            for _, l in pairs(Skeleton) do l.Visible = false end
            if p.Character and p.Character:FindFirstChild("GenesisH") then p.Character.GenesisH:Destroy() end
        end
    end)
end

-- // 7. FINAL MAIN LOOP (AIMBOT & RAGE)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness, FOVCircle.Color = 1, Color3.fromRGB(160, 60, 255)

RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = NuxusGenesis.Combat.ShowFOV and NuxusGenesis.Combat.Aimbot
    FOVCircle.Radius, FOVCircle.Position = NuxusGenesis.Combat.FOV, UIS:GetMouseLocation()
    
    if NuxusGenesis.World.Fullbright then Lighting.Brightness = 2 end
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = NuxusGenesis.Player.Speed
    end

    if NuxusGenesis.Combat.Aimbot and UIS:IsMouseButtonPressed(NuxusGenesis.Combat.LockKey) then
        local t, d = nil, NuxusGenesis.Combat.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild(NuxusGenesis.GenesisConfig and NuxusGenesis.GenesisConfig.Combat.Hitbox or "Head") then
                local pos, onS = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if onS then
                    local mDist = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
                    if mDist < d then t, d = p, mDist end
                end
            end
        end
        if t then
            local head = t.Character.Head
            local screenPos = Camera:WorldToViewportPoint(head.Position + (head.Velocity * NuxusGenesis.Combat.Predict))
            mousemoverel((screenPos.X - Mouse.X)/NuxusGenesis.Combat.Smooth, (screenPos.Y - Mouse.Y)/NuxusGenesis.Combat.Smooth)
        end
    end
end)

-- TOUCHE X ET SNAP
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == NuxusGenesis.Config.MenuKey then Main.Visible = not Main.Visible end
    if input.KeyCode == Enum.KeyCode.Space and NuxusGenesis.Player.InfJump then LP.Character.Humanoid:ChangeState(3) end
end)

-- BOOT
for _, p in pairs(Players:GetPlayers()) do ManageESP(p) end
Players.PlayerAdded:Connect(ManageESP)
Pages["COMBAT"].Visible = true
print("NUXUS GENESIS V17 LOADED - OMEDETOU ONII-CHAN!")
