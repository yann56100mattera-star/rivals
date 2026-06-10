--!strict
-- Script client Roblox pour générer une interface premium "cosmos"
-- À placer dans StarterPlayer > StarterPlayerScripts ou StarterGui via un LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mouse = player:GetMouse()

local CONFIG = {
	MenuSize = UDim2.fromOffset(1180, 720),
	MenuCorner = 28,
	AnimationSpeed = 0.55,
	OpenDuration = 1.2,
	BackgroundStarCount = 84,
	ForegroundStarCount = 24,
	CometCount = 3,
	ParticleTrailMax = 14,
	ParallaxStrength = 14,
	CardLift = 10,
	CardGlowTransparency = 0.28,
	UseCustomCursor = true,
}

type CardEntry = {
	root: Frame,
	glow: Frame,
	basePosition: UDim2,
	baseSize: UDim2,
}

local cardRegistry: {CardEntry} = {}
local trailRegistry: {Frame} = {}
local connections: {RBXScriptConnection} = {}

local function cleanupPreviousGui()
	local old = playerGui:FindFirstChild("PremiumCosmosMenu")
	if old then
		old:Destroy()
	end
end

cleanupPreviousGui()

local gui = Instance.new("ScreenGui")
gui.Name = "PremiumCosmosMenu"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 200
gui.Parent = playerGui

local root = Instance.new("Frame")
root.Name = "Root"
root.Size = UDim2.fromScale(1, 1)
root.BackgroundTransparency = 1
root.Parent = gui

local ambient = Lighting:FindFirstChild("PremiumMenuBlur") :: BlurEffect?
if ambient then
	ambient:Destroy()
end

local blur = Instance.new("BlurEffect")
blur.Name = "PremiumMenuBlur"
blur.Size = 0
blur.Parent = Lighting

local background = Instance.new("Frame")
background.Name = "CosmosBackground"
background.Size = UDim2.fromScale(1, 1)
background.BackgroundColor3 = Color3.fromRGB(5, 7, 20)
background.BorderSizePixel = 0
background.Parent = root

local spaceGradient = Instance.new("UIGradient")
spaceGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 8, 24)),
	ColorSequenceKeypoint.new(0.32, Color3.fromRGB(16, 20, 50)),
	ColorSequenceKeypoint.new(0.7, Color3.fromRGB(28, 11, 44)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(4, 5, 14)),
})
spaceGradient.Rotation = 28
spaceGradient.Parent = background

local vignette = Instance.new("Frame")
vignette.Name = "Vignette"
vignette.Size = UDim2.fromScale(1, 1)
vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
vignette.BackgroundTransparency = 0.42
vignette.BorderSizePixel = 0
vignette.ZIndex = 1
vignette.Parent = background

local vignetteGradient = Instance.new("UIGradient")
vignetteGradient.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0))
vignetteGradient.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0.45),
	NumberSequenceKeypoint.new(0.22, 0.88),
	NumberSequenceKeypoint.new(0.5, 1),
	NumberSequenceKeypoint.new(0.78, 0.88),
	NumberSequenceKeypoint.new(1, 0.45),
})
vignetteGradient.Rotation = 90
vignetteGradient.Parent = vignette

local nebulaLayer = Instance.new("Frame")
nebulaLayer.Name = "NebulaLayer"
nebulaLayer.Size = UDim2.fromScale(1, 1)
nebulaLayer.BackgroundTransparency = 1
nebulaLayer.ZIndex = 2
nebulaLayer.Parent = background

local starsBack = Instance.new("Frame")
starsBack.Name = "StarsBack"
starsBack.Size = UDim2.fromScale(1, 1)
starsBack.BackgroundTransparency = 1
starsBack.ZIndex = 3
starsBack.Parent = background

local starsFront = Instance.new("Frame")
starsFront.Name = "StarsFront"
starsFront.Size = UDim2.fromScale(1, 1)
starsFront.BackgroundTransparency = 1
starsFront.ZIndex = 4
starsFront.Parent = background

local cometLayer = Instance.new("Frame")
cometLayer.Name = "CometLayer"
cometLayer.Size = UDim2.fromScale(1, 1)
cometLayer.BackgroundTransparency = 1
cometLayer.ZIndex = 5
cometLayer.Parent = background

local lightPulse = Instance.new("Frame")
lightPulse.Name = "LightPulse"
lightPulse.AnchorPoint = Vector2.new(0.5, 0.5)
lightPulse.Position = UDim2.fromScale(0.5, 0.5)
lightPulse.Size = UDim2.fromOffset(8, 8)
lightPulse.BackgroundColor3 = Color3.fromRGB(150, 220, 255)
lightPulse.BackgroundTransparency = 0.15
lightPulse.BorderSizePixel = 0
lightPulse.ZIndex = 20
lightPulse.Parent = root

local lightCorner = Instance.new("UICorner")
lightCorner.CornerRadius = UDim.new(1, 0)
lightCorner.Parent = lightPulse

local lightStroke = Instance.new("UIStroke")
lightStroke.Color = Color3.fromRGB(240, 250, 255)
lightStroke.Thickness = 1.5
lightStroke.Transparency = 0.18
lightStroke.Parent = lightPulse

local overlayFlash = Instance.new("Frame")
overlayFlash.Name = "OverlayFlash"
overlayFlash.Size = UDim2.fromScale(1, 1)
overlayFlash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
overlayFlash.BackgroundTransparency = 1
overlayFlash.BorderSizePixel = 0
overlayFlash.ZIndex = 19
overlayFlash.Parent = root

local mainHolder = Instance.new("Frame")
mainHolder.Name = "MainHolder"
mainHolder.AnchorPoint = Vector2.new(0.5, 0.5)
mainHolder.Position = UDim2.fromScale(0.5, 0.52)
mainHolder.Size = CONFIG.MenuSize
mainHolder.BackgroundTransparency = 1
mainHolder.ZIndex = 30
mainHolder.Parent = root

local menuShadow = Instance.new("Frame")
menuShadow.Name = "MenuShadow"
menuShadow.AnchorPoint = Vector2.new(0.5, 0.5)
menuShadow.Position = UDim2.fromScale(0.5, 0.5)
menuShadow.Size = UDim2.new(1, 40, 1, 40)
menuShadow.BackgroundColor3 = Color3.fromRGB(12, 16, 34)
menuShadow.BackgroundTransparency = 0.62
menuShadow.BorderSizePixel = 0
menuShadow.ZIndex = 29
menuShadow.Parent = mainHolder

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, CONFIG.MenuCorner + 10)
shadowCorner.Parent = menuShadow

local menu = Instance.new("Frame")
menu.Name = "Menu"
menu.AnchorPoint = Vector2.new(0.5, 0.5)
menu.Position = UDim2.fromScale(0.5, 0.5)
menu.Size = UDim2.fromScale(1, 1)
menu.BackgroundColor3 = Color3.fromRGB(16, 20, 40)
menu.BackgroundTransparency = 0.2
menu.BorderSizePixel = 0
menu.ZIndex = 30
menu.ClipsDescendants = true
menu.Parent = mainHolder

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, CONFIG.MenuCorner)
menuCorner.Parent = menu

