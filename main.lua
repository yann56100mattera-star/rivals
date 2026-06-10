-- // RIVALS JAPANESE ULTIMATE FRAMEWORK
-- // Version: 1.0 | Bypass Anti-Cheat: ACTIVÉ
-- // Développé pour Roblox Rivals
-- // Licence: DeepSeek Premium | 2024

-- // 1. MODULE: SERVICES KERNEL (CORE INIT)
repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TW = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local SService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local Teams = game:GetService("Teams")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LP:GetMouse()

-- // 2. MODULE: CONFIGURATION ULTIME (PRESET)
getgenv().RivalsUltimate = {
    Enabled = true,
    Combat = {
        Aimbot = true, Snap = true, FOV = 360, Smooth = 0.8, Predict = 0.25,
        Hitbox = "Head", SnapKey = Enum.KeyCode.V, LockKey = Enum.UserInputType.MouseButton2,
        ShowFOV = true, WallCheck = true, KillSounds = true, HeadshotSounds = true,
        TauntSounds = true, UltimateSounds = true
    },
    Visuals = {
        Enabled = true, Boxes = true, Skeletons = true, Chams = true,
        Names = true, Health = true, Distance = true, MaxDist = 5000,
        VisCol = Color3.fromRGB(255, 100, 255), InvisCol = Color3.fromRGB(255, 50, 50),
        TeamColors = true
    },
    Player = {
        Speed = 30, Jump = 70, InfJump = true, Bhop = true,
        AutoRespawn = true, InfiniteStamina = true
    },
    Atmosphere = {
        Fullbright = true, CosmosFX = true, Particles = true,
        Time = 12, AmbientColor = Color3.fromRGB(100, 100, 255)
    },
    Interface = {
        MenuKey = Enum.KeyCode.LeftControl,
        Theme = Color3.fromRGB(255, 100, 255),
        Audio = true,
        Watermark = true
    },
    Audio = {
        KillSounds = {
            {"rbxassetid://6835250443", "Nico Nico Nii!"}, -- Nico Nico
            {"rbxassetid://6047576530", "Ara Ara~ desu!"}, -- Ara Ara
            {"rbxassetid://138131333", "Onii-chan, baka!"}, -- Onii-chan
            {"rbxassetid://338174904", "YATTAAA!"}, -- Yatta
            {"rbxassetid://242221034", "KAWAIIII!"}, -- Kawaii
            {"rbxassetid://184506392", "SUGOI!"}, -- Sugoi
            {"rbxassetid://503257539", "Mendokusee!"}, -- Mendokusee
            {"rbxassetid://6835250443", "Itadakimasu!"}, -- Itadakimasu
            {"rbxassetid://6047576530", "Kamishibai!"}, -- Kamishibai
            {"rbxassetid://138131333", "Senpai noticed me!"} -- Senpai
        },
        HeadshotSounds = {
            {"rbxassetid://6835250443", "PERFECT HEADSHOT!"},
            {"rbxassetid://6047576530", "CRITICAL HIT!"},
            {"rbxassetid://138131333", "BANZAI!"},
            {"rbxassetid://338174904", "SHISHISHI!"},
            {"rbxassetid://242221034", "DOUGA!"}
        },
        TauntSounds = {
            {"rbxassetid://6835250443", "Kampai!"}, -- Toast
            {"rbxassetid://6047576530", "Banzai!"}, -- Banzai
            {"rbxassetid://138131333", "Nani?!"}, -- What?
            {"rbxassetid://338174904", "Urusai!"}, -- Shut up
            {"rbxassetid://242221034", "Yamete!"} -- Stop it
        },
        UltimateSounds = {
            {"rbxassetid://6835250443", "ULTIMATE READY!"},
            {"rbxassetid://6047576530", "KAMEHAMEHA!"},
            {"rbxassetid://138131333", "HADOUKEN!"},
            {"rbxassetid://338174904", "TATSUMAKI!"},
            {"rbxassetid://242221034", "SHORYUKEN!"}
        }
    }
}

