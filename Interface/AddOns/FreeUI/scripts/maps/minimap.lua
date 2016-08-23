local F, C, L = unpack(select(2, ...))

local r, g, b = unpack(C.class)

--
local Scale = C.minimap.scale
local position = C.minimap.position
local size = C.minimap.size
local texture = "Interface\\Buttons\\WHITE8x8"
local backdrop = {edgeFile = C.media.texture, edgeSize = 1}
local backdropcolor = {0/255, 0/255, 0/255}
local brdcolor = {0/255, 0/255, 0/255}


-----------------------------
-- Init
-----------------------------

MinimapCluster:SetScale(Scale)
MinimapCluster:ClearAllPoints()
MinimapCluster:SetPoint(position.a1,position.af,position.a2,position.x,position.y)
MinimapCluster:EnableMouse(false)
MinimapCluster:SetClampedToScreen(false)
MinimapCluster:SetSize(size*Scale, size*Scale)

Minimap:SetClampedToScreen(false)
Minimap:SetSize(size*Scale, size*Scale)
Minimap:SetMaskTexture[[Interface\AddOns\FreeUI\media\rectangle]]
Minimap:SetHitRectInsets(0, 0, 34*Scale, 34*Scale)
Minimap:SetFrameLevel(2)
Minimap:ClearAllPoints()
Minimap:SetAllPoints(MinimapCluster)
Minimap:SetScale(Scale)

BorderFrame = CreateFrame("Frame", nil, Minimap)
BorderFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -1, -(32*Scale))
BorderFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 1, (32*Scale))	
BorderFrame:SetBackdrop(backdrop)
BorderFrame:SetBackdropBorderColor(unpack(brdcolor))
BorderFrame:SetBackdropColor(unpack(backdropcolor))
BorderFrame:SetFrameLevel(6)

F.CreateSD(BorderFrame)

-- on click mechanic
Minimap:SetScript('OnMouseUp', function(self, button)
	Minimap:StopMovingOrSizing()
	if button == 'RightButton' then
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, - (Minimap:GetWidth() * .7), -3)
	elseif button == 'MiddleButton' then
		securecall(ToggleCalendar)
	else
		Minimap_OnClick(self)
	end
end)

-- scrolling zoom
Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, arg1)
	if arg1 > 0 then Minimap_ZoomIn() else Minimap_ZoomOut() end
end)

-- hide specific stuff
do
	local frames = {
		"MiniMapInstanceDifficulty",
		"MiniMapVoiceChatFrame",
		"MiniMapWorldMapButton",
		"MiniMapMailBorder",
		"MinimapBorderTop",
		"MinimapNorthTag",
		"MiniMapTracking",
		"MinimapZoomOut",
		"MinimapZoomIn",
		"MinimapBorder",
	}

	for i = 1, #frames do
		_G[frames[i]]:Hide()
		_G[frames[i]].Show = F.dummy
	end
end

LoadAddOn'Blizzard_TimeManager'
local region = TimeManagerClockButton:GetRegions()
region:Hide()
TimeManagerClockButton:Hide()

-- garrison/orderhall
GarrisonLandingPageMinimapButton:ClearAllPoints()
GarrisonLandingPageMinimapButton:SetParent(Minimap)
GarrisonLandingPageMinimapButton:SetPoint('TOPRIGHT', Minimap, -3, -30)
GarrisonLandingPageMinimapButton:SetSize(36, 36)
hooksecurefunc('GarrisonLandingPageMinimapButton_UpdateIcon', function(self)
	self:SetNormalTexture('')
	self:SetPushedTexture('')
	self:SetHighlightTexture('')
	
	local icon = self:CreateTexture(nil,'OVERLAY',nil,7)
	icon:SetSize(24, 24)
	icon:SetPoint('CENTER')
	icon:SetTexture([[Interface/AddOns/FreeUI/media/garrison2]])
	icon:SetVertexColor(1, 1, 1)
	self.icon = icon
	
	if (C_Garrison.GetLandingPageGarrisonType() == LE_GARRISON_TYPE_6_0) then
		self.title = GARRISON_LANDING_PAGE_TITLE;
		self.description = MINIMAP_GARRISON_LANDING_PAGE_TOOLTIP;
	else
		self.title = ORDER_HALL_LANDING_PAGE_TITLE;
		self.description = MINIMAP_ORDER_HALL_LANDING_PAGE_TOOLTIP;
	end
end)