local menuStroke = Instance.new("UIStroke")
menuStroke.Color = Color3.fromRGB(130, 200, 255)
menuStroke.Transparency = 0.35
menuStroke.Thickness = 1.2
menuStroke.Parent = menu

local menuGlass = Instance.new("UIGradient")
menuGlass.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(0.35, Color3.fromRGB(140, 190, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 105, 180)),
})
menuGlass.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0.83),
	NumberSequenceKeypoint.new(0.4, 0.95),
	NumberSequenceKeypoint.new(1, 0.9),
})
menuGlass.Rotation = 65
menuGlass.Parent = menu

local topGlow = Instance.new("Frame")
topGlow.Name = "TopGlow"
topGlow.Size = UDim2.new(1, -40, 0, 120)
topGlow.Position = UDim2.fromOffset(20, -20)
topGlow.BackgroundColor3 = Color3.fromRGB(150, 215, 255)
topGlow.BackgroundTransparency = 0.88
topGlow.BorderSizePixel = 0
topGlow.ZIndex = 31
topGlow.Parent = menu

local topGlowCorner = Instance.new("UICorner")
topGlowCorner.CornerRadius = UDim.new(1, 0)
topGlowCorner.Parent = topGlow

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 28)
contentPadding.PaddingLeft = UDim.new(0, 28)
contentPadding.PaddingRight = UDim.new(0, 28)
contentPadding.PaddingBottom = UDim.new(0, 28)
contentPadding.Parent = menu

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 78)
topBar.BackgroundTransparency = 1
topBar.ZIndex = 35
topBar.Parent = menu

local topLeft = Instance.new("Frame")
topLeft.Name = "TopLeft"
topLeft.Size = UDim2.new(0.45, 0, 1, 0)
topLeft.BackgroundTransparency = 1
topLeft.ZIndex = 35
topLeft.Parent = topBar

local logoOrb = Instance.new("Frame")
logoOrb.Name = "LogoOrb"
logoOrb.Size = UDim2.fromOffset(38, 38)
logoOrb.Position = UDim2.fromOffset(0, 20)
logoOrb.BackgroundColor3 = Color3.fromRGB(125, 215, 255)
logoOrb.BorderSizePixel = 0
logoOrb.ZIndex = 36
logoOrb.Parent = topLeft

local logoOrbCorner = Instance.new("UICorner")
logoOrbCorner.CornerRadius = UDim.new(1, 0)
logoOrbCorner.Parent = logoOrb

local logoOrbStroke = Instance.new("UIStroke")
logoOrbStroke.Color = Color3.fromRGB(255, 255, 255)
logoOrbStroke.Transparency = 0.2
logoOrbStroke.Thickness = 1
logoOrbStroke.Parent = logoOrb

local title = Instance.new("TextLabel")
title.Name = "Title"
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(56, 8)
title.Size = UDim2.new(1, -56, 0, 34)
title.Font = Enum.Font.GothamBold
title.Text = "PREMIUM COSMOS"
title.TextColor3 = Color3.fromRGB(244, 248, 255)
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 36
title.Parent = topLeft

local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.fromOffset(56, 38)
subtitle.Size = UDim2.new(1, -56, 0, 24)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "Dashboard spatial cinématique • interface premium temps réel"
subtitle.TextColor3 = Color3.fromRGB(173, 188, 225)
subtitle.TextSize = 13
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.ZIndex = 36
subtitle.Parent = topLeft

local topRight = Instance.new("Frame")
topRight.Name = "TopRight"
topRight.AnchorPoint = Vector2.new(1, 0)
topRight.Position = UDim2.fromScale(1, 0)
topRight.Size = UDim2.new(0.34, 0, 1, 0)
topRight.BackgroundTransparency = 1
topRight.ZIndex = 35
topRight.Parent = topBar

local topRightLayout = Instance.new("UIListLayout")
topRightLayout.FillDirection = Enum.FillDirection.Horizontal
topRightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
topRightLayout.VerticalAlignment = Enum.VerticalAlignment.Center
topRightLayout.Padding = UDim.new(0, 12)
topRightLayout.Parent = topRight

local function createChip(textValue: string): TextButton
	local chip = Instance.new("TextButton")
	chip.AutoButtonColor = false
	chip.Size = UDim2.fromOffset(122, 38)
	chip.BackgroundColor3 = Color3.fromRGB(28, 35, 66)
	chip.BackgroundTransparency = 0.16
	chip.Text = textValue
	chip.Font = Enum.Font.GothamMedium
	chip.TextSize = 13
	chip.TextColor3 = Color3.fromRGB(235, 240, 255)
	chip.ZIndex = 36

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 18)
	corner.Parent = chip

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(135, 185, 255)
	stroke.Transparency = 0.42
	stroke.Thickness = 1
	stroke.Parent = chip

	return chip
end

local notifChip = createChip("Notifications")
notifChip.Parent = topRight

local syncChip = createChip("Synchronisé")
syncChip.Parent = topRight

local ctrlChip = createChip("Ctrl • Mode")
ctrlChip.Parent = topRight

local body = Instance.new("Frame")
body.Name = "Body"
body.Position = UDim2.fromOffset(0, 92)
body.Size = UDim2.new(1, 0, 1, -92)
body.BackgroundTransparency = 1
body.ZIndex = 35
body.Parent = menu

local leftColumn = Instance.new("Frame")
leftColumn.Name = "LeftColumn"
leftColumn.Size = UDim2.new(0.33, -12, 1, 0)
leftColumn.BackgroundTransparency = 1
leftColumn.ZIndex = 35
leftColumn.Parent = body

local centerColumn = Instance.new("Frame")
centerColumn.Name = "CenterColumn"
centerColumn.Position = UDim2.new(0.33, 8, 0, 0)
centerColumn.Size = UDim2.new(0.38, -10, 1, 0)
centerColumn.BackgroundTransparency = 1
centerColumn.ZIndex = 35
centerColumn.Parent = body

local rightColumn = Instance.new("Frame")
rightColumn.Name = "RightColumn"
rightColumn.AnchorPoint = Vector2.new(1, 0)
rightColumn.Position = UDim2.new(1, 0, 0, 0)
rightColumn.Size = UDim2.new(0.29, -8, 1, 0)
rightColumn.BackgroundTransparency = 1
rightColumn.ZIndex = 35
rightColumn.Parent = body

local function createColumnLayout(parent: Instance)
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 14)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = parent
end

createColumnLayout(leftColumn)
createColumnLayout(centerColumn)
createColumnLayout(rightColumn)