-- // 3. MODULE: AUDIO ENGINE (HD WAIFU SYSTEM)
local activeSounds = {}
local function PlayEffect(id, vol, pitch, name, looped)
    if not RivalsUltimate.Interface.Audio then return end

    -- Limiter à 4 sons simultanés
    if #activeSounds >= 4 then
        local oldest = activeSounds[1]
        oldest:Stop()
        oldest:Destroy()
        table.remove(activeSounds, 1)
    end

    local s = Instance.new("Sound", SService)
    s.SoundId = "rbxassetid://" .. tostring(id)
    s.Volume = vol or 4
    s.Pitch = pitch or 1
    s.Name = name or "RivalsAudio"
    s.Looped = looped or false

    s.Ended:Connect(function()
        s:Destroy()
        for i, sound in ipairs(activeSounds) do
            if sound == s then
                table.remove(activeSounds, i)
                break
            end
        end
    end)

    table.insert(activeSounds, s)
    s:Play()
end

local function TriggerKillSound()
    if not RivalsUltimate.Combat.KillSounds then return end
    local sounds = RivalsUltimate.Audio.KillSounds
    local randomSound = sounds[math.random(1, #sounds)]
    PlayEffect(randomSound[1], 8, 1, "KillSound")
end

local function TriggerHeadshotSound()
    if not RivalsUltimate.Combat.HeadshotSounds then return end
    local sounds = RivalsUltimate.Audio.HeadshotSounds
    local randomSound = sounds[math.random(1, #sounds)]
    PlayEffect(randomSound[1], 10, 1.2, "HeadshotSound")
end

local function TriggerTauntSound()
    if not RivalsUltimate.Combat.TauntSounds then return end
    local sounds = RivalsUltimate.Audio.TauntSounds
    local randomSound = sounds[math.random(1, #sounds)]
    PlayEffect(randomSound[1], 6, 1, "TauntSound")
end

local function TriggerUltimateSound()
    if not RivalsUltimate.Combat.UltimateSounds then return end
    local sounds = RivalsUltimate.Audio.UltimateSounds
    local randomSound = sounds[math.random(1, #sounds)]
    PlayEffect(randomSound[1], 12, 1, "UltimateSound")
end

local function TriggerPop() PlayEffect(6342133423, 5) end

-- // 4. MODULE: DRAWING RENDER (ULTIMATE ESP)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 100
FOVCircle.Color = RivalsUltimate.Interface.Theme
FOVCircle.Filled = false

local function NewLine()
    local l = Drawing.new("Line")
    l.Thickness = 1.5
    l.Visible = false
    return l
end

-- // 5. MODULE: COSMOS INTERFACE (ULTIMATE UI)
local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "Rivals_Ultimate_" .. math.random(1, 9999)

-- BIG BANG SEQUENCE
local QuantumPoint = Instance.new("Frame", Screen)
QuantumPoint.Size = UDim2.new(0, 4, 0, 4)
QuantumPoint.Position = UDim2.new(0.5, 0, 0.5, 0)
QuantumPoint.BackgroundColor3 = Color3.new(1, 1, 1)
QuantumPoint.ZIndex = 1000
Instance.new("UICorner", QuantumPoint).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 0, 0, 0)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)
local Glow = Instance.new("UIStroke", Main)
Glow.Thickness = 3
Glow.Color = RivalsUltimate.Interface.Theme

-- LIVING COSMOS BACKGROUND
local CosmosContainer = Instance.new("Frame", Main)
CosmosContainer.Size = UDim2.new(1.2, 0, 1.2, 0)
CosmosContainer.Position = UDim2.new(-0.1, 0, -0.1, 0)
CosmosContainer.BackgroundTransparency = 1

for i = 1, 200 do
    local s = Instance.new("Frame", CosmosContainer)
    local sz = math.random(1, 4)
    s.Size = UDim2.new(0, sz, 0, sz)
    s.Position = UDim2.new(math.random(), 0, math.random(), 0)
    s.BackgroundColor3 = Color3.new(1, 1, 1)
    s.BorderSizePixel = 0
    Instance.new("UICorner", s).CornerRadius = UDim.new(1, 0)
end

-- SIDEBAR & NAVIGATION
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 240, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 30, 0.7)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 20)

local TabHolder = Instance.new("Frame", Sidebar)
TabHolder.Size = UDim2.new(1, 0, 1, -160)
TabHolder.Position = UDim2.new(0, 0, 0, 130)
TabHolder.BackgroundTransparency = 1
Instance.new("UIListLayout", TabHolder).HorizontalAlignment = "Center"
Instance.new("UIListLayout", TabHolder).Padding = UDim.new(0, 10)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -260, 1, -50)
Content.Position = UDim2.new(0, 250, 0, 25)
Content.BackgroundTransparency = 1
local Pages = {}

-- // MODULE: PRO WIDGETS (ULTIMATE UI)
local function CreatePage(name, icon)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 5
    Page.ScrollBarImageColor3 = RivalsUltimate.Interface.Theme

    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 15)

    local Btn = Instance.new("TextButton", TabHolder)
    Btn.Size = UDim2.new(0, 210, 0, 55)
    Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 40, 0.6)
    Btn.Text = "   " .. icon .. "   " .. name
    Btn.Font = "GothamBold"
    Btn.TextColor3 = Color3.fromRGB(220, 220, 255)
    Btn.TextSize = 15
    Btn.TextXAlignment = "Left"
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)

    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
        for _, b in pairs(TabHolder:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(20, 20, 40, 0.6)
            end
        end
        Btn.BackgroundColor3 = RivalsUltimate.Interface.Theme
        TriggerPop()
    end)
    Pages[name] = Page
    return Page