GarrisonLandingPageMinimapButton:SetScript('OnEnter', function(self) 
	--self.icon:SetVertexColor(color.r, color.g, color.b)
	self.icon:SetVertexColor(1, .8, 0)
end)

GarrisonLandingPageMinimapButton:SetScript('OnLeave', function(self) 
	self.icon:SetVertexColor(1, 1, 1)
end)
--[[
GarrisonLandingPageMinimapButton:SetScript('OnMouseDown', function(self) 
	self.icon:SetVertexColor(0, 1, 1)
end)
				
GarrisonLandingPageMinimapButton:SetScript('OnMouseUp', function(self) 
	self.icon:SetVertexColor(1, .8, 0)
end)
]]			
GarrisonMinimapBuilding_ShowPulse = function() end

-- difficulty
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint('TOPLEFT', Minimap, 3, -30)
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint('TOPLEFT', Minimap, 3, -30)
MiniMapChallengeMode:ClearAllPoints()
MiniMapChallengeMode:SetPoint('TOPLEFT', Minimap, 3, -30)

-- lfg/lfr/pvp
local lfg = MiniMapLFGFrame or QueueStatusMinimapButton
lfg:SetScale(.9)
lfg:ClearAllPoints()
lfg:SetParent(Minimap)
lfg:SetFrameStrata'HIGH'
lfg:SetPoint('BOTTOMLEFT', Minimap, 3, 30)
lfg:SetHighlightTexture(nil)
QueueStatusMinimapButtonBorder:SetTexture(nil)
--QueueStatusMinimapButtonBorder:SetPoint("TOPLEFT", lfg, "TOPLEFT", -4, 4)
--QueueStatusMinimapButtonBorder:SetPoint("BOTTOMRIGHT", lfg, "BOTTOMRIGHT", 4, -4)
--QueueStatusMinimapButtonBorder:SetVertexColor(0, 0, 0, 1)

-- mail
-- MiniMapMailFrame:ClearAllPoints()
-- MiniMapMailFrame:SetParent(Minimap)
-- MiniMapMailFrame:SetFrameStrata'HIGH'
-- MiniMapMailFrame:SetPoint('BOTTOM', Minimap, 0, 27)
-- MiniMapMailIcon:ClearAllPoints()
-- MiniMapMailIcon:SetTexCoord(.1, .9, .1, .9)
-- MiniMapMailIcon:SetTexture([[Interface\AddOns\FreeUI\media\mail]])
-- MiniMapMailIcon:SetPoint("TOPLEFT", MiniMapMailFrame, "TOPLEFT", 8, -8)
-- MiniMapMailIcon:SetPoint("BOTTOMRIGHT", MiniMapMailFrame, "BOTTOMRIGHT", -8, 8)

local mail = CreateFrame("Frame", "FreeUIMailFrame", Minimap)
mail:Hide()
mail:RegisterEvent("UPDATE_PENDING_MAIL")
mail:SetScript("OnEvent", function(self)
	if HasNewMail() then
		self:Show()
	else
		self:Hide()
	end
end)

MiniMapMailFrame:HookScript("OnMouseUp", function(self)
	self:Hide()
	mail:Hide()
end)

local mt = F.CreateFS(mail)
mt:SetText("Mail")
mt:SetTextColor(r, g, b)
mt:SetPoint("BOTTOM", Minimap, 0, 36)

MiniMapMailFrame:SetAlpha(0)
MiniMapMailFrame:SetSize(22, 10)
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("CENTER", mt)

-- durability
--[[
DurabilityFrame:Hide()
DurabilityFrame:UnregisterAllEvents()
DurabilityFrame.Show = function() end
]]

hooksecurefunc(DurabilityFrame, 'SetPoint', function(self, _, parent)
	if parent=='MinimapCluster' or parent==_G['MinimapCluster'] then
		self:ClearAllPoints()
		self:SetPoint('RIGHT', Minimap, 'LEFT', -50, -250)
		self:SetScale(.7)
	end
end)


-- VEHICLE SEAT INDICATOR
hooksecurefunc(VehicleSeatIndicator,'SetPoint', function(self, _, parent)
	if parent=='MinimapCluster' or parent==_G['MinimapCluster'] then
		self:ClearAllPoints()
		self:SetPoint('RIGHT', Minimap, 'LEFT', -50, -250)
		self:SetScale(.7)
	end
end)

-- move zonetextframe
ZoneTextFrame:SetFrameStrata("MEDIUM")
SubZoneTextFrame:SetFrameStrata("MEDIUM")