local function createCard(parent: Instance, titleText: string, height: number, layoutOrder: number): Frame
	local glow = Instance.new("Frame")
	glow.Name = titleText .. "Glow"
	glow.Size = UDim2.new(1, 8, 0, height + 8)
	glow.BackgroundColor3 = Color3.fromRGB(110, 200, 255)
	glow.BackgroundTransparency = 0.9
	glow.BorderSizePixel = 0
	glow.ZIndex = 34

	local glowCorner = Instance.new("UICorner")
	glowCorner.CornerRadius = UDim.new(0, 26)
	glowCorner.Parent = glow

	local card = Instance.new("Frame")
	card.Name = titleText
	card.Size = UDim2.new(1, 0, 0, height)
	card.BackgroundColor3 = Color3.fromRGB(20, 25, 50)
	card.BackgroundTransparency = 0.16
	card.BorderSizePixel = 0
	card.ZIndex = 35
	card.LayoutOrder = layoutOrder
	card.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 22)
	corner.Parent = card

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(132, 186, 255)
	stroke.Transparency = 0.48
	stroke.Thickness = 1
	stroke.Parent = card

	local cardGradient = Instance.new("UIGradient")
	cardGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 50, 85)),
		ColorSequenceKeypoint.new(0.4, Color3.fromRGB(23, 27, 54)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 18, 36)),
	})
	cardGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.18),
		NumberSequenceKeypoint.new(0.45, 0.28),
		NumberSequenceKeypoint.new(1, 0.08),
	})
	cardGradient.Rotation = 90
	cardGradient.Parent = card

	local sheen = Instance.new("Frame")
	sheen.Name = "Sheen"
	sheen.Size = UDim2.new(1.3, 0, 0.4, 0)
	sheen.Position = UDim2.new(-0.2, 0, -0.15, 0)
	sheen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	sheen.BackgroundTransparency = 0.94
	sheen.BorderSizePixel = 0
	sheen.Rotation = -8
	sheen.ZIndex = 36
	sheen.Parent = card

	local sheenCorner = Instance.new("UICorner")
	sheenCorner.CornerRadius = UDim.new(1, 0)
	sheenCorner.Parent = sheen

	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, 18)
	padding.PaddingLeft = UDim.new(0, 18)
	padding.PaddingRight = UDim.new(0, 18)
	padding.PaddingBottom = UDim.new(0, 18)
	padding.Parent = card

	local header = Instance.new("TextLabel")
	header.Name = "Header"
	header.Size = UDim2.new(1, 0, 0, 24)
	header.BackgroundTransparency = 1
	header.Font = Enum.Font.GothamBold
	header.Text = titleText
	header.TextSize = 17
	header.TextColor3 = Color3.fromRGB(245, 248, 255)
	header.TextXAlignment = Enum.TextXAlignment.Left
	header.ZIndex = 37
	header.Parent = card

	glow.Position = UDim2.new(card.Position.X.Scale, card.Position.X.Offset - 4, card.Position.Y.Scale, card.Position.Y.Offset - 4)
	glow.Parent = parent
	glow.LayoutOrder = layoutOrder

	table.insert(cardRegistry, {
		root = card,
		glow = glow,
		basePosition = card.Position,
		baseSize = card.Size,
	})

	return card
end

local profileCard = createCard(leftColumn, "Profil", 236, 1)
local activityCard = createCard(leftColumn, "Activité", 196, 2)
local statsCard = createCard(centerColumn, "Statistiques", 246, 1)
local analyticsCard = createCard(centerColumn, "Vue temps réel", 238, 2)
local notifCard = createCard(rightColumn, "Notifications", 194, 1)
local quickCard = createCard(rightColumn, "Actions", 178, 2)
local statusCard = createCard(rightColumn, "Système", 138, 3)

local function createText(parent: Instance, textValue: string, size: number, transparency: number, y: number, weight: Enum.Font): TextLabel
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = UDim2.fromOffset(0, y)
	label.Size = UDim2.new(1, 0, 0, size + 8)
	label.Font = weight
	label.Text = textValue
	label.TextSize = size
	label.TextColor3 = Color3.fromRGB(236, 241, 255)
	label.TextTransparency = transparency
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.ZIndex = 37
	label.Parent = parent
	return label
end

local avatarGlow = Instance.new("Frame")
avatarGlow.Size = UDim2.fromOffset(94, 94)
avatarGlow.Position = UDim2.fromOffset(0, 42)
avatarGlow.BackgroundColor3 = Color3.fromRGB(111, 205, 255)
avatarGlow.BackgroundTransparency = 0.74
avatarGlow.BorderSizePixel = 0
avatarGlow.ZIndex = 36
avatarGlow.Parent = profileCard

local avatarGlowCorner = Instance.new("UICorner")
avatarGlowCorner.CornerRadius = UDim.new(1, 0)
avatarGlowCorner.Parent = avatarGlow

local avatar = Instance.new("ImageLabel")
avatar.Name = "Avatar"
avatar.Size = UDim2.fromOffset(82, 82)
avatar.Position = UDim2.fromOffset(6, 48)
avatar.BackgroundColor3 = Color3.fromRGB(32, 40, 70)
avatar.BackgroundTransparency = 0.02
avatar.BorderSizePixel = 0
avatar.Image = ("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png"):format(player.UserId)
avatar.ZIndex = 37
avatar.Parent = profileCard

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1, 0)
avatarCorner.Parent = avatar

local avatarStroke = Instance.new("UIStroke")
avatarStroke.Color = Color3.fromRGB(255, 255, 255)
avatarStroke.Transparency = 0.18
avatarStroke.Thickness = 1.2
avatarStroke.Parent = avatar

createText(profileCard, player.DisplayName, 20, 0, 54, Enum.Font.GothamBold)
createText(profileCard, "@" .. player.Name, 13, 0.1, 84, Enum.Font.Gotham)
createText(profileCard, "Discord intégré  •  cosmos.member", 12, 0.14, 112, Enum.Font.Gotham)
createText(profileCard, "Niveau utilisateur  •  47", 12, 0.16, 146, Enum.Font.Gotham)
createText(profileCard, "Inscrit le  •  2024-09-14", 12, 0.16, 168, Enum.Font.Gotham)
createText(profileCard, "Temps d'utilisation  •  126 h", 12, 0.16, 190, Enum.Font.Gotham)

local activityList = Instance.new("Frame")
activityList.Size = UDim2.new(1, 0, 1, -38)
activityList.Position = UDim2.fromOffset(0, 38)
activityList.BackgroundTransparency = 1
activityList.Parent = activityCard

local activityLayout = Instance.new("UIListLayout")
activityLayout.Padding = UDim.new(0, 8)
activityLayout.Parent = activityList

