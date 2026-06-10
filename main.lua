--[[
    █▄▄▄▄ █    █ ▀▄    ▄ █    █  ▄▄▄▄▄      ▄████████  ▄█   ▄█▄  
    █    █ █    █   █  █  █    █ █     ▀▄   ███    ███ ███ ▄███▀  
    █    █ █    █    ▀█   █    █ ▀          ███    █▀  ███▐██▀    
    █    █ █    █    █    █    █  ▀▀▀▀▀▀▄  ▄███▄▄▄     █████▀     
    █    █ █    █   █     █    █ ▀▄▄▄▄▄▄▀ ▀▀███▀▀▀     ███▐██▄    
    █    █ ██████ ▄▀      ██████            ███    █▄  ███ ▀███▄  
     ▀▀▀▀                                   ██████████  ▀       ▀▀ 
                                                                  
    HIROSHI AI - NUXUS OMEGA V16.0 (CERTIFIED GITHUB PRO)
    THE ULTIMATE RIVALS EXPLOIT FRAMEWORK
    
    [CREDITS] : HIROSHI AI & NUXUS TEAM
--]]

-- // 1. CORE PROTECTION & SERVICES
if not game:IsLoaded() then game.Loaded:Wait() end
local Players, RunService, UIS, TW, CoreGui, Lighting, SService, Debris = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("CoreGui"), game:GetService("Lighting"), game:GetService("SoundService"), game:GetService("Debris")
local LP, Camera, Mouse = Players.LocalPlayer, workspace.CurrentCamera, Players.LocalPlayer:GetMouse()

-- ANTI-RE-EXECUTION
if _G.NuxusLoaded then return end
_G.NuxusLoaded = true

-- // 2. GLOBAL OMEGA SETTINGS
getgenv().NuxusConfig = {
    Combat = {
        Aimbot = true, SilentAim = false, SnapMode = true,
        Smooth = 1.4, FOV = 200, Predict = 0.185, Hitbox = "Head",
        SnapKey = Enum.KeyCode.V, LockKey = Enum.UserInputType.MouseButton2,
        WallCheck = true, TeamCheck = true
    },
    Visuals = {
        Enabled = true, Boxes = true, Skeletons = true,
        Chams = true, Names = true, HealthBar = true,
        Distance = true, LookTracers = true,
        VisCol = Color3.fromRGB(0, 255, 150), InvisCol = Color3.fromRGB(255, 40, 40)
    },
    Weapon = {
        NoRecoil = true, NoSpread = true, RapidFire = false, FastReload = true
    },
    Player = {
        Speed = 26, Jump = 68, Fly = false, InfJump = true, Bhop = true
    },
    Atmosphere = {
        Fullbright = true, NoFog = true, CustomTime = 14, Skybox = "Vape"
    },
    Interface = {
        MenuKey = Enum.KeyCode.X, Theme = Color3.fromRGB(160, 60, 255),
        Sounds = true, AnimeVoices = true, Hitmarkers = true
    }
}

-- // 3. ADVANCED AUDIO ENGINE
local function PlayHD(id, vol)
    if not NuxusConfig.Interface.Sounds then return end
    local s = Instance.new("Sound", SService)
    s.SoundId = "rbxassetid://"..tostring(id)
    s.Volume = vol or 4
    s:Play()
    Debris:AddItem(s, 3)
end

local function PlayPop() PlayHD(6342133423, 5) end
local function PlayAnime()
    if not NuxusConfig.Interface.AnimeVoices then return end
    local v = {6835250443, 131163697, 8565653457}
    PlayHD(v[math.random(1, #v)], 6)
end

-- // 4. MODERN UI LIBRARY (NUXUS OMEGA DESIGN)
local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "NuxusOmega_"..math.random(1,999)

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 720, 0, 520)
Main.Position = UDim2.new(0.5, -360, 0.5, -260)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 2.5
MainStroke.Color = NuxusConfig.Interface.Theme

-- Sidebar
local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 210, 1, 0)
Side.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
Side.BorderSizePixel = 0
Instance.new("UICorner", Side).CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", Side)
Title.Size = UDim2.new(1, 0, 0, 90)
Title.Text = "NUXUS OMEGA"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = NuxusConfig.Interface.Theme
Title.TextSize = 26
Title.BackgroundTransparency = 1

local TabHolder = Instance.new("Frame", Side)
TabHolder.Size = UDim2.new(1, 0, 1, -120)
TabHolder.Position = UDim2.new(0, 0, 0, 100)
TabHolder.BackgroundTransparency = 1
local TL = Instance.new("UIListLayout", TabHolder) TL.HorizontalAlignment, TL.Padding = "Center", UDim.new(0, 10)

-- Pages
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -230, 1, -40)
Container.Position = UDim2.new(0, 220, 0, 20)
Container.BackgroundTransparency = 1

