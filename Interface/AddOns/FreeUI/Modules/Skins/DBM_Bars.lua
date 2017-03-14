local F, C, L = unpack(FreeUI)

local function InitStyle()
	hooksecurefunc(DBT, "CreateBar", function(self)
		for bar in self:GetBarIterator() do
			local frame = bar.frame
			local name = frame:GetName().."Bar"
			local tbar = _G[name]
			local text = _G[name.."Name"]

			tbar:SetHeight(7)

			text:SetPoint("CENTER", 0, 10)
			text:SetPoint("LEFT", 2, 10)

			if not bar.styled then
				local texture = _G[frame:GetName().."BarTexture"]
				local timer = _G[frame:GetName().."BarTimer"]
				local spark = _G[frame:GetName().."BarSpark"]
				local icon = _G[frame:GetName().."BarIcon1"]

				F.CreateBDFrame(tbar, 0)

				texture:SetTexture(C.media.texture)
				texture.SetTexture = F.dummy

				timer:SetPoint("CENTER", 0, 10)
				timer:SetPoint("RIGHT", -2, 10)

				spark:SetSize(8, 16)
				spark.SetSize = F.dummy
				spark:SetTexture("Interface\\AddOns\\FreeUI\\media\\DBMSpark")

				icon:ClearAllPoints()
				icon:SetPoint("BOTTOMRIGHT", tbar, "BOTTOMLEFT", -4, -2)
				icon:SetTexCoord(.08, .92, .08, .92)
				F.CreateBG(icon)

				bar.styled = true
			end
		end
	end)

	local firstInfo = true
	hooksecurefunc(DBM.InfoFrame, "Show", function()
		if firstInfo then
			DBMInfoFrame:SetBackdrop(nil)
			local bd = CreateFrame("Frame", nil, DBMInfoFrame)
			bd:SetPoint("TOPLEFT")
			bd:SetPoint("BOTTOMRIGHT")
			bd:SetFrameLevel(DBMInfoFrame:GetFrameLevel()-1)
			F.CreateBD(bd)

			firstInfo = false
		end
	end)

	local firstRange = true
	hooksecurefunc(DBM.RangeCheck, "Show", function()
		if firstRange then
			DBMRangeCheck:SetBackdrop(nil)
			F.CreateBDFrame(DBMRangeCheck)

			DBMRangeCheckRadar.background:SetTexture("")
			F.CreateBDFrame(DBMRangeCheckRadar)

			DBMRangeCheckRadar.text:SetTextColor(1, 1, 1)
			DBMRangeCheckRadar.inRangeText:SetTextColor(1, 1, 1)

			firstRange = false
		end
	end)

end

if IsAddOnLoaded("DBM-Core") then
	InitStyle()
else
	local load = CreateFrame("Frame")
	load:RegisterEvent("ADDON_LOADED")
	load:SetScript("OnEvent", function(self, _, addon)
		if addon ~= "DBM-Core" then return end
		self:UnregisterEvent("ADDON_LOADED")

		InitStyle()

		load = nil
	end)
end