local function createTimelineLine(parent: Instance, accent: Color3, labelText: string, detailText: string)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 42)
	row.BackgroundTransparency = 1
	row.Parent = parent

	local dot = Instance.new("Frame")
	dot.Size = UDim2.fromOffset(10, 10)
	dot.Position = UDim2.fromOffset(0, 8)
	dot.BackgroundColor3 = accent
	dot.BorderSizePixel = 0
	dot.ZIndex = 37
	dot.Parent = row

	local dotCorner = Instance.new("UICorner")
	dotCorner.CornerRadius = UDim.new(1, 0)
	dotCorner.Parent = dot

	local text1 = Instance.new("TextLabel")
	text1.BackgroundTransparency = 1
	text1.Position = UDim2.fromOffset(22, 0)
	text1.Size = UDim2.new(1, -22, 0, 18)
	text1.Font = Enum.Font.GothamMedium
	text1.Text = labelText
	text1.TextSize = 13
	text1.TextColor3 = Color3.fromRGB(239, 242, 255)
	text1.TextXAlignment = Enum.TextXAlignment.Left
	text1.ZIndex = 37
	text1.Parent = row

	local text2 = text1:Clone()
	text2.Position = UDim2.fromOffset(22, 18)
	text2.Size = UDim2.new(1, -22, 0, 16)
	text2.Font = Enum.Font.Gotham
	text2.Text = detailText
	text2.TextSize = 11
	text2.TextColor3 = Color3.fromRGB(158, 173, 206)
	text2.Parent = row
end

createTimelineLine(activityList, Color3.fromRGB(108, 220, 255), "Menu chargé", "Ouverture fluide validée • maintenant")
createTimelineLine(activityList, Color3.fromRGB(170, 120, 255), "Profil synchronisé", "Données utilisateur récupérées")
createTimelineLine(activityList, Color3.fromRGB(255, 204, 113), "Mode premium actif", "Effets avancés en rendu temps réel")
createTimelineLine(activityList, Color3.fromRGB(119, 255, 186), "Journal disponible", "Historique récent prêt à afficher")

local graphArea = Instance.new("Frame")
graphArea.Size = UDim2.new(1, 0, 1, -42)
graphArea.Position = UDim2.fromOffset(0, 42)
graphArea.BackgroundTransparency = 1
graphArea.Parent = statsCard

local graphBase = Instance.new("Frame")
graphBase.Size = UDim2.new(1, 0, 0, 124)
graphBase.Position = UDim2.fromOffset(0, 8)
graphBase.BackgroundColor3 = Color3.fromRGB(15, 18, 37)
graphBase.BackgroundTransparency = 0.22
graphBase.BorderSizePixel = 0
graphBase.ZIndex = 36
graphBase.Parent = graphArea

local graphCorner = Instance.new("UICorner")
graphCorner.CornerRadius = UDim.new(0, 18)
graphCorner.Parent = graphBase

local graphStroke = Instance.new("UIStroke")
graphStroke.Color = Color3.fromRGB(104, 164, 255)
graphStroke.Transparency = 0.62
graphStroke.Parent = graphBase

local graphValues = {0.46, 0.63, 0.41, 0.72, 0.84, 0.58, 0.88}
local barWidth = 26
for i, v in ipairs(graphValues) do
	local bar = Instance.new("Frame")
	bar.AnchorPoint = Vector2.new(0, 1)
	bar.Size = UDim2.fromOffset(barWidth, math.floor(82 * v))
	bar.Position = UDim2.new(0, 18 + (i - 1) * 34, 1, -16)
	bar.BackgroundColor3 = Color3.fromRGB(84 + i * 12, 170 + i * 6, 255)
	bar.BackgroundTransparency = 0.06
	bar.BorderSizePixel = 0
	bar.ZIndex = 37
	bar.Parent = graphBase

	local bCorner = Instance.new("UICorner")
	bCorner.CornerRadius = UDim.new(0, 10)
	bCorner.Parent = bar
end

local statRow = Instance.new("Frame")
statRow.Size = UDim2.new(1, 0, 0, 64)
statRow.Position = UDim2.fromOffset(0, 144)
statRow.BackgroundTransparency = 1
statRow.Parent = graphArea

local statLayout = Instance.new("UIListLayout")
statLayout.FillDirection = Enum.FillDirection.Horizontal
statLayout.Padding = UDim.new(0, 10)
statLayout.Parent = statRow

local function createMiniStat(parent: Instance, titleText: string, valueText: string): Frame
	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(0.33, -7, 1, 0)
	holder.BackgroundColor3 = Color3.fromRGB(17, 22, 44)
	holder.BackgroundTransparency = 0.18
	holder.BorderSizePixel = 0
	holder.ZIndex = 36
	holder.Parent = parent

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 16)
	c.Parent = holder

	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(120, 178, 255)
	s.Transparency = 0.58
	s.Parent = holder

	local t = Instance.new("TextLabel")
	t.BackgroundTransparency = 1
	t.Position = UDim2.fromOffset(14, 10)
	t.Size = UDim2.new(1, -14, 0, 18)
	t.Font = Enum.Font.Gotham
	t.Text = titleText
	t.TextSize = 11
	t.TextColor3 = Color3.fromRGB(170, 184, 218)
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.ZIndex = 37
	t.Parent = holder

	local v = t:Clone()
	v.Position = UDim2.fromOffset(14, 28)
	v.Size = UDim2.new(1, -14, 0, 24)
	v.Font = Enum.Font.GothamBold
	v.Text = valueText
	v.TextSize = 18
	v.TextColor3 = Color3.fromRGB(241, 246, 255)
	v.Parent = holder

	return holder
end

createMiniStat(statRow, "Performance", "98%")
createMiniStat(statRow, "Réactivité", "12 ms")
createMiniStat(statRow, "Stabilité", "Ultra")

local realtimeArea = Instance.new("Frame")
realtimeArea.Size = UDim2.new(1, 0, 1, -42)
realtimeArea.Position = UDim2.fromOffset(0, 42)
realtimeArea.BackgroundTransparency = 1
realtimeArea.Parent = analyticsCard

local lineGraph = Instance.new("Frame")
lineGraph.Size = UDim2.new(1, 0, 0, 116)
lineGraph.BackgroundColor3 = Color3.fromRGB(15, 18, 35)
lineGraph.BackgroundTransparency = 0.22
lineGraph.BorderSizePixel = 0
lineGraph.Parent = realtimeArea

local lineGraphCorner = Instance.new("UICorner")
lineGraphCorner.CornerRadius = UDim.new(0, 18)
lineGraphCorner.Parent = lineGraph

local points = {
	Vector2.new(18, 82),
	Vector2.new(58, 60),
	Vector2.new(98, 67),
	Vector2.new(138, 44),
	Vector2.new(178, 54),
	Vector2.new(218, 28),
	Vector2.new(258, 39),
	Vector2.new(298, 24),
	Vector2.new(338, 34),
	Vector2.new(378, 18),
}

for _, p in ipairs(points) do
	local point = Instance.new("Frame")
	point.Size = UDim2.fromOffset(8, 8)
	point.Position = UDim2.fromOffset(p.X, p.Y)
	point.BackgroundColor3 = Color3.fromRGB(105, 223, 255)
	point.BorderSizePixel = 0
	point.ZIndex = 37
	point.Parent = lineGraph

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(1, 0)
	c.Parent = point
