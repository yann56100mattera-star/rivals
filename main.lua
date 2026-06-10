--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║  RIVALS - ULTIMATE WAIFU EDITION V2.0                        ║
    ║  🌸 Полностью рабочий скрипт для RIVALS с аниме-звуками 🌸   ║
    ║  Нажми RIGHT SHIFT для открытия меню                         ║
    ╚══════════════════════════════════════════════════════════════╝
--]]

--==== COMPATIBILITY ====
if not game:IsLoaded() then game.Loaded:Wait() end
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TW = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local SService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LP:GetMouse()

local gethui_safe = (gethui and gethui()) or CoreGui
local mm_safe = mousemoverel or function() end
print("[RIVALS-WAIFU] ✅ Script loaded! Press RIGHT SHIFT for menu")

--==== CONFIG ====
local R = {
    Combat = {
        Aimbot = true, SilentAim = true, FOV = 200, Smooth = 4, Predict = 0.155,
        Hitbox = "Head", AimKey = Enum.UserInputType.MouseButton2,
        WallCheck = true, TeamCheck = true, ShowFOV = true,
        FOVColor = Color3.fromRGB(255, 100, 200)
    },
    Visuals = {
        Enabled = true, Boxes = true, Chams = true, Names = true,
        Health = true, Tracers = true, HeadDot = true,
        VisCol = Color3.fromRGB(100, 255, 150), InvisCol = Color3.fromRGB(255, 60, 60)
    },
    Anime = {
        Volume = 7, KillVoices = true, HeadshotVoice = true,
        ShootVoices = true, HitSounds = true, BloodHearts = true
    },
    MenuKey = Enum.KeyCode.RightShift
}

--==== WAIFU SOUNDS ====
local WaifuSFX = {
    Kill = {9046850339, 6047576530, 9039573626, 7383714529, 138131333, 6835250443},
    Headshot = {7037673294, 5934914771},
    Shoot = {6334799573, 4953050807, 5635120368},
    Hit = {6342133423, 5443946556}
}

local function PlaySnd(id, vol)
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://"..tostring(id)
    s.Volume = vol or R.Anime.Volume
    s.Parent = SService
    s:Play()
    Debris:AddItem(s, 5)
end

local function PlayRand(pack, vol)
    if pack and #pack > 0 then PlaySnd(pack[math.random(1,#pack)], vol) end
end

--==== UI ====
local Screen = Instance.new("ScreenGui")
Screen.Name = "RIVALS_WAIFU_MENU"
Screen.ResetOnSpawn = false
Screen.Parent = gethui_safe

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 450, 0, 350)
Main.Position = UDim2.new(0.5, -225, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(20, 10, 30)
Main.Visible = false
Main.Active = true
Main.ZIndex = 10
local stroke = Instance.new("UIStroke", Main)
stroke.Color = Color3.fromRGB(255, 100, 200)
stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🌸 RIVALS WAIFU EDITION 🌸"
Title.TextColor3 = Color3.fromRGB(255, 100, 200)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 200)
CloseBtn.TextSize = 16
CloseBtn.ZIndex = 11
local closeCorner = Instance.new("UICorner", CloseBtn)
closeCorner.CornerRadius = UDim.new(0, 5)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

local TabHolder = Instance.new("Frame", Main)
TabHolder.Size = UDim2.new(0, 150, 1, -50)
TabHolder.Position = UDim2.new(0, 10, 0, 50)
TabHolder.BackgroundTransparency = 1

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -170, 1, -50)
Content.Position = UDim2.new(0, 160, 0, 50)
Content.BackgroundTransparency = 1

local Pages = {}

local function CreatePage(name, icon)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 5
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local Btn = Instance.new("TextButton", TabHolder)
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
    Btn.Text = "  "..icon.."  "..name
    Btn.Font = Enum.Font.Gotham
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.TextSize = 14
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.AutoButtonColor = false
    local btnCorner = Instance.new("UICorner", Btn)
    btnCorner.CornerRadius = UDim.new(0, 5)

    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Page.Visible = true
        for _, b in pairs(TabHolder:GetChildren()) do
            if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(30, 20, 40) end
        end
        Btn.BackgroundColor3 = Color3.fromRGB(255, 100, 200)
        PlaySnd(6342133423, 3)
    end)
    Pages[name] = Page
    return Page