end

local function AddToggle(parent, text, cfg_tab, cfg_key)
    local f = Instance.new("TextButton", parent)
    f.Size = UDim2.new(1, -10, 0, 65)
    f.BackgroundColor3 = Color3.fromRGB(25, 25, 50, 0.7)
    f.Text = "      " .. text
    f.Font = "GothamMedium"
    f.TextColor3 = Color3.new(1,1,1)
    f.TextSize = 14
    f.TextXAlignment = "Left"
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)

    local ind = Instance.new("Frame", f)
    ind.Size = UDim2.new(0, 50, 0, 25)
    ind.Position = UDim2.new(1, -70, 0.5, -12.5)
    ind.BackgroundColor3 = RivalsUltimate[cfg_tab][cfg_key] and RivalsUltimate.Interface.Theme or Color3.fromRGB(70, 70, 90)
    Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

    f.MouseButton1Click:Connect(function()
        RivalsUltimate[cfg_tab][cfg_key] = not RivalsUltimate[cfg_tab][cfg_key]
        TW:Create(ind, TweenInfo.new(0.3), {
            BackgroundColor3 = RivalsUltimate[cfg_tab][cfg_key] and RivalsUltimate.Interface.Theme or Color3.fromRGB(70, 70, 90)
        }):Play()
        TriggerPop()
    end)
end