end

for i = 1, #points - 1 do
	local a = points[i]
	local b = points[i + 1]
	local delta = b - a
	local length = delta.Magnitude
	local angle = math.deg(math.atan2(delta.Y, delta.X))

	local segment = Instance.new("Frame")
	segment.AnchorPoint = Vector2.new(0, 0.5)
	segment.Size = UDim2.fromOffset(length, 3)
	segment.Position = UDim2.fromOffset(a.X + 4, a.Y + 4)
	segment.BackgroundColor3 = Color3.fromRGB(103, 181, 255)
	segment.BackgroundTransparency = 0.12
	segment.BorderSizePixel = 0
	segment.Rotation = angle
	segment.ZIndex = 36
	segment.Parent = lineGraph
end

createText(realtimeArea, "Flux de rendu : stable", 13, 0.08, 130, Enum.Font.GothamMedium)
createText(realtimeArea, "Chargement premium : progressif et cohérent", 12, 0.18, 154, Enum.Font.Gotham)
createText(realtimeArea, "Lumières : adaptatives", 12, 0.18, 176, Enum.Font.Gotham)
createText(realtimeArea, "Profondeur : multicouche active", 12, 0.18, 198, Enum.Font.Gotham)

local notifList = Instance.new("Frame")
notifList.Size = UDim2.new(1, 0, 1, -42)
notifList.Position = UDim2.fromOffset(0, 42)
notifList.BackgroundTransparency = 1
notifList.Parent = notifCard

local notifLayout = Instance.new("UIListLayout")
notifLayout.Padding = UDim.new(0, 10)
notifLayout.Parent = notifList

local function createNotification(accent: Color3, titleText: string, bodyText: string)
	local item = Instance.new("Frame")
	item.Size = UDim2.new(1, 0, 0, 42)
	item.BackgroundColor3 = Color3.fromRGB(16, 20, 39)
	item.BackgroundTransparency = 0.18
	item.BorderSizePixel = 0
	item.ZIndex = 36
	item.Parent = notifList

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 14)
	c.Parent = item

	local accentBar = Instance.new("Frame")
	accentBar.Size = UDim2.fromOffset(4, 26)
	accentBar.Position = UDim2.fromOffset(10, 8)
	accentBar.BackgroundColor3 = accent
	accentBar.BorderSizePixel = 0
	accentBar.ZIndex = 37
	accentBar.Parent = item

	local aC = Instance.new("UICorner")
	aC.CornerRadius = UDim.new(1, 0)
	aC.Parent = accentBar

	local t1 = Instance.new("TextLabel")
	t1.BackgroundTransparency = 1
	t1.Position = UDim2.fromOffset(24, 6)
	t1.Size = UDim2.new(1, -28, 0, 15)
	t1.Font = Enum.Font.GothamMedium
	t1.Text = titleText
	t1.TextSize = 12
	t1.TextColor3 = Color3.fromRGB(240, 244, 255)
	t1.TextXAlignment = Enum.TextXAlignment.Left
	t1.ZIndex = 37
	t1.Parent = item

	local t2 = t1:Clone()
	t2.Position = UDim2.fromOffset(24, 20)
	t2.Size = UDim2.new(1, -28, 0, 14)
	t2.Font = Enum.Font.Gotham
	t2.Text = bodyText
	t2.TextSize = 10
	t2.TextColor3 = Color3.fromRGB(159, 176, 211)
	t2.Parent = item
end

createNotification(Color3.fromRGB(94, 220, 255), "Mise à jour visuelle", "Reflets dynamiques disponibles")
createNotification(Color3.fromRGB(170, 125, 255), "Dashboard actif", "Graphiques et cartes initialisés")
createNotification(Color3.fromRGB(255, 212, 105), "Effet Ctrl prêt", "Réduction cinématique instantanée")

local actionsList = Instance.new("Frame")
actionsList.Size = UDim2.new(1, 0, 1, -42)
actionsList.Position = UDim2.fromOffset(0, 42)
actionsList.BackgroundTransparency = 1
actionsList.Parent = quickCard

local actionsLayout = Instance.new("UIListLayout")
actionsLayout.Padding = UDim.new(0, 10)
actionsLayout.Parent = actionsList

local interactiveButtons: {TextButton} = {}

local function createActionButton(textValue: string): TextButton
	local btn = Instance.new("TextButton")
	btn.AutoButtonColor = false
	btn.Size = UDim2.new(1, 0, 0, 42)
	btn.BackgroundColor3 = Color3.fromRGB(26, 33, 64)
	btn.BackgroundTransparency = 0.1
	btn.Text = textValue
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 13
	btn.TextColor3 = Color3.fromRGB(241, 245, 255)
	btn.ZIndex = 36
	btn.Parent = actionsList

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 16)
	c.Parent = btn

	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(132, 195, 255)
	s.Transparency = 0.56
	s.Parent = btn

	table.insert(interactiveButtons, btn)
	return btn
end

createActionButton("Ouvrir l'activité")
createActionButton("Afficher les stats")
createActionButton("Basculer en mode focus")

createText(statusCard, "Rendu 3D UI : prêt", 13, 0.08, 42, Enum.Font.GothamMedium)
createText(statusCard, "Cosmos multicouche : actif", 12, 0.18, 70, Enum.Font.Gotham)
createText(statusCard, "Entrée cinématique : 1.2 s", 12, 0.18, 92, Enum.Font.Gotham)

local cursorLayer = Instance.new("Frame")
cursorLayer.Name = "CursorLayer"
cursorLayer.Size = UDim2.fromScale(1, 1)
cursorLayer.BackgroundTransparency = 1
cursorLayer.ZIndex = 80
cursorLayer.Parent = root

local cursor = Instance.new("Frame")
cursor.Name = "Cursor"
cursor.Size = UDim2.fromOffset(12, 12)
cursor.AnchorPoint = Vector2.new(0.5, 0.5)
cursor.BackgroundColor3 = Color3.fromRGB(180, 236, 255)
cursor.BackgroundTransparency = 0.12
cursor.BorderSizePixel = 0
cursor.ZIndex = 81
cursor.Parent = cursorLayer

local cursorCorner = Instance.new("UICorner")
cursorCorner.CornerRadius = UDim.new(1, 0)
cursorCorner.Parent = cursor

local cursorStroke = Instance.new("UIStroke")
cursorStroke.Color = Color3.fromRGB(255, 255, 255)
cursorStroke.Transparency = 0.08
cursorStroke.Thickness = 1
cursorStroke.Parent = cursor

local cursorHalo = Instance.new("Frame")
cursorHalo.Name = "CursorHalo"
cursorHalo.Size = UDim2.fromOffset(34, 34)
cursorHalo.AnchorPoint = Vector2.new(0.5, 0.5)
cursorHalo.BackgroundColor3 = Color3.fromRGB(100, 195, 255)
cursorHalo.BackgroundTransparency = 0.78
cursorHalo.BorderSizePixel = 0
cursorHalo.ZIndex = 80
cursorHalo.Parent = cursorLayer