ZoneTextString:ClearAllPoints()
ZoneTextString:SetPoint("CENTER", Minimap)
ZoneTextString:SetWidth(138)
F.SetFS(ZoneTextString)
F.SetFS(SubZoneTextString)
SubZoneTextString:SetWidth(138)
F.SetFS(PVPInfoTextString)
PVPInfoTextString:SetWidth(138)
F.SetFS(PVPArenaTextString)
PVPArenaTextString:SetWidth(138)

MinimapZoneTextButton:ClearAllPoints()
MinimapZoneTextButton:SetPoint("CENTER", Minimap)
MinimapZoneTextButton:SetFrameStrata("HIGH")
MinimapZoneTextButton:EnableMouse(false)
MinimapZoneTextButton:SetAlpha(0)
MinimapZoneText:SetPoint("CENTER", MinimapZoneTextButton)
F.SetFS(MinimapZoneText)
MinimapZoneText:SetShadowColor(0, 0, 0, 0)
MinimapZoneText:SetJustifyH("CENTER")

Minimap:HookScript("OnEnter", function()
	MinimapZoneTextButton:SetAlpha(1)
end)
Minimap:HookScript("OnLeave", function()
	MinimapZoneTextButton:SetAlpha(0)
end)


-- world capture bar
hooksecurefunc('UIParent_ManageFramePositions', function()
	if NUM_EXTENDED_UI_FRAMES then
		for i = 1, NUM_EXTENDED_UI_FRAMES do
			local bar = _G['WorldStateCaptureBar'..i]
			if bar and bar:IsVisible() then
				bar:ClearAllPoints()
				if i == 1 then
					bar:SetPoint('BOTTOM', MinimapCluster, 'TOP', 0, 30)
				else
					bar:SetPoint('BOTTOM', _G['WorldStateCaptureBar'..(i - 1)], 'TOP', 0, 20)
				end
			end
		end
	end
end)


--MiniMapNorthTag
MinimapNorthTag:ClearAllPoints()
MinimapNorthTag:SetPoint("TOP",Minimap,0,-3)
MinimapNorthTag:SetAlpha(0)

Minimap:SetArchBlobRingScalar(0)
Minimap:SetQuestBlobRingScalar(0)

GuildInstanceDifficulty:SetAlpha(0)
MiniMapChallengeMode:GetRegions():SetTexture("")



GameTimeFrame:ClearAllPoints()
GameTimeFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -1, -33)
GameTimeFrame:SetSize(16, 16)
GameTimeFrame:SetHitRectInsets(0, 0, 0, 0)
GameTimeFrame:SetNormalTexture("")
GameTimeFrame:SetPushedTexture("")
GameTimeFrame:SetHighlightTexture("")

local _, _, _, _, dateText = GameTimeFrame:GetRegions()
F.SetFS(dateText)
dateText:SetTextColor(r, g, b)
dateText:SetShadowOffset(0, 0)
dateText:SetPoint("CENTER")

QueueStatusMinimapButtonBorder:SetAlpha(0)
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("BOTTOMRIGHT", Minimap, 0, 36)
QueueStatusMinimapButton:SetHighlightTexture("")
QueueStatusMinimapButton.Eye.texture:SetTexture("")

QueueStatusFrame:ClearAllPoints()
QueueStatusFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", -4, 33)

local dots = {}
for i = 1, 8 do
	dots[i] = F.CreateFS(QueueStatusMinimapButton, 18)
	dots[i]:SetText(".")
end
dots[1]:SetPoint("TOP", 2, 2)
dots[2]:SetPoint("TOPRIGHT", -6, -1)
dots[3]:SetPoint("RIGHT", -3, 2)
dots[4]:SetPoint("BOTTOMRIGHT", -6, 5)
dots[5]:SetPoint("BOTTOM", 2, 2)
dots[6]:SetPoint("BOTTOMLEFT", 9, 5)
dots[7]:SetPoint("LEFT", 6, 2)
dots[8]:SetPoint("TOPLEFT", 9, -1)

local counter = 0
local last = 0
local interval = .06
local diff = .014

local function onUpdate(self, elapsed)
	last = last + elapsed
	if last >= interval then
		counter = counter + 1

		dots[counter]:SetShown(not dots[counter]:IsShown())

		if counter == 8 then
			counter = 0
			diff = diff * -1
		end

		interval = interval + diff
		last = 0
	end
end