end

local function AddToggle(parent, text, cat, key)
    local f = Instance.new("TextButton", parent)
    f.Size = UDim2.new(1, -10, 0, 35)
    f.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
    f.Text = "  "..text
    f.Font = Enum.Font.Gotham
    f.TextColor3 = Color3.new(1,1,1)
    f.TextSize = 14
    f.TextXAlignment = Enum.TextXAlignment.Left
    f.AutoButtonColor = false
    local fCorner = Instance.new("UICorner", f)
    fCorner.CornerRadius = UDim.new(0, 5)

    local ind = Instance.new("Frame", f)
    ind.Size = UDim2.new(0, 30, 0, 18)
    ind.Position = UDim2.new(1, -40, 0.5, -9)
    ind.BackgroundColor3 = R[cat][key] and Color3.fromRGB(255, 100, 200) or Color3.fromRGB(80, 60, 90)
    local indCorner = Instance.new("UICorner", ind)
    indCorner.CornerRadius = UDim.new(0, 4)

    local knob = Instance.new("Frame", ind)
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = R[cat][key] and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    local knobCorner = Instance.new("UICorner", knob)
    knobCorner.CornerRadius = UDim.new(1, 0)

    f.MouseButton1Click:Connect(function()
        R[cat][key] = not R[cat][key]
        local on = R[cat][key]
        TW:Create(ind, TweenInfo.new(0.2), {BackgroundColor3 = on and Color3.fromRGB(255, 100, 200) or Color3.fromRGB(80, 60, 90)}):Play()
        TW:Create(knob, TweenInfo.new(0.2), {Position = on and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
        PlaySnd(6342133423, 2)
    end)
end

--==== CREATE PAGES ====
local pCombat = CreatePage("COMBAT", "🎯")
local pVisuals = CreatePage("VISUALS", "👁")
local pAnime = CreatePage("ANIME", "🌸")

AddToggle(pCombat, "Aimbot", "Combat", "Aimbot")
AddToggle(pCombat, "Wall Check", "Combat", "WallCheck")
AddToggle(pCombat, "Team Check", "Combat", "TeamCheck")
AddToggle(pCombat, "Show FOV", "Combat", "ShowFOV")

AddToggle(pVisuals, "ESP Boxes", "Visuals", "Boxes")
AddToggle(pVisuals, "Names", "Visuals", "Names")
AddToggle(pVisuals, "Health Bar", "Visuals", "Health")
AddToggle(pVisuals, "Tracers", "Visuals", "Tracers")

AddToggle(pAnime, "Kill Voices", "Anime", "KillVoices")
AddToggle(pAnime, "Shoot Voices", "Anime", "ShootVoices")
AddToggle(pAnime, "Hit Sounds", "Anime", "HitSounds")
AddToggle(pAnime, "Blood Hearts", "Anime", "BloodHearts")

--==== SHOW FIRST PAGE ====
Pages["COMBAT"].Visible = true
for _, b in pairs(TabHolder:GetChildren()) do
    if b:IsA("TextButton") and b.Text:find("COMBAT") then
        b.BackgroundColor3 = Color3.fromRGB(255, 100, 200)
    end
end

--==== MENU TOGGLE ====
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == R.MenuKey then
        Main.Visible = not Main.Visible
        print("[RIVALS-WAIFU] Menu: "..(Main.Visible and "OPEN" or "CLOSED"))
    end
end)

--==== FOV CIRCLE ====
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 100
FOVCircle.Color = R.Combat.FOVColor
FOVCircle.Transparency = 0.8
FOVCircle.Filled = false

--==== AIMBOT ====
local function GetVisible(part)
    local origin = Camera.CFrame.Position
    local dir = (part.Position - origin).Unit * 2000
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {LP.Character, Camera}
    params.FilterType = Enum.RaycastFilterType.Exclude
    local result = workspace:Raycast(origin, dir, params)
    return result and result.Instance:IsDescendantOf(part.Parent)
end

local function GetNearestTarget()
    local nearest, bestDist = nil, R.Combat.FOV
    local mousePos = UIS:GetMouseLocation()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local head = p.Character:FindFirstChild(R.Combat.Hitbox) or p.Character:FindFirstChild("Head")
            if hum and hum.Health > 0 and head then
                if R.Combat.TeamCheck and p.Team and LP.Team and p.Team == LP.Team then continue end
                if R.Combat.WallCheck and not GetVisible(head) then continue end
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen and pos.Z > 0 then
                    local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                    if dist < bestDist then nearest, bestDist = p, dist end
                end
            end
        end
    end
    return nearest
end

--==== SHOOT DETECTION ====
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 and R.Anime.ShootVoices then
        PlayRand(WaifuSFX.Shoot)
    end
end)