local cursorHaloCorner = Instance.new("UICorner")
cursorHaloCorner.CornerRadius = UDim.new(1, 0)
cursorHaloCorner.Parent = cursorHalo

local cursorTrailSource = Vector2.new(0, 0)
local cursorTarget = Vector2.new(0, 0)
local menuVisible = true
local hoverActive = false

local function tween(instance: Instance, tweenInfo: TweenInfo, props: {[string]: any})
	local tw = TweenService:Create(instance, tweenInfo, props)
	tw:Play()
	return tw
end

local function createNebula(size: number, position: UDim2, color: Color3, transparency: number, zIndex: number)
	local nebula = Instance.new("Frame")
	nebula.Size = UDim2.fromOffset(size, size)
	nebula.Position = position
	nebula.BackgroundColor3 = color
	nebula.BackgroundTransparency = transparency
	nebula.BorderSizePixel = 0
	nebula.ZIndex = zIndex
	nebula.Parent = nebulaLayer

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(1, 0)
	c.Parent = nebula

	return nebula
end

local nebulas = {
	createNebula(320, UDim2.new(0.1, 0, 0.15, 0), Color3.fromRGB(93, 122, 255), 0.82, 2),
	createNebula(260, UDim2.new(0.72, 0, 0.12, 0), Color3.fromRGB(190, 102, 255), 0.84, 2),
	createNebula(420, UDim2.new(0.54, 0, 0.58, 0), Color3.fromRGB(102, 224, 255), 0.88, 2),
	createNebula(290, UDim2.new(0.15, 0, 0.72, 0), Color3.fromRGB(255, 153, 108), 0.9, 2),
}

local function createStar(parent: Frame, scaleMin: number, scaleMax: number, baseTransparency: number)
	local star = Instance.new("Frame")
	local size = math.random(scaleMin, scaleMax)
	star.Size = UDim2.fromOffset(size, size)
	star.Position = UDim2.new(math.random(), 0, math.random(), 0)
	star.BackgroundColor3 = Color3.fromRGB(235, 244, 255)
	star.BackgroundTransparency = baseTransparency + math.random() * 0.2
	star.BorderSizePixel = 0
	star.ZIndex = parent.ZIndex
	star.Parent = parent

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(1, 0)
	c.Parent = star

	if math.random() > 0.78 then
		local glow = Instance.new("Frame")
		glow.Size = UDim2.fromOffset(size + math.random(6, 14), size + math.random(6, 14))
		glow.Position = UDim2.fromOffset(-(glow.AbsoluteSize.X - size) / 2, -(glow.AbsoluteSize.Y - size) / 2)
		glow.BackgroundColor3 = Color3.fromRGB(145, 210, 255)
		glow.BackgroundTransparency = 0.92
		glow.BorderSizePixel = 0
		glow.ZIndex = parent.ZIndex - 1
		glow.Parent = star

		local gc = Instance.new("UICorner")
		gc.CornerRadius = UDim.new(1, 0)
		gc.Parent = glow
	end

	return star
end

local allStars = {}
for _ = 1, CONFIG.BackgroundStarCount do
	table.insert(allStars, createStar(starsBack, 1, 3, 0.22))
end
for _ = 1, CONFIG.ForegroundStarCount do
	table.insert(allStars, createStar(starsFront, 2, 4, 0.08))
end

local comets = {}
local function createComet(startXScale: number, startYScale: number)
	local comet = Instance.new("Frame")
	comet.Size = UDim2.fromOffset(120, 2)
	comet.Position = UDim2.new(startXScale, 0, startYScale, 0)
	comet.BackgroundColor3 = Color3.fromRGB(188, 235, 255)
	comet.BackgroundTransparency = 0.55
	comet.BorderSizePixel = 0
	comet.Rotation = -28
	comet.ZIndex = 5
	comet.Parent = cometLayer

	local grad = Instance.new("UIGradient")
	grad.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(120, 194, 255))
	grad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
	grad.Parent = comet

	return comet
end

for i = 1, CONFIG.CometCount do
	local c = createComet(-0.2 - i * 0.15, 0.12 + i * 0.18)
	table.insert(comets, c)
end

local function createTrailParticle(): Frame
	local p = Instance.new("Frame")
	p.Size = UDim2.fromOffset(math.random(4, 10), math.random(4, 10))
	p.AnchorPoint = Vector2.new(0.5, 0.5)
	p.BackgroundColor3 = Color3.fromRGB(128 + math.random(40, 80), 210 + math.random(10, 30), 255)
	p.BackgroundTransparency = 0.35
	p.BorderSizePixel = 0
	p.ZIndex = 79
	p.Parent = cursorLayer

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(1, 0)
	c.Parent = p

	return p
end

local function attachHoverEffects(card: Frame)
	local stroke = card:FindFirstChildOfClass("UIStroke")
	local sheen = card:FindFirstChild("Sheen") :: Frame?
	local glowEntry: Frame? = nil

	for _, entry in ipairs(cardRegistry) do
		if entry.root == card then
			glowEntry = entry.glow
			break
		end
	end

	card.Active = true

	table.insert(connections, card.MouseEnter:Connect(function()
		hoverActive = true
		if stroke then
			tween(stroke, TweenInfo.new(0.18, Enum.EasingStyle.Sine), {
				Transparency = 0.08,
				Thickness = 1.4,
			})
		end
		if sheen then
			tween(sheen, TweenInfo.new(0.22, Enum.EasingStyle.Sine), {
				BackgroundTransparency = 0.86,
				Position = UDim2.new(-0.08, 0, -0.05, 0),
			})
		end
		if glowEntry then
			tween(glowEntry, TweenInfo.new(0.22, Enum.EasingStyle.Sine), {
				BackgroundTransparency = CONFIG.CardGlowTransparency,
			})
		end
		tween(card, TweenInfo.new(0.22, Enum.EasingStyle.Quad), {
			Position = card.Position - UDim2.fromOffset(0, CONFIG.CardLift),
			Size = card.Size + UDim2.fromOffset(0, 4),
		})
	end))

	table.insert(connections, card.MouseLeave:Connect(function()
		hoverActive = false
		if stroke then
			tween(stroke, TweenInfo.new(0.22, Enum.EasingStyle.Sine), {
				Transparency = 0.48,
				Thickness = 1,
			})
		end
		if sheen then
			tween(sheen, TweenInfo.new(0.24, Enum.EasingStyle.Sine), {
				BackgroundTransparency = 0.94,
				Position = UDim2.new(-0.2, 0, -0.15, 0),
			})
		end
		if glowEntry then
			tween(glowEntry, TweenInfo.new(0.24, Enum.EasingStyle.Sine), {
				BackgroundTransparency = 0.9,
			})
		end
		tween(card, TweenInfo.new(0.22, Enum.EasingStyle.Quad), {
			Position = UDim2.fromOffset(0, 0),
			Size = UDim2.new(1, 0, 0, card.Size.Y.Offset - 4),
		})
	end))

	table.insert(connections, card.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			tween(card, TweenInfo.new(0.08, Enum.EasingStyle.Sine), {
				Size = card.Size - UDim2.fromOffset(0, 4),
			})
		end
	end))

	table.insert(connections, card.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			tween(card, TweenInfo.new(0.12, Enum.EasingStyle.Sine), {
				Size = UDim2.new(1, 0, 0, card.Size.Y.Offset + 4),
			})
		end
	end))