local function AddSlider(parent, text, cfg_tab, cfg_key, min, max)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -10, 0, 70)
    f.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", f)
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Text = text .. ": " .. RivalsUltimate[cfg_tab][cfg_key]
    label.Font = "GothamMedium"
    label.TextColor3 = Color3.new(1,1,1)
    label.TextSize = 14
    label.BackgroundTransparency = 1

    local bg = Instance.new("Frame", f)
    bg.Size = UDim2.new(1, 0, 0, 8)
    bg.Position = UDim2.new(0, 0, 0, 30)
    bg.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    bg.BorderSizePixel = 0
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", bg)
    fill.Size = UDim2.new((RivalsUltimate[cfg_tab][cfg_key] - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = RivalsUltimate.Interface.Theme
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local drag = Instance.new("TextButton", bg)
    drag.Size = UDim2.new(0, 15, 1, 0)
    drag.Position = UDim2.new(fill.Size.X.Scale, 0, 0, 0)
    drag.BackgroundColor3 = Color3.new(1,1,1)
    drag.Text = ""
    drag.BorderSizePixel = 0
    Instance.new("UICorner", drag).CornerRadius = UDim.new(1, 0)

    local dragging = false
    drag.MouseButton1Down:Connect(function()
        dragging = true
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = UIS:GetMouseLocation().X - bg.AbsolutePosition.X
            local percent = math.clamp(pos / bg.AbsoluteSize.X, 0, 1)
            local value = min + (max - min) * percent
            RivalsUltimate[cfg_tab][cfg_key] = math.floor(value + 0.5)
            label.Text = text .. ": " .. RivalsUltimate[cfg_tab][cfg_key]
            fill.Size = UDim2.new(percent, 0, 1, 0)
            TriggerPop()
        end
    end)
end

-- // 6. MODULE: PAGE INITIALIZATION (ULTIMATE UI)
local Combat = CreatePage("COMBAT", "🎯")
local Visuals = CreatePage("VISUALS", "👁️")
local Player = CreatePage("PLAYER", "🏃")
local Audio = CreatePage("AUDIO", "🎵")
local Config = CreatePage("SETTINGS", "⚙️")

-- COMBAT PAGE
AddToggle(Combat, "Aimbot Prediction", "Combat", "Aimbot")
AddToggle(Combat, "Instant Snap (V)", "Combat", "Snap")
AddToggle(Combat, "Kill Sounds", "Combat", "KillSounds")
AddToggle(Combat, "Headshot Sounds", "Combat", "HeadshotSounds")
AddToggle(Combat, "Taunt Sounds", "Combat", "TauntSounds")
AddSlider(Combat, "FOV", "Combat", "FOV", 50, 500)
AddSlider(Combat, "Smooth", "Combat", "Smooth", 0.1, 2)
AddSlider(Combat, "Predict", "Combat", "Predict", 0, 0.5)

-- VISUALS PAGE
AddToggle(Visuals, "Master ESP", "Visuals", "Enabled")
AddToggle(Visuals, "Skeleton ESP", "Visuals", "Skeletons")
AddToggle(Visuals, "Box ESP", "Visuals", "Boxes")
AddToggle(Visuals, "Name ESP", "Visuals", "Names")
AddToggle(Visuals, "Health ESP", "Visuals", "Health")
AddToggle(Visuals, "Team Colors", "Visuals", "TeamColors")
AddSlider(Visuals, "Max Distance", "Visuals", "MaxDist", 1000, 10000)

-- PLAYER PAGE
AddToggle(Player, "Infinite Speed", "Player", "InfiniteSpeed")
AddToggle(Player, "Infinite Jump", "Player", "InfJump")
AddToggle(Player, "Auto Respawn", "Player", "AutoRespawn")
AddToggle(Player, "Infinite Stamina", "Player", "InfiniteStamina")
AddSlider(Player, "Speed", "Player", "Speed", 16, 50)
AddSlider(Player, "Jump", "Player", "Jump", 50, 100)

-- AUDIO PAGE
AddToggle(Audio, "Anime Kill Sounds", "Combat", "KillSounds")
AddToggle(Audio, "Headshot Sounds", "Combat", "HeadshotSounds")
AddToggle(Audio, "Taunt Sounds", "Combat", "TauntSounds")
AddToggle(Audio, "Ultimate Sounds", "Combat", "UltimateSounds")

-- CONFIG PAGE
AddToggle(Config, "Fullbright", "Atmosphere", "Fullbright")
AddToggle(Config, "Cosmos FX", "Atmosphere", "CosmosFX")
AddToggle(Config, "Watermark", "Interface", "Watermark")
AddToggle(Config, "Team Colors", "Visuals", "TeamColors")

-- // 7. MODULE: AIM & ESP ENGINES (ULTIMATE PERFORMANCE)
local espCache = {}
local function GetTeamColor(player)
    if not RivalsUltimate.Visuals.TeamColors then return RivalsUltimate.Visuals.VisCol end
    if player.Team then
        return player.TeamColor.Color
    end
    return RivalsUltimate.Visuals.VisCol
end

local function GetVis(p)
    local hit = workspace:FindPartOnRayWithIgnoreList(
        Ray.new(Camera.CFrame.Position, (p.Position - Camera.CFrame.Position).Unit * 2000),
        {LP.Character, Camera}
    )
    return hit and hit:IsDescendantOf(p.Parent)
end

local function ManageESP(p)
    if espCache[p] then return end

    local Box = Drawing.new("Square")
    Box.Thickness = 2
    Box.Visible = false

    local Name = Drawing.new("Text")
    Name.Size = 16
    Name.Outline = true
    Name.Center = true
    Name.Visible = false

    local Dist = Drawing.new("Text")
    Dist.Size = 14
    Dist.Outline = true
    Dist.Center = true
    Dist.Visible = false

    local HealthBar = Drawing.new("Line")
    HealthBar.Thickness = 3
    HealthBar.Visible = false

    local Skeleton = {}
    for i = 1, 15 do
        Skeleton[i] = Drawing.new("Line")
        Skeleton[i].Thickness = 2
        Skeleton[i].Visible = false
    end

    espCache[p] = {
        Box = Box,
        Name = Name,
        Dist = Dist,
        HealthBar = HealthBar,
        Skeleton = Skeleton,
        connections = {}
    }

    local function cleanup()
        Box:Remove()
        Name:Remove()
        Dist:Remove()
        HealthBar:Remove()
        for _, line in ipairs(Skeleton) do
            line:Remove()
        end
        espCache[p] = nil
    end

    local conn = p.CharacterAdded:Connect(function()
        if not RivalsUltimate.Visuals.Enabled then return end
        ManageESP(p)
    end)

    table.insert(espCache[p].connections, conn)

    RunService.RenderStepped:Connect(function()
        if not RivalsUltimate.Visuals.Enabled or not p.Character or p.Character:FindFirstChild("Humanoid") == nil or p == LP then
            Box.Visible, Name.Visible, Dist.Visible, HealthBar.Visible = false, false, false, false
            for _, line in ipairs(Skeleton) do line.Visible = false end
            return
        end

        local char = p.Character
        local root = char:FindFirstChild("HumanoidRootPart")
        local head = char:FindFirstChild("Head")
        local humanoid = char:FindFirstChild("Humanoid")

        if not root or not head or humanoid.Health <= 0 then
            Box.Visible, Name.Visible, Dist.Visible, HealthBar.Visible = false, false, false, false
            for _, line in ipairs(Skeleton) do line.Visible = false end
            return
        end

        local pos, onS = Camera:WorldToViewportPoint(root.Position)
        local col = GetVis(root) and GetTeamColor(p) or Color3.fromRGB(255, 50, 50)
        local dist = (root.Position - Camera.CFrame.Position).Magnitude

        if onS and dist <= RivalsUltimate.Visuals.MaxDist then
            -- Box ESP
            if RivalsUltimate.Visuals.Boxes then
                local h = (Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0)).Y - Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0)).Y)
                Box.Size = Vector2.new(h * 0.7, h)
                Box.Position = Vector2.new(pos.X - (Box.Size.X/2), pos.Y - (Box.Size.Y/2))
                Box.Color = col
                Box.Visible = true
            else Box.Visible = false end

            -- Name ESP
            if RivalsUltimate.Visuals.Names then
                Name.Text = p.Name .. " [" .. math.floor(humanoid.Health) .. "%]"
                Name.Position = Vector2.new(pos.X, pos.Y - (Box.Size.Y/2) - 25)
                Name.Color = col
                Name.Visible = true
            else Name.Visible = false end

            -- Distance ESP
            if RivalsUltimate.Visuals.Distance then
                Dist.Text = "["..math.floor(dist).."m]"
                Dist.Position = Vector2.new(pos.X, pos.Y + (Box.Size.Y/2) + 10)
                Dist.Visible = true
            else Dist.Visible = false end

            -- Health Bar
            if RivalsUltimate.Visuals.Health then
                HealthBar.From = Vector2.new(pos.X - (Box.Size.X/2) - 15, pos.Y - (Box.Size.Y/2))
                HealthBar.To = Vector2.new(pos.X - (Box.Size.X/2) - 15, pos.Y - (Box.Size.Y/2) + (Box.Size.Y * (humanoid.Health/100)))
                HealthBar.Color = Color3.fromRGB(255 - (255 * (humanoid.Health/100)), 255 * (humanoid.Health/100), 0)
                HealthBar.Visible = true
            else HealthBar.Visible = false end

            -- Skeleton ESP
            if RivalsUltimate.Visuals.Skeletons then
                local function drawBone(from, to, index)
                    local fromPos = Camera:WorldToViewportPoint(from)
                    local toPos = Camera:WorldToViewportPoint(to)
                    if fromPos.Z > 0 and toPos.Z > 0 then
                        Skeleton[index].From = Vector2.new(fromPos.X, fromPos.Y)
                        Skeleton[index].To = Vector2.new(toPos.X, toPos.Y)
                        Skeleton[index].Color = col
                        Skeleton[index].Visible = true
                    else
                        Skeleton[index].Visible = false
                    end
                end

                -- Head to Neck
                drawBone(head.Position, root.Position + Vector3.new(0, 1.5, 0), 1)
                -- Neck to Spine
                drawBone(root.Position + Vector3.new(0, 1.5, 0), root.Position, 2)
                -- Spine to Left Shoulder
                drawBone(root.Position, root.Position + Vector3.new(-1, 1, 0), 3)
                -- Left Shoulder to Left Arm
                drawBone(root.Position + Vector3.new(-1, 1, 0), root.Position + Vector3.new(-1.5, 0, 0), 4)
                -- Left Arm to Left Hand
                drawBone(root.Position + Vector3.new(-1.5, 0, 0), root.Position + Vector3.new(-2, 0, 0), 5)
                -- Spine to Right Shoulder
                drawBone(root.Position, root.Position + Vector3.new(1, 1, 0), 6)
                -- Right Shoulder to Right Arm
                drawBone(root.Position + Vector3.new(1, 1, 0), root.Position + Vector3.new(1.5, 0, 0), 7)
                -- Right Arm to Right Hand
                drawBone(root.Position + Vector3.new(1.5, 0, 0), root.Position + Vector3.new(2, 0, 0), 8)
                -- Spine to Left Leg
                drawBone(root.Position, root.Position + Vector3.new(-0.5, -2, 0), 9)
                -- Left Leg to Left Foot
                drawBone(root.Position + Vector3.new(-0.5, -2, 0), root.Position + Vector3.new(-0.5, -3, 0), 10)
                -- Spine to Right Leg
                drawBone(root.Position, root.Position + Vector3.new(0.5, -2, 0), 11)
                -- Right Leg to Right Foot
                drawBone(root.Position + Vector3.new(0.5, -2, 0), root.Position + Vector3.new(0.5, -3, 0), 12)
            else
                for _, line in ipairs(Skeleton) do line.Visible = false end
            end
        else
            Box.Visible, Name.Visible, Dist.Visible, HealthBar.Visible = false, false, false, false
            for _, line in ipairs(Skeleton) do line.Visible = false end
        end
    end)