--==== MAIN LOOP ====
RunService.RenderStepped:Connect(function()
    -- FOV Circle
    if R.Combat.ShowFOV and R.Combat.Aimbot then
        FOVCircle.Visible = true
        FOVCircle.Radius = R.Combat.FOV
        FOVCircle.Position = UIS:GetMouseLocation()
    else
        FOVCircle.Visible = false
    end

    -- Aimbot
    if R.Combat.Aimbot and UIS:IsMouseButtonPressed(R.Combat.AimKey) then
        local target = GetNearestTarget()
        if target then
            local head = target.Character:FindFirstChild(R.Combat.Hitbox) or target.Character.Head
            local vel = head.AssemblyLinearVelocity
            local predPos = Camera:WorldToViewportPoint(head.Position + vel * R.Combat.Predict)
            mm_safe((predPos.X - Mouse.X)/R.Combat.Smooth, (predPos.Y - Mouse.Y)/R.Combat.Smooth)
        end
    end
end)

--==== ESP ====
local function ManageESP(p)
    if p == LP then return end
    local Box = Drawing.new("Square")
    Box.Thickness = 2
    Box.Filled = false

    local NameTag = Drawing.new("Text")
    NameTag.Size = 14
    NameTag.Outline = true
    NameTag.Center = true

    local function update()
        local char = p.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        if not (char and hrp and head) then
            Box.Visible = false
            NameTag.Visible = false
            return
        end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then
            Box.Visible = false
            NameTag.Visible = false
            return
        end

        local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        if not onScreen or pos.Z <= 0 then
            Box.Visible = false
            NameTag.Visible = false
            return
        end

        local col = GetVisible(head) and R.Visuals.VisCol or R.Visuals.InvisCol
        local size = char:GetExtentsSize()
        local topPos = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, size.Y/2, 0))
        local botPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, size.Y/2, 0))
        local h = math.abs(topPos.Y - botPos.Y)
        local w = h * 0.55

        if R.Visuals.Boxes then
            Box.Size = Vector2.new(w, h)
            Box.Position = Vector2.new(pos.X - w/2, pos.Y - h/2)
            Box.Color = col
            Box.Visible = true
        else
            Box.Visible = false
        end

        if R.Visuals.Names then
            NameTag.Text = p.Name
            NameTag.Position = Vector2.new(pos.X, pos.Y - h/2 - 20)
            NameTag.Color = col
            NameTag.Visible = true
        else
            NameTag.Visible = false
        end
    end

    RunService.RenderStepped:Connect(function()
        if R.Visuals.Enabled then update() else Box.Visible = false; NameTag.Visible = false end
    end)

    p.AncestryChanged:Connect(function()
        if not p.Parent then
            Box:Remove()
            NameTag:Remove()
        end
    end)
end

--==== HOOK PLAYERS ====
for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP then ManageESP(p) end
end
Players.PlayerAdded:Connect(function(p)
    if p ~= LP then ManageESP(p) end
end)

print("[RIVALS-WAIFU] ✅ All systems operational! Press RIGHT SHIFT for menu")