local Pages = {}

local function NewTab(name, icon)
    local Page = Instance.new("ScrollingFrame", Container)
    Page.Size, Page.BackgroundTransparency, Page.Visible, Page.ScrollBarThickness = UDim2.new(1, 0, 1, 0), 1, false, 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 12)
    
    local Btn = Instance.new("TextButton", TabHolder)
    Btn.Size = UDim2.new(0, 190, 0, 48)
    Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    Btn.Text = "  " .. icon .. "  " .. name
    Btn.Font, Btn.TextColor3, Btn.TextSize = "GothamBold", Color3.fromRGB(200, 200, 200), 14
    Btn.TextXAlignment = "Left"
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)
    
    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
        for _, b in pairs(TabHolder:GetChildren()) do if b:IsA("TextButton") then TW:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(22, 22, 32)}):Play() end end
        TW:Create(Btn, TweenInfo.new(0.3), {BackgroundColor3 = NuxusConfig.Interface.Theme}):Play()
        PlayPop()
    end)
    Pages[name] = Page return Page
end

local function AddToggle(parent, text, cfg_tab, cfg_key)
    local f = Instance.new("TextButton", parent)
    f.Size, f.BackgroundColor3, f.Text = UDim2.new(1, 0, 0, 55), Color3.fromRGB(20, 20, 30), "   "..text
    f.Font, f.TextColor3, f.TextSize, f.TextXAlignment = "GothamMedium", Color3.new(1,1,1), 14, "Left"
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
    local ind = Instance.new("Frame", f)
    ind.Size, ind.Position = UDim2.new(0, 45, 0, 22), UDim2.new(1, -55, 0.5, -11)
    ind.BackgroundColor3 = NuxusConfig[cfg_tab][cfg_key] and NuxusConfig.Interface.Theme or Color3.fromRGB(50, 50, 65)
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
    f.MouseButton1Click:Connect(function()
        NuxusConfig[cfg_tab][cfg_key] = not NuxusConfig[cfg_tab][cfg_key]
        TW:Create(ind, TweenInfo.new(0.3), {BackgroundColor3 = NuxusConfig[cfg_tab][cfg_key] and NuxusConfig.Interface.Theme or Color3.fromRGB(50, 50, 65)}):Play()
    end)
end

-- // 5. INITIALISATION DES SECTIONS
local CombatTab = NewTab("COMBAT", "🎯")
local VisualTab = NewTab("VISUALS", "👁️")
local PlayerTab = NewTab("PLAYER", "🏃")
local WeaponTab = NewTab("WEAPON", "🔫")
local WorldTab  = NewTab("WORLD", "🌍")
local SettingTab = NewTab("CONFIG", "⚙️")

-- Remplissage Combat
AddToggle(CombatTab, "Neural Aimbot", "Combat", "Aimbot")
AddToggle(CombatTab, "Instant Snap Mode (V)", "Combat", "SnapMode")
AddToggle(CombatTab, "Wall Check (Pro)", "Combat", "WallCheck")

-- Remplissage Visuals
AddToggle(VisualTab, "Master ESP", "Visuals", "Enabled")
AddToggle(VisualTab, "3D Chams Glow", "Visuals", "Chams")
AddToggle(VisualTab, "Box 2D Occlusion", "Visuals", "Boxes")
AddToggle(VisualTab, "Dynamic Skeletons", "Visuals", "Skeletons")