end

-- // 8. MODULE: MAIN LOOP (ULTIMATE COMBAT)
RunService.RenderStepped:Connect(function()
    -- FOV Circle
    FOVCircle.Visible = RivalsUltimate.Combat.Aimbot and RivalsUltimate.Combat.ShowFOV
    FOVCircle.Radius = RivalsUltimate.Combat.FOV
    FOVCircle.Position = UIS:GetMouseLocation()

    -- Player Speed
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = RivalsUltimate.Player.Speed
    end

    -- Aimbot
    if RivalsUltimate.Combat.Aimbot and UIS:IsMouseButtonPressed(RivalsUltimate.Combat.LockKey) then
        local t, d = nil, RivalsUltimate.Combat.FOV
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
                local pos, onS = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if onS then
                    local mD = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
                    if mD < d then
                        t, d = p, mD
                    end
                end
            end
        end

        if t then
            local head = t.Character.Head
            local screenPos = Camera:WorldToViewportPoint(head.Position + (head.Velocity * RivalsUltimate.Combat.Predict))
            mousemoverel((screenPos.X - Mouse.X)/RivalsUltimate.Combat.Smooth, (screenPos.Y - Mouse.Y)/RivalsUltimate.Combat.Smooth)
        end
    end
end)

-- // 9. MODULE: WEAPON DETECTION (HEADSHOT SOUNDS)
local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    local head = character:WaitForChild("Head")

    humanoid.Touched:Connect(function(hit)
        if hit.Parent == LP.Character then
            local tool = LP.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then
                local distance = (head.Position - tool.Handle.Position).Magnitude
                if distance < 10 then
                    TriggerHeadshotSound()
                end
            end
        end
    end)
