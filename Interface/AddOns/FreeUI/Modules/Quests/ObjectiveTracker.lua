local F, C, L = unpack(select(2, ...))

if not C.quests.questObjectiveTrackerStyle then return end

local class = select(2, UnitClass("player"))
local r, g, b = C.classcolours[class].r, C.classcolours[class].g, C.classcolours[class].b

local ot = ObjectiveTrackerFrame
local BlocksFrame = ot.BlocksFrame

local otFont = C.fontCN.pixel

local parent = CreateFrame("Frame", nil, UIParent)
parent:SetFrameStrata("HIGH")
RegisterStateDriver(parent, "visibility", "[petbattle] hide; show")
local Mover = CreateFrame("Button", "ObjectiveTrackerAnchor", parent)
Mover:SetPoint(unpack(C.quests.position))
Mover:SetSize(22, 22)
Mover.Icon = Mover:CreateTexture(nil, "ARTWORK")
Mover.Icon:SetAllPoints()
Mover.Icon:SetTexture("Interface\\WorldMap\\Gear_64")
Mover.Icon:SetTexCoord(0, .5, 0, .5)
Mover.Icon:SetAlpha(.2)
Mover:SetHighlightTexture("Interface\\WorldMap\\Gear_64")
Mover:GetHighlightTexture():SetTexCoord(0, .5, 0, .5)
F.CreateGT(Mover, "Drag to move", "system")
F.CreateMF(Mover)


hooksecurefunc(ot, "SetPoint", function(_, _, parent)
	if parent ~= Mover then
		ot:ClearAllPoints()
		ot:SetPoint("TOPRIGHT", Mover, "TOPLEFT", -5, 0)
		ot:SetHeight(GetScreenHeight() - 400)
	end
end)
hooksecurefunc("ObjectiveTracker_CheckAndHideHeader", function() Mover:SetShown(ot.HeaderMenu:IsShown()) end)


-- [[ Difficulty color for ObjectiveTrackerFrame lines ]]

hooksecurefunc(QUEST_TRACKER_MODULE, "Update", function()
	for i = 1, GetNumQuestWatches() do
		local questID, _, questIndex = GetQuestWatchInfo(i)
		if not questID then
			break
		end
		local _, level = GetQuestLogTitle(questIndex)
		local col = GetQuestDifficultyColor(level)
		local block = QUEST_TRACKER_MODULE:GetExistingBlock(questID)
		if block then
			block.HeaderText:SetTextColor(col.r, col.g, col.b)
			block.HeaderText.col = col
		end
	end
end)

hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", function(self, block)
	if block.module == ACHIEVEMENT_TRACKER_MODULE then
		block.HeaderText:SetTextColor(0.75, 0.61, 0)
		block.HeaderText.col = nil
	end
end)

hooksecurefunc("ObjectiveTrackerBlockHeader_OnLeave", function(self)
	local block = self:GetParent()
	if block.HeaderText.col then
		block.HeaderText:SetTextColor(block.HeaderText.col.r, block.HeaderText.col.g, block.HeaderText.col.b)
	end
end)


-- [[ Header ]]

-- Header

if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
	if C.appearance.fontUseChinesePixelFont then
		ot.HeaderMenu.Title:SetFont(unpack(otFont))
	else
		ot.HeaderMenu.Title:SetFont(C.media.font.header, 16, "OUTLINE")
	end
else
	F.SetFS(ot.HeaderMenu.Title)
end

-- Minimize button

local minimizeButton = ot.HeaderMenu.MinimizeButton

F.ReskinExpandOrCollapse(minimizeButton)
minimizeButton:SetSize(15, 15)
minimizeButton.plus:Hide()

hooksecurefunc("ObjectiveTracker_Collapse", function()
	minimizeButton.plus:Show()
	FreeUIConfig.objectiveTracker.collapsed = true
end)

hooksecurefunc("ObjectiveTracker_Expand", function()
	minimizeButton.plus:Hide()
	FreeUIConfig.objectiveTracker.collapsed = false
end)

