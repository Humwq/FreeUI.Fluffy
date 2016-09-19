local SCALE			= 1
local WIDTH 		= 256
local HEIGHT 		= 2
local _, CLASS 		= UnitClass("player")
local COLOR			= CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[CLASS] or RAID_CLASS_COLORS[CLASS]
local POSITION		= {"TOP", Minimap, "BOTTOM", 0, 32}
local OFFSET		= -4
local TIP			= {"TOPRIGHT", UIParent, -275, -235}
local TEXTURE 		= [[Interface/AddOns/FreeUI/media/statusbar]]

-- LOCALE
local L = {}
if (GetLocale() == "zhCN") then
	L = {
		["Hated"]		= "仇恨",
		["Hostile"]		= "敌对",
		["Unfriendly"]	= "冷淡",
		["Neutral"]		= "中立",
		["Friendly"]	= "友善",
		["Honored"]		= "尊敬",
		["Revered"]		= "崇敬",
		["Exalted"]		= "崇拜",
	}
else
	L = {
		["Hated"]		= "Hated",
		["Hostile"]		= "Hostile",
		["Unfriendly"]	= "Unfriendly",
		["Neutral"]		= "Neutral",
		["Friendly"]	= "Friendly",
		["Honored"]		= "Honored",
		["Revered"]		= "Revered",
		["Exalted"]		= "Exalted",
	}
end

-- DATA METHODS
local FactionInfo = {
	[1] = {170/255, 70/255, 70/255, L["Hated"], "FFaa4646"},
	[2] = {170/255, 70/255, 70/255, L["Hostile"], "FFaa4646"},
	[3] = {170/255, 70/255, 70/255, L["Unfriendly"], "FFaa4646"},
	[4] = {200/255, 180/255, 100/255, L["Neutral"], "FFc8b464"},
	[5] = {75/255, 175/255, 75/255, L["Friendly"], "FF4baf4b"},
	[6] = {75/255, 175/255, 75/255, L["Honored"], "FF4baf4b"},
	[7] = {75/255, 175/255, 75/255, L["Revered"], "FF4baf4b"},
	[8] = {155/255, 255/255, 155/255, L["Exalted"],"FF9bff9b"},
}

f = CreateFrame("Frame", nil, UIParent)
f:SetPoint(POSITION[1], POSITION[2], POSITION[3], POSITION[4], POSITION[5])
f:SetWidth(WIDTH)
f:SetHeight(HEIGHT)
f:SetScale(SCALE)

-- SETUP BARS
local setBar = function(frame)
	frame:SetStatusBarTexture(TEXTURE)
	frame:SetWidth(WIDTH)
	frame:SetHeight(HEIGHT)
	frame:SetScale(SCALE)
end

local setBackdrop = function(frame) 
	frame.bg = CreateFrame("Frame", nil, frame)
	frame.bg:SetBackdrop({
		bgFile = [[Interface/Buttons/WHITE8X8]],
		tiled = false,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	})
	frame.bg:SetPoint("TOPLEFT", frame, -1, 1)
	frame.bg:SetPoint("BOTTOMRIGHT", frame, 1, -1)
	frame.bg:SetFrameLevel(1)
	frame.bg:SetBackdropColor(0, 0, 0, .35)
end

local Experience = CreateFrame("StatusBar", nil, f)
setBar(Experience)
Experience:SetFrameLevel(4)
Experience:SetStatusBarColor(.4, .1, .6)
Experience:SetPoint(POSITION[1], POSITION[2], POSITION[3], POSITION[4], POSITION[5])
setBackdrop(Experience)

local Rest = CreateFrame("StatusBar", nil, Experience)
setBar(Rest)
Rest:SetFrameLevel(3)
Rest:EnableMouse(false)
Rest:SetStatusBarColor(.2, .4, .8)
Rest:SetAllPoints(Experience)

local Artifact = CreateFrame("StatusBar", nil, f)
setBar(Artifact)
Artifact:SetFrameLevel(4)
Artifact:SetStatusBarColor(230/255, 204/255, 128/255)
setBackdrop(Artifact)

local Reputation = CreateFrame("StatusBar", nil, f)
setBar(Reputation)
Reputation:SetFrameLevel(4)
setBackdrop(Reputation)

local numberize = function(v)
	if v <= 9999 then return v end
	if v >= 1000000 then
		local value = string.format("%.1fm", v/1000000)
		return value
	elseif v >= 10000 then
		local value = string.format("%.1fk", v/1000)
		return value
	end
end

local experience_update = function()
	if UnitLevel("player") < MAX_PLAYER_LEVEL and not IsXPUserDisabled() then
		local c, m = UnitXP("player"), UnitXPMax("player")
		local p, r = math.ceil(c/m*100), GetXPExhaustion()

		Experience:SetMinMaxValues(min(0, c), m)
		Experience:SetValue(c)
		Rest:SetMinMaxValues(min(0, c), m)
		Rest:SetValue(r and (c + r) or 0)
	else
		Experience:Hide() 
		Rest:Hide()
	end
end

local showExperienceTooltip = function(self)
	if UnitLevel("player") < MAX_PLAYER_LEVEL and not IsXPUserDisabled() then
		local xpc, xpm, xpr = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion("player")

		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint(TIP[1], TIP[2], TIP[3], TIP[4], TIP[5])

		GameTooltip:AddLine("Level "..UnitLevel("player"), COLOR.r, COLOR.g, COLOR.b)
		GameTooltip:AddLine((numberize(xpc).."/"..numberize(xpm).." ("..floor((xpc/xpm)*100) .."%)"), 1, 1, 1)
		if xpr then
			GameTooltip:AddLine(numberize(xpr).." ("..floor((xpr/xpm)*100) .."%)", .2, .4, .8)
		end

		GameTooltip:Show()
	end