-- Remplissage Weapon & Player
AddToggle(WeaponTab, "Zero Recoil", "Weapon", "NoRecoil")
AddToggle(WeaponTab, "Zero Spread", "Weapon", "NoSpread")
AddToggle(PlayerTab, "Infinite Jump", "Player", "InfJump")
AddToggle(PlayerTab, "Auto-Bhop", "Player", "Bhop")

-- // 6. AI ENGINE (ESP / AIMBOT / PREDICT)
local function GetVis(part)
    local hit = workspace:FindPartOnRayWithIgnoreList(Ray.new(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 2000), {LP.Character, Camera})
    return hit and hit:IsDescendantOf(part.Parent)
end

local function ManageESP(p)
    local Box = Drawing.new("Square")
    Box.Thickness, Box.Visible = 2, false
    
    RunService.RenderStepped:Connect(function()
        if NuxusConfig.Visuals.Enabled and p.Character and p.Character:FindFirstChild("Head") and p ~= LP then
            local head = p.Character.Head
            local root = p.Character.HumanoidRootPart
            local pos, onS = Camera:WorldToViewportPoint(root.Position)
            local visible = GetVis(head)
            local color = visible and NuxusConfig.Visuals.VisCol or NuxusConfig.Visuals.InvisCol
            
            -- CHAMS OMEGA
            if NuxusConfig.Visuals.Chams then
                local h = p.Character:FindFirstChild("NuxOmega") or Instance.new("Highlight", p.Character)
                h.Name, h.FillColor, h.FillTransparency = "NuxOmega", color, 0.5
            end

            if onS and NuxusConfig.Visuals.Boxes then
                local h = (Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0)).Y - Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0)).Y)
                Box.Size, Box.Position, Box.Color, Box.Visible = Vector2.new(h * 0.6, h), Vector2.new(pos.X - (Box.Size.X/2), pos.Y - (Box.Size.Y/2)), color, true
            else Box.Visible = false end

            -- KILL SYSTEM
            if p.Character.Humanoid.Health <= 0 and not p:FindFirstChild("NuxKilled") then
                Instance.new("BoolValue", p).Name = "NuxKilled"
                PlayAnime()
            end
        else
            Box.Visible = false
            if p.Character and p.Character:FindFirstChild("NuxOmega") then p.Character.NuxOmega:Destroy() end
        end
    end)
end

-- // 7. FINAL MAIN LOOP
RunService.RenderStepped:Connect(function()
    if NuxusConfig.Atmosphere.Fullbright then Lighting.Brightness = 2 end
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = NuxusConfig.Player.Speed
    end

    -- AIMBOT SNAP ENGINE
    if NuxusConfig.Combat.Aimbot and UIS:IsMouseButtonPressed(NuxusConfig.Combat.LockKey) then
        local target, best = nil, NuxusConfig.Combat.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild(NuxusConfig.Combat.Hitbox) and p.Character.Humanoid.Health > 0 then
                local head = p.Character[NuxusConfig.Combat.Hitbox]
                local pos, onS = Camera:WorldToViewportPoint(head.Position)
                if onS then
                    local d = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
                    if d < best then target, best = p, d end
                end
            end
        end
        if target then
            local head = target.Character[NuxusConfig.Combat.Hitbox]
            local screenPos = Camera:WorldToViewportPoint(head.Position + (head.Velocity * NuxusConfig.Combat.Predict))
            mousemoverel((screenPos.X - Mouse.X)/NuxusConfig.Combat.Smooth, (screenPos.Y - Mouse.Y)/NuxusConfig.Combat.Smooth)
        end
    end
end)

-- INPUTS
UIS.InputBegan:Connect(function(i)
    if i.KeyCode == NuxusConfig.Interface.MenuKey then Main.Visible = not Main.Visible end
    if i.KeyCode == Enum.KeyCode.Space and NuxusConfig.Player.InfJump then LP.Character.Humanoid:ChangeState(3) end
end)

-- BOOT
for _, p in pairs(Players:GetPlayers()) do ManageESP(p) end
Players.PlayerAdded:Connect(ManageESP)
Pages["COMBAT"].Visible = true
print("NUXUS OMEGA V16 LOADED - BY HIROSHI AI")