-- [[ Blocks and lines ]]

for _, headerName in pairs({"QuestHeader", "AchievementHeader", "ScenarioHeader"}) do
	local header = BlocksFrame[headerName]

	if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
		if C.appearance.fontUseChinesePixelFont then
			header.Text:SetFont(unpack(otFont))
		else
			header.Text:SetFont(C.media.font.header, 16, "OUTLINE")
		end
	else
		F.SetFS(header.Text)
	end
end

do
	local header = BONUS_OBJECTIVE_TRACKER_MODULE.Header

	if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
		if C.appearance.fontUseChinesePixelFont then
			header.Text:SetFont(unpack(otFont))
		else
			header.Text:SetFont(C.media.font.header, 16, "OUTLINE")
		end
	else
		F.SetFS(header.Text)
	end
end

do
	local header = WORLD_QUEST_TRACKER_MODULE.Header
	header.Background:Hide()
	local bg = header:CreateTexture(nil, "ARTWORK")
	bg:SetTexture([[Interface\LFGFrame\UI-LFG-SEPARATOR]])
	bg:SetTexCoord(0, 0.6640625, 0, 0.3125)
	bg:SetVertexColor(r * 0.7, g * 0.7, b * 0.7)
	bg:SetPoint("BOTTOMLEFT", -30, -4)
	bg:SetSize(210, 30)
	if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
		if C.appearance.fontUseChinesePixelFont then
			header.Text:SetFont(unpack(otFont))
		else
			header.Text:SetFont(C.media.font.header, 16, "OUTLINE")
		end
	else
		F.SetFS(header.Text)
	end

	local header_bonus = BONUS_OBJECTIVE_TRACKER_MODULE.Header
	header_bonus.Background:Hide()
	local bg = header_bonus:CreateTexture(nil, "ARTWORK")
	bg:SetTexture([[Interface\LFGFrame\UI-LFG-SEPARATOR]])
	bg:SetTexCoord(0, 0.6640625, 0, 0.3125)
	bg:SetVertexColor(r * 0.7, g * 0.7, b * 0.7)
	bg:SetPoint("BOTTOMLEFT", -30, -4)
	bg:SetSize(210, 30)

	if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
		if C.appearance.fontUseChinesePixelFont then
			header_bonus.Text:SetFont(unpack(otFont))
		else
			header_bonus.Text:SetFont(C.media.font.header, 16, "OUTLINE")
		end
	else
		F.SetFS(header_bonus.Text)
	end
end

hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "SetBlockHeader", function(_, block)
	if not block.headerStyled then
		if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
			if C.appearance.fontUseChinesePixelFont then
				block.HeaderText:SetFont(unpack(otFont))
			else
				block.HeaderText:SetFont(C.media.font.normal, 13, "OUTLINE")
			end
		else
			F.SetFS(block.HeaderText)
		end
		block.headerStyled = true
	end
end)

hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", function(_, block)
	if not block.headerStyled then
		if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
			if C.appearance.fontUseChinesePixelFont then
				block.HeaderText:SetFont(unpack(otFont))
			else
				block.HeaderText:SetFont(C.media.font.normal, 13, "OUTLINE")
			end
		else
			F.SetFS(block.HeaderText)
		end
		block.headerStyled = true
	end

	local itemButton = block.itemButton

	if itemButton and not itemButton.styled then
		itemButton:SetNormalTexture("")
		itemButton:SetPushedTexture("")

		itemButton.HotKey:ClearAllPoints()
		itemButton.HotKey:SetPoint("CENTER", itemButton, 1, 0)
		itemButton.HotKey:SetJustifyH("CENTER")
		F.SetFS(itemButton.HotKey)

		itemButton.Count:ClearAllPoints()
		itemButton.Count:SetPoint("TOP", itemButton, 2, -1)
		itemButton.Count:SetJustifyH("CENTER")
		F.SetFS(itemButton.Count)

		itemButton.icon:SetTexCoord(.08, .92, .08, .92)
		F.CreateBG(itemButton)

		itemButton.styled = true
	end
