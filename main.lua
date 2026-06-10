--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║   ███▄    █  █    ██ ▒██   ██▒ █    ██   ██████              ║
    ║   ██ ▀█   █  ██  ▓██▒▒▒ █ █ ▒░ ██  ▓██▒▒██    ▒              ║
    ║  ▓██  ▀█ ██▒▓██  ▒██░░░  █   ░▓██  ▒██░░ ▓██▄                ║
    ║  ▓██▒  ▐▌██▒▓▓█  ░██░ ░ █ █ ▒ ▓▓█  ░██░  ▒   ██▒             ║
    ║  ▒██░   ▓██░▒▒█████▓ ▒██▒ ▒██▒▒▒█████▓ ▒██████▒▒             ║
    ║                                                              ║
    ║         RIVALS - ULTIMATE WAIFU EDITION V1.0                 ║
    ║         全自動戦闘システム ・ KAWAII KILL MACHINE              ║
    ╚══════════════════════════════════════════════════════════════╝
--]]

-- ╔══════════════════════════════════════════════════════════════╗
-- ║ 0. COMPATIBILITY PATCH                                       ║
-- ╚══════════════════════════════════════════════════════════════╝
if not game:IsLoaded() then game.Loaded:Wait() end

local genv = getgenv or function() return _G end
local gethui_safe = (gethui and gethui()) or game:GetService("CoreGui")
local mm_safe = mousemoverel or (Input and Input.MouseMove) or function() end
print("[RIVALS-WAIFU] Executor :", identifyexecutor and identifyexecutor() or "Unknown")

-- ╔══════════════════════════════════════════════════════════════╗
-- ║ 1. SERVICES                                                  ║
-- ╚══════════════════════════════════════════════════════════════╝
local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local UIS          = game:GetService("UserInputService")
local TW           = game:GetService("TweenService")
local CoreGui      = game:GetService("CoreGui")
local Lighting     = game:GetService("Lighting")
local SService     = game:GetService("SoundService")
local Debris       = game:GetService("Debris")
local HttpService  = game:GetService("HttpService")
local ReplStorage  = game:GetService("ReplicatedStorage")
local Workspace    = game:GetService("Workspace")
local LP           = Players.LocalPlayer
local Camera       = Workspace.CurrentCamera
local Mouse        = LP:GetMouse()

-- ╔══════════════════════════════════════════════════════════════╗
-- ║ 2. CONFIG OMEGA                                              ║
-- ╚══════════════════════════════════════════════════════════════╝
genv().RivalsWaifu = {
    Combat = {
        Aimbot       = true,
        SilentAim    = true,
        AimKey       = Enum.UserInputType.MouseButton2,
        FOV          = 250,
        Smooth       = 4,
        Predict      = 0.155,
        Hitbox       = "Head",
        WallCheck    = true,
        TeamCheck    = true,
        ShowFOV      = true,
        FOVColor     = Color3.fromRGB(255, 100, 200),
        TriggerBot   = false,
        TriggerDelay = 0.05,
    },
    HitboxExpand = {
        Enabled = true,
        Size    = 8,
        Trans   = 0.6,
    },
    Visuals = {
        Enabled   = true,
        Boxes     = true,
        Chams     = true,
        Names     = true,
        Health    = true,
        Distance  = true,
        Tracers   = true,
        HeadDot   = true,
        Weapon    = true,
        ChamsCol  = Color3.fromRGB(255, 100, 200),
        VisCol    = Color3.fromRGB(100, 255, 150),
        InvisCol  = Color3.fromRGB(255, 60, 60),
    },
    Player = {
        Speed     = 24,
        Jump      = 60,
        InfJump   = false,
        Bhop      = false,
        NoClip    = false,
        FlyMode   = false,
        FlySpeed  = 60,
        SlideSpam = false,
    },
    Weapon = {
        NoRecoil   = true,
        NoSpread   = true,
        InstantReload = false,
    },
    Atmosphere = {
        Fullbright = true,
        RemoveFog  = true,
        SkyPink    = true,
    },
    Anime = {
        Volume        = 7,
        KillVoices    = true,
        HeadshotVoice = true,
        ShootVoices   = true,
        HitSounds     = true,
        ReloadVoice   = true,
        DeathVoice    = true,
        KillFeed      = true,
        BloodHearts   = true,
        Sakura        = true,        -- лепестки сакуры
        DamageNumbers = true,        -- цифры урона в стиле аниме
    },
    Interface = {
        MenuKey   = Enum.KeyCode.RightShift,
        Theme     = Color3.fromRGB(255, 100, 200),
        AntiAFK   = true,
    }
}
local R = genv().RivalsWaifu

-- ╔══════════════════════════════════════════════════════════════╗
-- ║ 3. WAIFU AUDIO PACK (full japanese)                          ║
-- ╚══════════════════════════════════════════════════════════════╝
local WaifuSFX = {
    Kill = {
        9046850339, -- "Sugoi!"
        6047576530, -- "Ara ara~"
        9039573626, -- "Yatta!"
        7383714529, -- "Subarashii!"
        138131333,  -- "Onii-chan~"
        6835250443, -- "Nico Nico Nii"
        4612375233, -- "Kawaii desu ne"
        7037673294, -- "Senpai notice me"
        5934914771, -- "Daisuki~"
        5934915391, -- "Ganbatte!"
    },
    Headshot = {
        7037673294, -- "OMAE WA MOU SHINDEIRU"
        5934914771, -- bonus
        9046850339,
    },
    Shoot = {
        6334799573, -- "Nani?!"
        4953050807, -- "Yamete kudasai!"
        5635120368, -- "Itai!"
        9039573626,
    },
    Hit = {
        6342133423, -- pop
        5443946556,
        7383714529,
    },
    Death = {
        4953050807, -- "Yamete!"
        5635120368, -- "Itai!"
    },
    Reload = {
        5934915391, -- "Ganbatte!"
        138131333,
    },
}

