--[[
LICENSE
	cargBags: An inventory framework addon for World of Warcraft

	Copyright (C) 2010  Constantin "Cargor" Schomburg <xconstruct@gmail.com>

	cargBags is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	cargBags is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with cargBags; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

DESCRIPTION:
	Provides a searchbar for your containers.
	If you specify a frame as arg #2, it will serve as a clickable placeholder to open it

DEPENDENCIES
	mixins/textFilter.lua
]]

local _, ns = ...
local cargBags = ns.cargBags

-- Lua Globals --
local _G = _G
local next = _G.next

local function apply(self, container, text, mode)
	if text == "" or not text then
		container:ApplyToButtons(self.highlightFunction, true)
	else
		container:FilterForFunction(self.highlightFunction, self.currFilters)
	end
end

local function doSearch(self, text)
	if _G.type(text) == "string" then
		self:SetText(text)
	else
		text = self:GetText()
	end

	if self.currFilters then
		self.currFilters:Empty()
	else
		self.currFilters = cargBags.classes.FilterSet:New()
	end

	self.currFilters:SetTextFilter(text, self.textFilters)

	if self.isGlobal then
		for name, container in next, self.parent.implementation.contByName do
			apply(self, container, text)
		end
	else
		apply(self, self.parent, text)
	end

	self.parent.implementation:UpdateAll()
end

local function target_openSearch(target)
	target:Hide()
	target.search:Show()
end

local function target_closeSearch(search)
	search.target:Show()
	search:Hide()
end

local function onEscape(search)
	doSearch(search, "")
	search:ClearFocus()
	if search.OnEscapePressed then search:OnEscapePressed() end
end

local function onEnter(search)
	search:ClearFocus()
	if search.OnEnterPressed then search:OnEnterPressed() end
end

cargBags:RegisterPlugin("SearchBar", function(self, target)
	local search = _G.CreateFrame("EditBox", nil, self)

	if FreeUI then
		local F, C, L = unpack(FreeUI)
		local locale = GetLocale()

		if locale == "zhCN" or locale == "zhTW" then
			if C.appearance.fontUseChinesePixelFont then
				search:SetFont(unpack(C.fontCN.pixel))
			else
				search:SetFont(unpack(C.fontCN.standard))
			end
		else
			F.SetFS(search)
		end
	else
		search:SetFont(unpack(ns.options.fonts.standard))
	end

	self.Search = search

	search.Clear = onEscape
	search.DoSearch = search.doSearch

	search:SetScript("OnTextChanged", doSearch)
	search:SetScript("OnEscapePressed", onEscape)
	search:SetScript("OnEnterPressed", onEnter)

	if target then
		search:SetAutoFocus(true)
		search:SetAllPoints(target)
		search:Hide()

		target.search, search.target = search, target
		target:RegisterForClicks("anyUp")
		target:SetScript("OnClick", target_openSearch)
		search:SetScript("OnEditFocusLost", target_closeSearch)
	end

	return search
end)