end)

hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "AddObjective", function(_, block)
	local itemButton = block.itemButton
	if itemButton and not itemButton.styled then
		itemButton:SetNormalTexture("")
		itemButton:SetPushedTexture("")

		itemButton.HotKey:ClearAllPoints()
		itemButton.HotKey:SetPoint("CENTER", itemButton, 1, 0)
		itemButton.HotKey:SetJustifyH("CENTER")
		F.SetFS(itemButton.HotKey)

		itemButton.Count:ClearAllPoints()
		itemButton.Count:SetPoint("TOP", itemButton, 2, -1)
		itemButton.Count:SetJustifyH("CENTER")
		F.SetFS(itemButton.Count)

		itemButton.icon:SetTexCoord(.08, .92, .08, .92)
		F.CreateBG(itemButton)

		itemButton.styled = true
	end

	local line = block.currentLine

	local p1, a, p2, x, y = line:GetPoint()
	line:SetPoint(p1, a, p2, x, y - 4)
end)

hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", function(self, block)
	if block.module == QUEST_TRACKER_MODULE or block.module == ACHIEVEMENT_TRACKER_MODULE then
		local line = block.currentLine

		local p1, a, p2, x, y = line:GetPoint()
		line:SetPoint(p1, a, p2, x, y - 4)
	end
end)

local function fixBlockHeight(block)
	if block.shouldFix then
		local height = block:GetHeight()

		if block.lines then
			for _, line in pairs(block.lines) do
				if line:IsShown() then
					height = height + 4
				end
			end
		end

		block.shouldFix = false
		block:SetHeight(height + 5)
		block.shouldFix = true
	end
end

hooksecurefunc("ObjectiveTracker_AddBlock", function(block)
	if block.lines then
		for _, line in pairs(block.lines) do
			if not line.styled then
				if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
					if C.appearance.fontUseChinesePixelFont then
						line.Text:SetFont(unpack(otFont))
					else
						line.Text:SetFont(C.media.font.normal, 12, "OUTLINE")
					end
				else
					F.SetFS(line.Text)
				end
				line.Text:SetSpacing(2)

				if line.Dash then
					F.SetFS(line.Dash)
				end

				line:SetHeight(line.Text:GetHeight())

				line.styled = true
			end
		end
	end

	if not block.styled then
		block.shouldFix = true
		hooksecurefunc(block, "SetHeight", fixBlockHeight)
		block.styled = true
	end
end)

-- [[ Bonus objective progress bar ]]

hooksecurefunc(BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", function(self, block, line)
	local progressBar = line.ProgressBar
	local bar = progressBar.Bar
	local icon = bar.Icon
	if not progressBar.styled then
		local bg = F.CreateBDFrame(bar)
		bg:SetPoint("TOPLEFT", -1, 1)
		bg:SetPoint("BOTTOMRIGHT", 0, -2)
		F.CreateSD(bg)

		bar.BarBG:Hide()
		bar.BarFrame:Hide()
		bar:SetStatusBarTexture(C.media.backdrop)
		-- bar:SetStatusBarColor(237/255, 82/255, 46/255)
		bar:SetHeight(14)

		icon:SetMask(nil)
		icon:SetSize(24, 24)
		icon:SetDrawLayer("BACKGROUND", 1)
		icon:ClearAllPoints()
		icon:SetPoint("RIGHT", 30, 0)
		bar.newIconBg = F.ReskinIcon(icon)

		bar.Label:ClearAllPoints()
		bar.Label:SetPoint("CENTER")
		F.SetFS(bar.Label)

		progressBar.styled = true
	end

	bar.IconBG:Hide()
	bar.newIconBg:SetShown(icon:IsShown())
end)

-- [[ World quest objective progress bar ]]

hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "AddProgressBar", function(self, block, line)
	local progressBar = line.ProgressBar
	local bar = progressBar.Bar
	local icon = bar.Icon
	if not progressBar.styled then
		local bg = F.CreateBDFrame(bar)
		bg:SetPoint("TOPLEFT", -1, 1)
		bg:SetPoint("BOTTOMRIGHT", 0, -2)
		F.CreateSD(bg)

		bar.BarBG:Hide()
		bar.BarFrame:Hide()
		bar:SetStatusBarTexture(C.media.backdrop)
		bar:SetStatusBarColor(237/255, 82/255, 46/255)
		bar:SetHeight(14)

		icon:SetMask(nil)
		icon:SetSize(24, 24)
		icon:SetDrawLayer("BACKGROUND", 1)
		icon:ClearAllPoints()
		icon:SetPoint("RIGHT", 30, 0)
		bar.newIconBg = F.ReskinIcon(icon)

		bar.Label:ClearAllPoints()
		bar.Label:SetPoint("CENTER")
		F.SetFS(bar.Label)

		progressBar.styled = true
	end

	bar.IconBG:Hide()
	bar.newIconBg:SetShown(icon:IsShown())
end)

-- [[ scenario progress bar ]]

hooksecurefunc(SCENARIO_TRACKER_MODULE, "AddProgressBar", function(self, block, line)
	local progressBar = line.ProgressBar
	local bar = progressBar.Bar
	if not progressBar.styled then
		local bg = F.CreateBDFrame(bar)
		bg:SetPoint("TOPLEFT", -1, 1)
		bg:SetPoint("BOTTOMRIGHT", 0, -2)
		F.CreateSD(bg)

		bar.BarBG:Hide()
		bar.BarFrame:Hide()
		bar:SetStatusBarTexture(C.media.backdrop)
		bar:SetStatusBarColor(207/255, 0/255, 31/255)
		bar:SetHeight(14)

		bar.Label:ClearAllPoints()
		bar.Label:SetPoint("CENTER")
		F.SetFS(bar.Label)

		progressBar.styled = true
	end
end)


-- [[ Header background ]]

for _, headerName in next, {"QuestHeader", "AchievementHeader", "ScenarioHeader"} do
	local header = _G.ObjectiveTrackerFrame.BlocksFrame[headerName]
	header.Background:Hide()

	local bg = header:CreateTexture(nil, "ARTWORK")
	bg:SetTexture([[Interface\LFGFrame\UI-LFG-SEPARATOR]])
	bg:SetTexCoord(0, 0.6640625, 0, 0.3125)
	bg:SetVertexColor(r * 0.7, g * 0.7, b * 0.7)
	bg:SetPoint("BOTTOMLEFT", -30, -4)
	bg:SetSize(210, 30)
end

ScenarioStageBlock:HookScript("OnShow", function()
	if not ScenarioStageBlock.skinned then
		ScenarioStageBlock.NormalBG:SetAlpha(.4)
		ScenarioStageBlock.NormalBG:SetTexture([[Interface\Addons\FreeUI\Media\HalBackgroundA]])
		ScenarioStageBlock.NormalBG:SetVertexColor(0, 0, 0, .4)
		ScenarioStageBlock.FinalBG:SetAlpha(.4)
		ScenarioStageBlock.GlowTexture:SetTexture(nil)
		ScenarioStageBlock.Stage:SetFont(C.media.font.normal, 15, "OUTLINE")
		ScenarioStageBlock.Stage:SetTextColor(1, 1, 1)
		ScenarioStageBlock.Name:SetFont(C.media.font.normal, 12, "OUTLINE")
		ScenarioStageBlock.CompleteLabel:SetFont(C.media.font.normal, 15, "OUTLINE")
		ScenarioStageBlock.CompleteLabel:SetTextColor(1, 1, 1)
		ScenarioStageBlock.skinned = true
	end
end)


-- [[ Init ]]

F.RegisterEvent("VARIABLES_LOADED", function()
	if not FreeUIConfig.objectiveTracker then FreeUIConfig.objectiveTracker = {} end

	if C.quests.rememberObjectiveTrackerState and (FreeUIConfig.objectiveTracker.collapsed or C.quests.alwaysCollapseObjectiveTracker) then
		ObjectiveTracker_Collapse()
	end
end)