local function PlaySnd(id, vol)
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://" .. tostring(id)
    s.Volume  = vol or R.Anime.Volume
    s.Parent  = SService
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
    Debris:AddItem(s, 8)
end

local function PlayRand(pack, vol)
    if not pack or #pack == 0 then return end
    PlaySnd(pack[math.random(1,#pack)], vol)
end

local function VoiceKill()     if R.Anime.KillVoices    then PlayRand(WaifuSFX.Kill, R.Anime.Volume+2) end end
local function VoiceHead()     if R.Anime.HeadshotVoice then PlayRand(WaifuSFX.Headshot, R.Anime.Volume+3) end end
local function VoiceShoot()    if R.Anime.ShootVoices   then PlayRand(WaifuSFX.Shoot, R.Anime.Volume) end end
local function VoiceHit()      if R.Anime.HitSounds     then PlayRand(WaifuSFX.Hit, R.Anime.Volume) end end
local function VoiceDeath()    if R.Anime.DeathVoice    then PlayRand(WaifuSFX.Death, R.Anime.Volume+1) end end
local function VoiceReload()   if R.Anime.ReloadVoice   then PlayRand(WaifuSFX.Reload, R.Anime.Volume) end end
local function PopClick()      PlaySnd(6342133423, 4) end

-- ╔══════════════════════════════════════════════════════════════╗
-- ║ 4. DRAWING                                                   ║
-- ╚══════════════════════════════════════════════════════════════╝
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness    = 2
FOVCircle.NumSides     = 100
FOVCircle.Color        = R.Combat.FOVColor
FOVCircle.Transparency = 0.85
FOVCircle.Filled       = false

-- ╔══════════════════════════════════════════════════════════════╗
-- ║ 5. UI : SAKURA THEME                                         ║
-- ╚══════════════════════════════════════════════════════════════╝
local Screen = Instance.new("ScreenGui")
Screen.Name           = "RW_" .. HttpService:GenerateGUID(false):sub(1,6)
Screen.ResetOnSpawn   = false
Screen.IgnoreGuiInset = true
Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Screen.Parent         = gethui_safe

-- Sakura overlay (всегда на экране, лепестки падают)
local SakuraLayer = Instance.new("Frame", Screen)
SakuraLayer.Size               = UDim2.new(1, 0, 1, 0)
SakuraLayer.BackgroundTransparency = 1
SakuraLayer.ZIndex             = 1

local function SpawnSakura()
    if not R.Anime.Sakura then return end
    local p = Instance.new("TextLabel", SakuraLayer)
    p.Size                   = UDim2.new(0, 22, 0, 22)
    p.Position               = UDim2.new(math.random(), 0, 0, -20)
    p.BackgroundTransparency = 1
    p.Text                   = "🌸"
    p.TextScaled             = true
    p.TextTransparency       = 0.3
    local dur = math.random(60, 130)/10
    TW:Create(p, TweenInfo.new(dur), {
        Position = UDim2.new(p.Position.X.Scale + 0.1, 0, 1, 50),
        Rotation = math.random(-360, 360),
        TextTransparency = 1
    }):Play()
    Debris:AddItem(p, dur + 1)
end

task.spawn(function()
    while true do
        task.wait(0.4)
        if R.Anime.Sakura then SpawnSakura() end
    end
end)

-- Main panel
local Main = Instance.new("Frame")
Main.Size                   = UDim2.new(0, 0, 0, 0)
Main.Position               = UDim2.new(0.5, 0, 0.5, 0)
Main.BackgroundColor3       = Color3.fromRGB(20, 5, 25)
Main.BackgroundTransparency = 0.08
Main.BorderSizePixel        = 0
Main.Visible                = false
Main.Active                 = true
Main.ClipsDescendants       = true
Main.ZIndex                 = 5
Main.Parent                 = Screen
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)

local stroke = Instance.new("UIStroke", Main)
stroke.Thickness = 2
stroke.Color     = R.Interface.Theme

local grad = Instance.new("UIGradient", Main)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 10, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 5, 25))
}
grad.Rotation = 45

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size                   = UDim2.new(0, 200, 1, 0)
Sidebar.BackgroundColor3       = Color3.fromRGB(15, 5, 20)
Sidebar.BackgroundTransparency = 0.2
Sidebar.BorderSizePixel        = 0
Sidebar.ZIndex                 = 6
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 18)

local Title = Instance.new("TextLabel", Sidebar)
Title.Size                   = UDim2.new(1, 0, 0, 70)
Title.BackgroundTransparency = 1
Title.Text                   = "🌸 RIVALS 🌸\nWAIFU EDITION"
Title.Font                   = Enum.Font.GothamBold
Title.TextColor3             = R.Interface.Theme
Title.TextSize               = 16
Title.ZIndex                 = 7

local Sub = Instance.new("TextLabel", Sidebar)
Sub.Size                   = UDim2.new(1, 0, 0, 20)
Sub.Position               = UDim2.new(0, 0, 0, 70)
Sub.BackgroundTransparency = 1
Sub.Text                   = "全自動戦闘システム"
Sub.Font                   = Enum.Font.Gotham
Sub.TextColor3             = Color3.fromRGB(200, 150, 220)
Sub.TextSize               = 11
Sub.ZIndex                 = 7

local TabHolder = Instance.new("Frame", Sidebar)
TabHolder.Size                   = UDim2.new(1, 0, 1, -110)
TabHolder.Position               = UDim2.new(0, 0, 0, 100)
TabH