end

local reputation_update = function()
	if GetWatchedFactionInfo() then
		local name, rank, minRep, maxRep, value = GetWatchedFactionInfo()

		Reputation:ClearAllPoints()
		Reputation:SetMinMaxValues(minRep, maxRep)
		Reputation:SetValue(value)
		Reputation:SetStatusBarColor(FactionInfo[rank][1], FactionInfo[rank][2], FactionInfo[rank][3])

		local y = POSITION[5]
		if Experience:IsShown() then
			y = y + OFFSET
		end
		Reputation:SetPoint(POSITION[1], POSITION[2], POSITION[3], POSITION[4], y)
		Reputation:Show()
	else
		Reputation:Hide()
	end
end

local showReputationTooltip = function(self)
	if GetWatchedFactionInfo() then
		local name, rank, start, cap, value = GetWatchedFactionInfo()

		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint(TIP[1], TIP[2], TIP[3], TIP[4], TIP[5])

		GameTooltip:AddDoubleLine("Reputation:", name, r, g, b, 1, 1, 1)
		GameTooltip:AddDoubleLine("Standing:", string.format("|c"..FactionInfo[rank][5].."%s|r", FactionInfo[rank][4]), r, g, b)
		GameTooltip:AddDoubleLine("Rep:", string.format("%s/%s (%d%%)", BreakUpLargeNumbers(value-start), BreakUpLargeNumbers(cap-start), (value-start)/(cap-start)*100), r, g, b, 1, 1, 1)
		GameTooltip:AddDoubleLine("Remaining:", string.format("%s", BreakUpLargeNumbers(cap-value)), r, g, b, 1, 1, 1)

		GameTooltip:Show()
	end
end

local artifact_update = function(self, event)
	if HasArtifactEquipped() then
		local id, altid, name, icon, total, spent, q = C_ArtifactUI.GetEquippedArtifactInfo()	
		local num, xp, next = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(spent, total)
		local percent = math.ceil(xp/next*100)

		Artifact:ClearAllPoints()
		Artifact:SetMinMaxValues(0, next)
		Artifact:SetValue(xp)

		local y = POSITION[5]
		if Experience:IsShown() then
			y = y + OFFSET
		end
		if Reputation:IsShown() then
			y = y + OFFSET
		end
		Artifact:SetPoint(POSITION[1], POSITION[2], POSITION[3], POSITION[4], y)
		Artifact:Show()
	else
		Artifact:Hide()
	end
end

local showArtifactTooltip = function(self) 
	if HasArtifactEquipped() then
		local id, altid, name, icon, total, spent, q = C_ArtifactUI.GetEquippedArtifactInfo()
		local num, xp, next = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(spent, total)
		local percent = math.ceil(xp/next*100)

		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint(TIP[1], TIP[2], TIP[3], TIP[4], TIP[5])

		GameTooltip:AddLine(name, COLOR.r, COLOR.g, COLOR.b)
		GameTooltip:AddLine("Spended Points: " .. spent, 1, 1, 1)
		GameTooltip:AddLine("Points to spend: " .. num, 1, 1, 1)
		GameTooltip:AddLine("Artifact Power: "..percent.."%", 1, 1, 1)
		GameTooltip:AddLine("Next trait: " .. xp .. "/" .. next, 1, 1, 1)

		GameTooltip:Show()
	end
end

-- events
Experience:RegisterEvent("PLAYER_ENTERING_WORLD")
Experience:RegisterEvent("PLAYER_LEVEL_UP")
Experience:RegisterEvent("PLAYER_XP_UPDATE")
Experience:RegisterEvent("UPDATE_EXHAUSTION")
Experience:SetScript("OnEvent", experience_update)
Experience:SetScript("OnEnter", function() showExperienceTooltip(Experience) end)
Experience:SetScript("OnLeave", function() GameTooltip:Hide() end)

Reputation:RegisterEvent("PLAYER_ENTERING_WORLD")
Reputation:RegisterEvent("PLAYER_LEVEL_UP")
Reputation:RegisterEvent("UPDATE_EXHAUSTION")
Reputation:RegisterEvent("UPDATE_FACTION")
Reputation:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
Reputation:SetScript("OnEvent", reputation_update)
Reputation:SetScript("OnEnter", function() showReputationTooltip(Reputation) end)
Reputation:SetScript("OnLeave", function() GameTooltip:Hide() end)

Artifact:RegisterEvent("PLAYER_ENTERING_WORLD")
Artifact:RegisterEvent("PLAYER_LEVEL_UP")
Artifact:RegisterEvent("UPDATE_EXHAUSTION")
Artifact:RegisterEvent("UPDATE_FACTION")
Artifact:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
Artifact:RegisterEvent("ARTIFACT_XP_UPDATE")
Artifact:RegisterEvent("ARTIFACT_UPDATE")
Artifact:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
Artifact:SetScript("OnEvent", artifact_update)
Artifact:SetScript("OnEnter", function() showArtifactTooltip(Artifact) end)
Artifact:SetScript("OnLeave", function() GameTooltip:Hide() end)