end

for _, entry in ipairs(cardRegistry) do
	attachHoverEffects(entry.root)
end

for _, chip in ipairs({notifChip, syncChip, ctrlChip}) do
	table.insert(interactiveButtons, chip)
end

for _, btn in ipairs(interactiveButtons) do
	local stroke = btn:FindFirstChildOfClass("UIStroke")
	table.insert(connections, btn.MouseEnter:Connect(function()
		tween(btn, TweenInfo.new(0.18, Enum.EasingStyle.Sine), {
			BackgroundTransparency = 0.02,
			Size = btn.Size + UDim2.fromOffset(4, 2),
		})
		if stroke then
			tween(stroke, TweenInfo.new(0.18, Enum.EasingStyle.Sine), {
				Transparency = 0.12,
			})
		end
		tween(cursorHalo, TweenInfo.new(0.12, Enum.EasingStyle.Sine), {
			Size = UDim2.fromOffset(48, 48),
			BackgroundTransparency = 0.68,
		})
	end))

	table.insert(connections, btn.MouseLeave:Connect(function()
		tween(btn, TweenInfo.new(0.18, Enum.EasingStyle.Sine), {
			BackgroundTransparency = 0.16,
			Size = btn.Size - UDim2.fromOffset(4, 2),
		})
		if stroke then
			tween(stroke, TweenInfo.new(0.18, Enum.EasingStyle.Sine), {
				Transparency = 0.42,
			})
		end
		tween(cursorHalo, TweenInfo.new(0.16, Enum.EasingStyle.Sine), {
			Size = UDim2.fromOffset(34, 34),
			BackgroundTransparency = 0.78,
		})
	end))
end

local function playComets()
	for i, comet in ipairs(comets) do
		local delayStart = (i - 1) * 0.55
		task.delay(delayStart, function()
			while comet.Parent do
				comet.Position = UDim2.new(-0.25 - math.random() * 0.2, 0, math.random() * 0.7, 0)
				comet.BackgroundTransparency = 0.7 + math.random() * 0.15
				tween(comet, TweenInfo.new(2.6 + math.random(), Enum.EasingStyle.Linear), {
					Position = UDim2.new(1.2, 0, 0.2 + math.random() * 0.6, 0),
					BackgroundTransparency = 1,
				})
				task.wait(2.8 + math.random() * 1.8)
			end
		end)
	end
end

local function animateStarfield()
	task.spawn(function()
		while gui.Parent do
			for _, star in ipairs(allStars) do
				tween(star, TweenInfo.new(1.8 + math.random(), Enum.EasingStyle.Sine), {
					BackgroundTransparency = 0.05 + math.random() * 0.5,
				})
			end
			task.wait(1.6)
		end
	end)
end

local function pulseNebulas()
	task.spawn(function()
		while gui.Parent do
			for index, nebula in ipairs(nebulas) do
				local targetTransparency = 0.78 + math.random() * 0.15
				local dx = math.random(-14, 14)
				local dy = math.random(-14, 14)
				tween(nebula, TweenInfo.new(4 + index, Enum.EasingStyle.Sine), {
					BackgroundTransparency = targetTransparency,
					Position = nebula.Position + UDim2.fromOffset(dx, dy),
				})
			end
			task.wait(4)
		end
	end)
end

local function updateCursorTrail(position: Vector2)
	if #trailRegistry >= CONFIG.ParticleTrailMax then
		local oldest = table.remove(trailRegistry, 1)
		if oldest then
			oldest:Destroy()
		end
	end

	local particle = createTrailParticle()
	particle.Position = UDim2.fromOffset(position.X, position.Y)
	table.insert(trailRegistry, particle)

	tween(particle, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.fromOffset(1, 1),
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(position.X + math.random(-8, 8), position.Y + math.random(-8, 8)),
	}).Completed:Connect(function()
		if particle.Parent then
			particle:Destroy()
		end
	end)
end

local function setCardsVisible(visible: boolean)
	for _, entry in ipairs(cardRegistry) do
		local transparency = visible and 0.16 or 0.9
		local glowTransparency = visible and 0.9 or 1
		tween(entry.root, TweenInfo.new(CONFIG.AnimationSpeed, Enum.EasingStyle.Quad), {
			BackgroundTransparency = transparency,
		})
		tween(entry.glow, TweenInfo.new(CONFIG.AnimationSpeed, Enum.EasingStyle.Quad), {
			BackgroundTransparency = glowTransparency,
		})
	end
end

local function setCosmosVisible(visible: boolean)
	local backgroundTransparency = visible and 0 or 1
	local nebulaTransparency = visible and nil or 1

	tween(background, TweenInfo.new(CONFIG.AnimationSpeed, Enum.EasingStyle.Sine), {
		BackgroundTransparency = backgroundTransparency,
	})

	for _, star in ipairs(allStars) do
		tween(star, TweenInfo.new(CONFIG.AnimationSpeed, Enum.EasingStyle.Sine), {
			BackgroundTransparency = visible and (0.08 + math.random() * 0.3) or 1,
		})
	end

	for _, nebula in ipairs(nebulas) do
		tween(nebula, TweenInfo.new(CONFIG.AnimationSpeed, Enum.EasingStyle.Sine), {
			BackgroundTransparency = visible and (0.79 + math.random() * 0.12) or (nebulaTransparency :: number),
		})
	end

	for _, comet in ipairs(comets) do
		tween(comet, TweenInfo.new(0.28, Enum.EasingStyle.Sine), {
			BackgroundTransparency = visible and 0.6 or 1,
		})
	end
end