hooksecurefunc("EyeTemplate_StartAnimating", function(eye)
	eye:SetScript("OnUpdate", onUpdate)
end)

hooksecurefunc("EyeTemplate_StopAnimating", function(eye)
	for i = 1, 8 do
		dots[i]:Show()
	end
	counter = 0
	last = 0
	interval = .06
	diff = .014
end)

QueueStatusMinimapButton:HookScript("OnEnter", function()
	for i = 1, 8 do
		dots[i]:SetTextColor(r, g, b)
	end
end)

QueueStatusMinimapButton:HookScript("OnLeave", function()
	for i = 1, 8 do
		dots[i]:SetTextColor(1, 1, 1)
	end
end)

TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -49, 0)

local rd = CreateFrame("Frame", nil, Minimap)
rd:SetSize(24, 8)
rd:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 5, -37)
rd:RegisterEvent("PLAYER_ENTERING_WORLD")
rd:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
rd:RegisterEvent("GUILD_PARTY_STATE_UPDATED")
rd:RegisterEvent("INSTANCE_GROUP_SIZE_CHANGED")

local rdt = F.CreateFS(rd, C.FONT_SIZE_NORMAL, "LEFT")
rdt:SetPoint("TOPLEFT")

local instanceTexts = {
	[0] = "",
	[1] = "5",
	[2] = "5H",
	[3] = "10",
	[4] = "25",
	[5] = "10H",
	[6] = "25H",
	[7] = "RF",
	[8] = "CM",
	[9] = "40",
	[11] = "3H",
	[12] = "3",
	[16] = "M",
	[23] = "5M",	-- Mythic 5-player
	[24] = "5T",	-- Timewalker 5-player
}

rd:SetScript("OnEvent", function()
	local inInstance, instanceType = IsInInstance()
	local _, _, difficultyID, _, maxPlayers, _, _, _, instanceGroupSize = GetInstanceInfo()

	if instanceTexts[difficultyID] ~= nil then
		rdt:SetText(instanceTexts[difficultyID])
	else
		if difficultyID == 14 then
			rdt:SetText(instanceGroupSize.."N")
		elseif difficultyID == 15 then
			rdt:SetText(instanceGroupSize.."H")
		elseif difficultyID == 17 then
			rdt:SetText(instanceGroupSize.."RF")
		else
			rdt:SetText("")
		end
	end

	rd:SetShown(inInstance and (instanceType == "party" or instanceType == "raid" or instanceType == "scenario"))

	if GuildInstanceDifficulty:IsShown() then
		rdt:SetTextColor(0, .9, 0)
	else
		rdt:SetTextColor(1, 1, 1)
	end
end)

HelpOpenTicketButtonTutorial:Hide()
HelpOpenTicketButtonTutorial.Show = F.dummy

local function positionTicketButtons()
	if HelpOpenTicketButton:IsShown() then
		if HelpOpenWebTicketButton:IsShown() then
			HelpOpenTicketButton:ClearAllPoints()
			HelpOpenTicketButton:SetPoint("TOP", Minimap, "TOP", -17, -5)
			HelpOpenWebTicketButton:ClearAllPoints()
			HelpOpenWebTicketButton:SetPoint("TOP", Minimap, "TOP", 17, -5)
		else
			HelpOpenTicketButton:ClearAllPoints()
			HelpOpenTicketButton:SetPoint("TOP", Minimap, "TOP", 0, -5)
		end
	elseif HelpOpenWebTicketButton:IsShown() then
		HelpOpenWebTicketButton:ClearAllPoints()
		HelpOpenWebTicketButton:SetPoint("TOP", Minimap, "TOP", 0, -5)
	end
end

for _, ticketButton in pairs({HelpOpenTicketButton, HelpOpenWebTicketButton}) do
	ticketButton:SetParent(Minimap)
	ticketButton:SetHeight(8)
	ticketButton:SetHitRectInsets(0, 0, 0, 0)
	ticketButton:ClearAllPoints()

	ticketButton:SetNormalTexture("")
	ticketButton:SetHighlightTexture("")
	ticketButton:SetPushedTexture("")

	local gmtext = F.CreateFS(ticketButton)
	gmtext:SetPoint("CENTER", 2, -33)
	gmtext:SetText(gsub(CHAT_FLAG_GM, "[<>]", "")) -- magic!

	ticketButton:HookScript("OnShow", positionTicketButtons)
	ticketButton:HookScript("OnHide", positionTicketButtons)
end


