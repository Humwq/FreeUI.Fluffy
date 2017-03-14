local _, private = ...

-- [[ Lua Globals ]]
local _G = _G
local select = _G.select

-- [[ WoW API ]]
local CreateFrame = _G.CreateFrame

-- [[ Core ]]
local F, C = _G.unpack(private.Aurora)

C.themes["Blizzard_ArtifactUI"] = function()
	F.CreateBD(ArtifactFrame)
	F.CreateSD(ArtifactFrame)
	ArtifactFrame.Background:Hide()
	ArtifactFrame.PerksTab.HeaderBackground:Hide()
	ArtifactFrame.PerksTab.BackgroundBackShadow:Hide()
	ArtifactFrame.PerksTab.BackgroundBack:Hide()
	ArtifactFrame.PerksTab.TitleContainer.Background:SetAlpha(0)
	ArtifactFrame.PerksTab.Model.BackgroundFront:Hide()
	ArtifactFrame.PerksTab.Model:SetAlpha(.2)
	ArtifactFrame.PerksTab.AltModel:SetAlpha(.2)
	ArtifactFrame.BorderFrame:Hide()
	ArtifactFrame.ForgeBadgeFrame.ForgeClassBadgeIcon:Hide()
	ArtifactFrame.ForgeBadgeFrame.ForgeLevelBackground:ClearAllPoints()
	ArtifactFrame.ForgeBadgeFrame.ForgeLevelBackground:SetPoint("TOPLEFT", ArtifactFrame, "TOPLEFT", 5, -5 )
	ArtifactFrame.ForgeBadgeFrame.ForgeLevelBackground:SetAlpha(0)
	ArtifactFrame.AppearancesTab.Background:Hide()

	F.ReskinClose(ArtifactFrame.CloseButton)
	
	ArtifactFrame.AppearancesTab:HookScript("OnShow", function()
		for i = 1, 25 do
			local bu = select(i, ArtifactFrame.AppearancesTab:GetChildren())
			if bu then
				bu.Background:Hide()
				if bu:GetWidth() > 400 then
					F.CreateGradient(bu)
					F.CreateBD(bu, 0)
					bu.Name:SetTextColor(1, 1, 1)
				else
					bu.SwatchTexture:SetTexture(C.media.backdrop)
					bu.SwatchTexture:SetTexCoord(.2, .8, .2, .8)
					bu.SwatchTexture:SetAllPoints()
					bu.Border:SetAlpha(0)
					bu.HighlightTexture:Hide()
					bu.Selected:SetAlpha(0)
					bu.Selected.SetAlpha = F.dummy
					bu.bg = CreateFrame("Frame", nil, bu)
					bu.bg:SetPoint("TOPLEFT", -1, 1)
					bu.bg:SetPoint("BOTTOMRIGHT", 1, -1)
					bu.bg:SetFrameLevel(bu:GetFrameLevel()-1)
					F.CreateBD(bu.bg, 0)
				end
			end
		end
	end)
	 
	hooksecurefunc(ArtifactFrame.AppearancesTab, "Refresh", function()
		for i = 1, 20 do
			local bu = select(i, ArtifactFrame.AppearancesTab:GetChildren())
			if bu and bu.bg then
				if bu.Selected:IsShown() then
					bu.bg:SetBackdropBorderColor(1, 1, 0)
				else
					bu.bg:SetBackdropBorderColor(0, 0, 0)
				end
			end
		end
	end)
	
	F.ReskinTab(ArtifactFrame.PerksTabButton)
	F.ReskinTab(ArtifactFrame.AppearancesTabButton)
	
	ArtifactFrame.PerksTabButton:ClearAllPoints()
	ArtifactFrame.PerksTabButton:SetPoint("TOPLEFT", ArtifactFrame, "BOTTOMLEFT", 11, 2)
end