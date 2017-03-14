local F, C, L = unpack(select(2, ...))

-- Remove Boss Banner
if C.general.bossBanner == false then
	BossBanner.PlayBanner = function() end
end

-- Remove Talking Head Frame
if C.general.talkingHead == false then
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", function(self, event, addon)
		if addon == "Blizzard_TalkingHeadUI" then
			hooksecurefunc("TalkingHeadFrame_PlayCurrent", function()
				TalkingHeadFrame:Hide()
			end)
			self:UnregisterEvent(event)
		end
	end)
end
