--[[
    █▄▄▄▄ █    █ ▀▄    ▄ █    █  ▄▄▄▄▄      ▄████████  ▄█   ▄█▄  
    █    █ █    █   █  █  █    █ █     ▀▄   ███    ███ ███ ▄███▀  
    █    █ █    █    ▀█   █    █ ▀          ███    █▀  ███▐██▀    
    █    █ █    █    █    █    █  ▀▀▀▀▀▀▄  ▄███▄▄▄     █████▀     
    █    █ █    █   █     █    █ ▀▄▄▄▄▄▄▀ ▀▀███▀▀▀     ███▐██▄    
    █    █ ██████ ▄▀      ██████            ███    █▄  ███ ▀███▄  
     ▀▀▀▀                                   ██████████  ▀       ▀▀ 
                                                                  
    HIROSHI AI - NUXUS ETERNAL V18.0 (CERTIFIED PRO-GRADE)
    THE ULTIMATE RIVALS EXPLOIT FRAMEWORK | GITHUB-READY
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

-- // 1. SYSTEM CONFIGURATION (MEGA TABLE)
getgenv().NuxusEternal = {
    Combat = {
        Enabled = true, SilentAim = false, FOV = 220, Smooth = 1.2, Predict = 0.185,
        Hitbox = "Head", SnapKey = Enum.KeyCode.V, LockKey = Enum.UserInputType.MouseButton2,
        ShowFOV = true, WallCheck = true, AutoShoot = false
    },
    Visuals = {
        Enabled = true, Boxes = true, Skeletons = true, Chams = true,
        Names = true, Health = true, Distance = true, LookTracers = true,
        Thickness = 2, VisCol = Color3.fromRGB(0, 255, 150), InvisCol = Color3.fromRGB(255, 40, 40)
    },
    Weapon = { NoRecoil = true, NoSpread = true, FastReload = true, RapidFire = true },
    Movement = { Speed = 26, Jump = 65, InfJump = true, Bhop = true, Fly = false },
    Atmosphere = { Fullbright = true, CustomTime = 14, FogRemoved = true },
    Config = { MenuKey = Enum.KeyCode.X, BubblePop = true, AnimeVoice = true, Hitmarker = true }
}

-- // 2. AUDIO & FEEDBACK ENGINE (FORCÉ)
local function PlayEffect(id, volume)
    local s = Instance.new("Sound", SService)
    s.SoundId = "rbxassetid://" .. tostring(id)
    s.Volume = volume or 5
    s:Play()
    Debris:AddItem(s, 3)
end

local function TriggerKillVoice()
    if not NuxusEternal.Config.AnimeVoice then return end
    local animeSounds = {138131333, 6047576530, 6835250443, 8565653457}
    PlayEffect(animeSounds[math.random(1, #animeSounds)], 8)
end

local function TriggerBubble()
    if not NuxusEternal.Config.BubblePop then return end
    PlayEffect(6342133423, 6) -- High Definition Bubble Pop
end

-- // 3. MODERN UI LIBRARY (NUXUS ETERNAL)
local GUI_ID = "Nuxus_Eternal_Hub"
if CoreGui:FindFirstChild(GUI_ID) then CoreGui[GUI_ID]:Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = GUI_ID

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 720, 0, 520)
Main.Position = UDim2.new(0.5, -360, 0.5, -260)
Main.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness, Stroke.Color = 2.5, Color3.fromRGB(160, 60, 255)

-- SIDEBAR
local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 200, 1, 0)
Side.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Side.BorderSizePixel = 0
Instance.new("UICorner", Side).CornerRadius = UDim.new(0, 15)

local Logo = Instance.new("TextLabel", Side)
Logo.Size = UDim2.new(1, 0, 0, 100)
Logo.Text = "NUXUS ETERNAL"
Logo.Font, Logo.TextColor3, Logo.TextSize = "GothamBold", Color3.fromRGB(160, 60, 255), 24
Logo.BackgroundTransparency = 1

local TabHolder = Instance.new("Frame", Side)
TabHolder.Size = UDim2.new(1, 0, 1, -120)
TabHolder.Position = UDim2.new(0, 0, 0, 100)
TabHolder.BackgroundTransparency = 1
local TL = Instance.new("UIListLayout", TabHolder) TL.HorizontalAlignment, TL.Padding = "Center", UDim.new(0, 10)

-- CONTENT AREA
local PageContainer = Instance.new("Frame", Main)
PageContainer.Size, PageContainer.Position = UDim2.new(1, -220, 1, -40), UDim2.new(0, 210, 0, 20)
PageContainer.BackgroundTransparency = 1

local Pages = {}

local function NewTab(name, icon)
    local Page = Instance.new("ScrollingFrame", PageContainer)
    Page.Size, Page.BackgroundTransparency, Page.Visible, Page.ScrollBarThickness = UDim2.new(1, 0, 1, 0), 1, false, 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 12)
    
    local Btn = Instance.new("TextButton", TabHolder)
    Btn.Size = UDim2.new(0, 180, 0, 50)
    Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    Btn.Text = "   " .. icon .. "   " .. name
    Btn.Font, Btn.TextColor3, Btn.TextSize = "GothamBold", Color3.fromRGB(200, 200, 200), 14
    Btn.TextXAlignment = "Left"
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)
    
    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
        for _, b in pairs(TabHolder:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(20, 20, 28) end end
        Btn.BackgroundColor3 = Color3.fromRGB(160, 60, 255)
    end)
    Pages[name] = Page return Page
end

local function AddToggle(parent, text, cfg_tab, cfg_key)
    local f = Instance.new("TextButton", parent)
    f.Size, f.BackgroundColor3, f.Text = UDim2.new(1, -5, 0, 55), Color3.fromRGB(18, 18, 25), "     " .. text
    f.Font, f.TextColor3, f.TextSize, f.TextXAlignment = "GothamMedium", Color3.new(1,1,1), 14, "Left"
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
    local ind = Instance.new("Frame", f)
    ind.Size, ind.Position = UDim2.new(0, 42, 0, 22), UDim2.new(1, -55, 0.5, -11)
    ind.BackgroundColor3 = NuxusEternal[cfg_tab][cfg_key] and Color3.fromRGB(160, 60, 255) or Color3.fromRGB(50, 50, 65)
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
    f.MouseButton1Click:Connect(function()
        NuxusEternal[cfg_tab][cfg_key] = not NuxusEternal[cfg_tab][cfg_key]
        TW:Create(ind, TweenInfo.new(0.3), {BackgroundColor3 = NuxusEternal[cfg_tab][cfg_key] and Color3.fromRGB(160, 60, 255) or Color3.fromRGB(50, 50, 65)}):Play()
        TriggerBubble()
    end)
end

-- // 4. REMPLISSAGE DES ONGLETS (INCROYABLEMENT RICHE)
local CombatTab = NewTab("COMBAT", "🎯")
local VisualTab = NewTab("VISUALS", "👁️")
local PlayerTab = NewTab("PLAYER", "🚀")
local WeaponTab = NewTab("WEAPON", "🔫")
local WorldTab  = NewTab("WORLD", "🌍")
local ConfigTab = NewTab("CONFIG", "⚙️")

-- Combat
AddToggle(CombatTab, "Nuxus Aimbot", "Combat", "Enabled")
AddToggle(CombatTab, "Instant Head Snap (V)", "Combat", "Snap")
AddToggle(CombatTab, "Wall-Check Detection", "Combat", "WallCheck")
AddToggle(CombatTab, "Display FOV Circle", "Combat", "ShowFOV")

-- Visuals (LES NOMS SONT ICI !)
AddToggle(VisualTab, "Master Visuals", "Visuals", "Enabled")
AddToggle(VisualTab, "Box ESP Occlusion", "Visuals", "Boxes")
AddToggle(VisualTab, "Pro Skeletons", "Visuals", "Skeletons")
AddToggle(VisualTab, "Show Player Names", "Visuals", "Names")
AddToggle(VisualTab, "Show Distance", "Visuals", "Distance")
AddToggle(VisualTab, "Glow Chams", "Visuals", "Chams")

-- Weapon & Player
AddToggle(WeaponTab, "Zero Recoil Laser", "Weapon", "NoRecoil")
AddToggle(WeaponTab, "Instant Rapid Fire", "Weapon", "RapidFire")
AddToggle(PlayerTab, "Infinite Jump Request", "Movement", "InfJump")
AddToggle(PlayerTab, "Automatic Bhop", "Movement", "Bhop")

-- Config
AddToggle(ConfigTab, "Waifu Kill Voices", "Config", "AnimeVoice")
AddToggle(ConfigTab, "Drip-Bubble Sounds", "Config", "BubblePop")

-- // 5. MOTEUR ESP TOTAL (DRAWING API)
local function DrawText() local t = Drawing.new("Text") t.Size, t.Outline, t.Center, t.Visible = 14, true, true, false return t end
local function DrawLine() local l = Drawing.new("Line") l.Thickness, l.Visible = 1.5, false return l end

local function GetVis(part)
    local hit = workspace:FindPartOnRayWithIgnoreList(Ray.new(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 2000), {LP.Character, Camera})
    return hit and hit:IsDescendantOf(part.Parent)
end

local function ManageESP(p)
    local Box = Drawing.new("Square") Box.Thickness, Box.Visible = 2, false
    local NameTag = DrawText()
    local DistTag = DrawText()
    local Skel = {H2T = DrawLine(), T2LA = DrawLine(), T2RA = DrawLine(), T2LL = DrawLine(), T2RL = DrawLine()}

    RunService.RenderStepped:Connect(function()
        if NuxusEternal.Visuals.Enabled and p.Character and p.Character:FindFirstChild("Head") and p ~= LP then
            local char = p.Character
            local head = char.Head
            local root = char.HumanoidRootPart
            local pos, onS = Camera:WorldToViewportPoint(root.Position)
            local visible = GetVis(head)
            local color = visible and NuxusEternal.Visuals.VisCol or NuxusEternal.Visuals.InvisCol
            
            -- CHAMS
            if NuxusEternal.Visuals.Chams then
                local h = char:FindFirstChild("NuxEternal") or Instance.new("Highlight", char)
                h.Name, h.FillColor, h.FillTransparency = "NuxEternal", color, 0.5
            end

            if onS then
                -- NAMES
                if NuxusEternal.Visuals.Names then
                    NameTag.Text = p.Name
                    NameTag.Position = Vector2.new(pos.X, pos.Y - 50)
                    NameTag.Color, NameTag.Visible = color, true
                else NameTag.Visible = false end

                -- DISTANCE
                if NuxusEternal.Visuals.Distance then
                    DistTag.Text = "[" .. math.floor((root.Position - Camera.CFrame.Position).Magnitude) .. "m]"
                    DistTag.Position = Vector2.new(pos.X, pos.Y + 40)
                    DistTag.Color, DistTag.Visible = Color3.new(1,1,1), true
                else DistTag.Visible = false end

                -- BOXES
                if NuxusEternal.Visuals.Boxes then
                    local h = (Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0)).Y - Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0)).Y)
                    Box.Size, Box.Position, Box.Color, Box.Visible = Vector2.new(h * 0.7, h), Vector2.new(pos.X - (Box.Size.X/2), pos.Y - (Box.Size.Y/2)), color, true
                else Box.Visible = false end

                -- SKELETONS
                if NuxusEternal.Visuals.Skeletons then
                    local function Link(p1, p2, l)
                        local s1, v1 = Camera:WorldToViewportPoint(p1.Position)
                        local s2, v2 = Camera:WorldToViewportPoint(p2.Position)
                        if v1 and v2 then l.From, l.To, l.Color, l.Visible = Vector2.new(s1.X, s1.Y), Vector2.new(s2.X, s2.Y), color, true else l.Visible = false end
                    end
                    Link(head, root, Skel.H2T)
                end
            else Box.Visible, NameTag.Visible, DistTag.Visible = false, false, false end
            
            -- KILL DETECTION
            if char.Humanoid.Health <= 0 and not p:FindFirstChild("NuxDead") then
                Instance.new("BoolValue", p).Name = "NuxDead"
                TriggerKillVoice()
            end
        else
            Box.Visible, NameTag.Visible, DistTag.Visible = false, false, false
            if p.Character and p.Character:FindFirstChild("NuxEternal") then p.Character.NuxEternal:Destroy() end
        end
    end)