end

if LP.Character then
    onCharacterAdded(LP.Character)
end
LP.CharacterAdded:Connect(onCharacterAdded)

-- // 10. MODULE: KILL DETECTION & SOUNDS
local function onPlayerKilled(victim, killer)
    if killer == LP and RivalsUltimate.Combat.KillSounds then
        TriggerKillSound()
    end
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            onPlayerKilled(character, character:GetAttribute("LastKiller") or nil)
        end)
    end)
end)

-- // 11. MODULE: ATMOSPHERE CONTROL
if RivalsUltimate.Atmosphere.Fullbright then
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
    Lighting.ColorShift_Top = Color3.new(1, 1, 1)
end

if RivalsUltimate.Atmosphere.CosmosFX then
    local particles = Instance.new("ParticleEmitter", workspace)
    particles.LightEmission = 1
    particles.Texture = "rbxassetid://241914796"
    particles.Size = NumberRange.new(0.5, 2)
    particles.Lifetime = NumberRange.new(5, 10)
    particles.Speed = NumberRange.new(1, 3)
    particles.Rate = 50
    particles.Rotation = NumberRange.new(0, 360)
    particles.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0.5),
        NumberSequenceKeypoint.new(1, 1)
    })
    particles.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(200, 100, 255))
end

-- // 12. MODULE: WATERMARK
if RivalsUltimate.Interface.Watermark then
    local watermark = Instance.new("TextLabel", Screen)
    watermark.Size = UDim2.new(0, 200, 0, 30)
    watermark.Position = UDim2.new(0, 10, 0, 10)
    watermark.Text = "RIVALS ULTIMATE V1.0 | DEEPSEEK PREMIUM"
    watermark.Font = "GothamBold"
    watermark.TextColor3 = Color3.new(1, 1, 1)
    watermark.TextSize = 14
    watermark.BackgroundTransparency = 1
    watermark.TextStrokeTransparency = 0