local function toggleMenu()
	menuVisible = not menuVisible

	if menuVisible then
		tween(lightPulse, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
			Size = UDim2.fromOffset(180, 180),
			BackgroundTransparency = 0.74,
		})
		tween(mainHolder, TweenInfo.new(0.48, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = CONFIG.MenuSize,
			Position = UDim2.fromScale(0.5, 0.52),
		})
		tween(menu, TweenInfo.new(0.42, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 0.2,
		})
		tween(menuShadow, TweenInfo.new(0.42, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 0.62,
		})
		tween(topGlow, TweenInfo.new(0.42, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 0.88,
		})
		tween(blur, TweenInfo.new(0.34, Enum.EasingStyle.Sine), {
			Size = 12,
		})
		setCosmosVisible(true)
		setCardsVisible(true)
		task.delay(0.12, function()
			tween(lightPulse, TweenInfo.new(0.42, Enum.EasingStyle.Quad), {
				Size = UDim2.fromOffset(8, 8),
				BackgroundTransparency = 0.15,
			})
		end)
	else
		tween(mainHolder, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.fromOffset(220, 120),
			Position = UDim2.fromScale(0.5, 0.5),
		})
		tween(menu, TweenInfo.new(0.34, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 0.65,
		})
		tween(menuShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 0.92,
		})
		tween(topGlow, TweenInfo.new(0.22, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 1,
		})
		tween(blur, TweenInfo.new(0.22, Enum.EasingStyle.Sine), {
			Size = 0,
		})
		setCosmosVisible(false)
		setCardsVisible(false)
		tween(lightPulse, TweenInfo.new(0.24, Enum.EasingStyle.Quad), {
			Size = UDim2.fromOffset(50, 50),
			BackgroundTransparency = 0.45,
		})
	end
end

local function playOpeningSequence()
	background.BackgroundTransparency = 1
	mainHolder.Size = UDim2.fromOffset(70, 40)
	menu.BackgroundTransparency = 1
	menuShadow.BackgroundTransparency = 1
	topGlow.BackgroundTransparency = 1
	blur.Size = 0

	for _, entry in ipairs(cardRegistry) do
		entry.root.BackgroundTransparency = 1
		entry.glow.BackgroundTransparency = 1
		entry.root.Position = entry.basePosition + UDim2.fromOffset(0, 26)
	end

	for _, star in ipairs(allStars) do
		star.BackgroundTransparency = 1
	end

	for _, nebula in ipairs(nebulas) do
		nebula.BackgroundTransparency = 1
	end

	for _, comet in ipairs(comets) do
		comet.BackgroundTransparency = 1
	end

	overlayFlash.BackgroundTransparency = 1
	lightPulse.Size = UDim2.fromOffset(6, 6)
	lightPulse.BackgroundTransparency = 0.05

	tween(lightPulse, TweenInfo.new(0.34, Enum.EasingStyle.Quad), {
		Size = UDim2.fromOffset(220, 220),
		BackgroundTransparency = 0.78,
	})

	tween(overlayFlash, TweenInfo.new(0.18, Enum.EasingStyle.Linear), {
		BackgroundTransparency = 0.72,
	})

	task.delay(0.08, function()
		tween(background, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
			BackgroundTransparency = 0,
		})
	end)

	task.delay(0.12, function()
		for _, nebula in ipairs(nebulas) do
			tween(nebula, TweenInfo.new(0.55, Enum.EasingStyle.Quad), {
				BackgroundTransparency = 0.8 + math.random() * 0.1,
			})
		end
	end)

	task.delay(0.14, function()
		for _, star in ipairs(allStars) do
			tween(star, TweenInfo.new(0.45 + math.random() * 0.35, Enum.EasingStyle.Sine), {
				BackgroundTransparency = 0.05 + math.random() * 0.28,
			})
		end
	end)

	task.delay(0.18, function()
		tween(mainHolder, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = CONFIG.MenuSize,
		})
		tween(menu, TweenInfo.new(0.55, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 0.2,
		})
		tween(menuShadow, TweenInfo.new(0.55, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 0.62,
		})
		tween(blur, TweenInfo.new(0.55, Enum.EasingStyle.Sine), {
			Size = 12,
		})
	end)

	task.delay(0.28, function()
		tween(topGlow, TweenInfo.new(0.48, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 0.88,
		})
	end)

	for index, entry in ipairs(cardRegistry) do
		task.delay(0.32 + index * 0.06, function()
			tween(entry.root, TweenInfo.new(0.42, Enum.EasingStyle.Quad), {
				BackgroundTransparency = 0.16,
				Position = entry.basePosition,
			})
			tween(entry.glow, TweenInfo.new(0.42, Enum.EasingStyle.Quad), {
				BackgroundTransparency = 0.9,
			})
		end)
	end

	task.delay(0.4, function()
		tween(overlayFlash, TweenInfo.new(0.42, Enum.EasingStyle.Linear), {
			BackgroundTransparency = 1,
		})
		tween(lightPulse, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
			Size = UDim2.fromOffset(8, 8),
			BackgroundTransparency = 0.15,
		})
	end)
end

table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
		toggleMenu()
	end
end))

table.insert(connections, RunService.RenderStepped:Connect(function(dt)
	local inset = GuiService:GetGuiInset()
	cursorTarget = Vector2.new(mouse.X, mouse.Y + inset.Y)
	cursorTrailSource = cursorTrailSource:Lerp(cursorTarget, math.clamp(dt * 18, 0, 1))

	cursor.Position = UDim2.fromOffset(cursorTrailSource.X, cursorTrailSource.Y)
	cursorHalo.Position = UDim2.fromOffset(cursorTrailSource.X, cursorTrailSource.Y)

	local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
	local normX = (cursorTarget.X / math.max(viewport.X, 1) - 0.5) * 2
	local normY = (cursorTarget.Y / math.max(viewport.Y, 1) - 0.5) * 2

	mainHolder.Position = UDim2.new(0.5, normX * CONFIG.ParallaxStrength, 0.52, normY * CONFIG.ParallaxStrength * 0.65)
	starsBack.Position = UDim2.fromOffset(-normX * 8, -normY * 8)
	starsFront.Position = UDim2.fromOffset(-normX * 16, -normY * 16)
	nebulaLayer.Position = UDim2.fromOffset(-normX * 24, -normY * 24)

	if CONFIG.UseCustomCursor then
		mouse.Icon = ""
	end

	if menuVisible then
		if math.random() < 0.36 then
			updateCursorTrail(cursorTrailSource)
		end
	end
end))

playComets()
animateStarfield()
pulseNebulas()
playOpeningSequence()

notifChip.MouseButton1Click:Connect(function()
	tween(notifCard, TweenInfo.new(0.22, Enum.EasingStyle.Quad), {
		Size = notifCard.Size + UDim2.fromOffset(0, 8),
	})
	task.delay(0.12, function()
		tween(notifCard, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
			Size = notifCard.Size - UDim2.fromOffset(0, 8),
		})
	end)
end)

syncChip.MouseButton1Click:Connect(function()
	tween(lightPulse, TweenInfo.new(0.18, Enum.EasingStyle.Sine), {
		Size = UDim2.fromOffset(160, 160),
		BackgroundTransparency = 0.78,
	})
	task.delay(0.16, function()
		tween(lightPulse, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
			Size = UDim2.fromOffset(8, 8),
			BackgroundTransparency = 0.15,
		})
	end)
end)

ctrlChip.MouseButton1Click:Connect(function()
	toggleMenu()
end)

gui.Destroying:Connect(function()
	for _, conn in ipairs(connections) do
		if conn.Connected then
			conn:Disconnect()
		end
	end
	if blur and blur.Parent then
		blur:Destroy()
	end
end)