end

-- // 6. FINAL ENGINE (AIMBOT & PERFORMANCE)
local FOV_Circle = Drawing.new("Circle")
FOV_Circle.Thickness, FOV_Circle.Color = 1, Color3.fromRGB(160, 60, 255)

RunService.RenderStepped:Connect(function()
    FOV_Circle.Visible = NuxusEternal.Combat.ShowFOV and NuxusEternal.Combat.Enabled
    FOV_Circle.Radius, FOV_Circle.Position = NuxusEternal.Combat.FOV, UIS:GetMouseLocation()
    
    if NuxusEternal.Atmosphere.Fullbright then Lighting.Brightness = 2 end
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = NuxusEternal.Movement.Speed
    end

    if NuxusEternal.Combat.Enabled and UIS:IsMouseButtonPressed(NuxusEternal.Combat.LockKey) then
        local t, bDist = nil, NuxusEternal.Combat.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
                local pos, onS = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if onS then
                    local d = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
                    if d < bDist then t, bDist = p, d end
                end
            end
        end
        if t then
            local head = t.Character.Head
            local screenPos = Camera:WorldToViewportPoint(head.Position + (head.Velocity * NuxusEternal.Combat.Predict))
            mousemoverel((screenPos.X - Mouse.X)/NuxusEternal.Combat.Smooth, (screenPos.Y - Mouse.Y)/NuxusEternal.Combat.Smooth)
        end
    end
end)

-- TOUCHE X ET SNAP V
UIS.InputBegan:Connect(function(i)
    if i.KeyCode == NuxusEternal.Config.MenuKey then Main.Visible = not Main.Visible end
    if i.KeyCode == Enum.KeyCode.Space and NuxusEternal.Movement.InfJump then LP.Character.Humanoid:ChangeState(3) end
    if i.KeyCode == NuxusEternal.Combat.SnapKey and NuxusEternal.Combat.Enabled then
        local t, d = nil, 500
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
                local mD = (p.Character.Head.Position - Camera.CFrame.Position).Magnitude
                if mD < d then t, d = p, mD end
            end
        end
        if t then
            local sp = Camera:WorldToViewportPoint(t.Character.Head.Position)
            mousemoverel(sp.X - Mouse.X, sp.Y - Mouse.Y)
            TriggerBubble()
            if mouse1click then mouse1click() end
        end
    end
end)

-- INITIALISATION
for _, p in pairs(Players:GetPlayers()) do ManageESP(p) end
Players.PlayerAdded:Connect(ManageESP)
Pages["COMBAT"].Visible = true
print("NUXUS ETERNAL V18 LOADED - THE GOD OF RIVALS")