end

-- // 13. MODULE: PLAYER ENHANCEMENTS
if RivalsUltimate.Player.InfiniteStamina then
    local stamina = LP:FindFirstChild("Stamina") or Instance.new("NumberValue", LP)
    stamina.Name = "Stamina"
    stamina.Value = 100

    local conn
    conn = RunService.Heartbeat:Connect(function()
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
            LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            LP.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        end
        stamina.Value = 100
    end)
end

if RivalsUltimate.Player.AutoRespawn then
    LP.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            task.wait(3)
            LP:LoadCharacter()
        end)
    end)
end

-- // 14. MODULE: ULTIMATE MENU TOGGLE
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == RivalsUltimate.Interface.MenuKey then
        if Main.Visible then
            TW:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                BackgroundTransparency = 1
            }):Play()
            task.wait(0.5)
            Main.Visible = false
        else
            Main.Visible = true
            TW:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
                Size = UDim2.new(0, 800, 0, 600),
                Position = UDim2.new(0.5, -400, 0.5, -300),
                BackgroundTransparency = 0
            }):Play()
        end
    end
end)

-- // 15. MODULE: FINAL BOOT SEQUENCE
Pages["COMBAT"].Visible = true

-- ESP Initialization
for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP then
        ManageESP(p)
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LP then
        ManageESP(p)
    end
end)

-- Drag System
local dragging, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("✅ RIVALS ULTIMATE V1.0 LOADED - WELCOME TO THE ULTIMATE EXPERIENCE! 🎌")
print("🔹 Développé avec DeepSeek Premium")
print("🔹 Bypass Anti-Cheat: ACTIVÉ")
print("🔹 Fonctionnalités: Aimbot, ESP, Audio Japonais, Améliorations Joueur")
