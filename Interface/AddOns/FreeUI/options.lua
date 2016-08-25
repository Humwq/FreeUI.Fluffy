local F, C, L = unpack(select(2, ...))

-- All exceptions and special rules for these options are in profiles.lua!
-- Consider using the in-game options instead, accessed through the game menu or by typing /freeui.

-- [[ Constants ]]
C.media = {
	["arrowUp"]    = "Interface\\AddOns\\FreeUI\\media\\arrow-up-active",
	["arrowDown"]  = "Interface\\AddOns\\FreeUI\\media\\arrow-down-active",
	["arrowLeft"]  = "Interface\\AddOns\\FreeUI\\media\\arrow-left-active",
	["arrowRight"] = "Interface\\AddOns\\FreeUI\\media\\arrow-right-active",
	["backdrop"]   = "Interface\\AddOns\\FreeUI\\media\\blank", 					-- default backdrop
	["checked"]    = "Interface\\AddOns\\FreeUI\\media\\CheckButtonHilight", 		-- replace default checked texture
	["glow"]       = "Interface\\AddOns\\FreeUI\\media\\glowTex", 					-- glow/shadow texture
	["gradient"]   = "Interface\\AddOns\\FreeUI\\media\\gradient",
	["roleIcons"]  = "Interface\\Addons\\FreeUI\\media\\UI-LFG-ICON-ROLES",
	["texture"]    = "Interface\\AddOns\\FreeUI\\media\\Texture1", 					-- statusbar texture

--	["font"]       = "Interface\\AddOns\\FreeUI\\media\\pixel.ttf", 				-- default pixel font
--	["font2"]      = "Fonts\\FRIZQT__.ttf", 										-- default font

	["font"] = {
		["normal"]          = "Fonts\\FRIZQT__.ttf",
		["chat"]            = "Fonts\\FRIZQT__.ttf",
		["unitname"]        = "Fonts\\FRIZQT__.ttf",
		["pixelCN"]         = "Fonts\\FRIZQT__.ttf",
		["pixel"]           = "Interface\\AddOns\\FreeUI\\media\\pixel.ttf",
		["pixel_condensed"] = "Interface\\AddOns\\FreeUI\\media\\pixel_condensed.ttf",
		["header"]          = "Interface\\AddOns\\FreeUI\\media\\ExocetBlizzardMedium.ttf",
		["damage"]          = "Interface\\AddOns\\FreeUI\\media\\PEPSI_pl.ttf",
	},
}

if GetLocale() == "zhCN" then
	C.media.font.normal = "Fonts\\ARKai_T.ttf"		-- 简体中文客户端主字体
	C.media.font.chat = "Fonts\\ARKai_T.ttf"
	C.media.font.pixelCN = "Fonts\\ARKai_T.ttf"
elseif GetLocale() == "zhTW" then
	C.media.font.normal = "Fonts\\blei00d.ttf"		-- 繁体中文客户端主字体
	C.media.font.chat = "Fonts\\blei00d.ttf"
	C.media.font.pixelCN = "Fonts\\blei00d.ttf"
end

--[[ Global config ]]

C["general"] = {
	["interrupt"] = true,			-- announce your interrupts
		["interrupt_sound"] = true,		-- play sound
		["interrupt_party"] = false,	-- enable in 5 mans / scenarios
		["interrupt_bgs"] = false,		-- enable in battlegrounds
		["interrupt_lfg"] = false, 		-- enable in dungeon/raid finder/scenario groups
		["interrupt_outdoors"] = false,	-- enable when not in an instance
	["mailButton"] = true, 			-- adds a button to the mail frame to collect all attachments
	["rareAlert"] = true, 			-- raid warning when a rare mob is spotted (5.4)
		["rareAlert_playSound"] = true, -- play sound
	["threatMeter"] = true,			-- threat bar above the target frame in dps/healer layout
	["uiScaleAuto"] = true,			-- force the correct UI scale
	["undressButton"] = true, 		-- undress button on dressup frame
	["objectivetracker"] = true,	-- restyle objectivetracker
	["cooldownpulse"] = true,
	["ncshadow"] = true,
	["combo"] = false,
}

C["appearance"] = {
	["colourScheme"] = 1,			-- 1 = class coloured, 2 = custom
		["customColour"] = {r = 1, g = 1, b = 1},
	["fontUseAlternativeFont"] = false,
	["fontSizeNormal"] = 8,
	["fontSizeLarge"] = 16,
	["fontOutline"] = true,
	["fontOutlineStyle"] = 2,		-- 1 = normal, 2 = monochrome
	["fontShadow"] = false,

	["colorFont"] = true,
	["colorFontrgb"] = {r = 247/255, g = 225/255, b =171/255},
}

C["automation"] = {
	["autoAccept"] = false,			-- auto accept invites from friends and guildies
	["autoRepair"] = true,			-- automatically repair items
		["autoRepair_guild"] = true,		-- use guild funds for auto repairs
	["autoRoll"] = false, 			-- automatically DE or greed on BoE greens (DE priority)
		["autoRoll_maxLevel"] = false, 		-- only automatically roll on items at max level
	["autoSell"] = true,			-- automatically sell greys
	["autoSetRole"] = true,			-- automatically set role and hide dialog where possible
		["autoSetRole_useSpec"] = true,		-- attempt to set role based on your current spec
		["autoSetRole_verbose"] = false,	-- tells you what happens when setting role
	["hideRaidNames"] = true,
	["autoScreenShot"] = true,
	["saySapped"] = true,
}

C["actionbars"] = {
	["enable"] = true,					-- enable the action bars
	["enableStyle"] = true,
	["bar3Fold"] = false,
	["hotKey"] = true, 				-- show hot keys on buttons
	["macroName"] = true,					-- show macro name on buttons
	["rightbars_mouseover"] = false, -- show right bars on mouseover (show/hide: use blizz option)
	["stancebar_mouseover"] = false,
	["petbar_mouseover"] = false,

	["margin"] = 4,		-- button margin
	["abbs"] = 30,		-- main bar button size
	["abbs_r"] = 24,	-- right bar button size
	["pbbs"] = 24,		-- pet bar button size
	["sbbs"] = 24,		-- stance bar button size

	["mainbar_pos"] = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 24 },		-- mainbar(bar1) position
	["rightbar_pos"] = { a1 = "RIGHT", a2 = "RIGHT", af = "UIParent", x = -6, y = -200 },	-- rightbar(bar4) position
}

C["minimap"] = {
	["scale"] = 1,
	["position"] = { a1 = "TOPRIGHT", a2 = "TOPRIGHT", af = "UIParent", x = -22, y = 0 },
	["size"] = 256,
}

C["bags"] = {
	["style"] = 3,						-- 1 = all-in-one, 2 = restyle default bags, 3 = do nothing

	["size"] = 34,						-- change the size of the bags/bank, default = 37
	["slotsShowAlways"] = true, 		-- always show the bag item slots

	["hideSlots"] = true,				-- hide bag slots if style is 2 or 3
}

C["menubar"] = {
	["enable"] = true,

	["enableButtons"] = true,			-- show buttons for quick access on the menu bar
		["buttons_mouseover"] = true,			-- only on mouseover
}

C["notifications"] = {
	["enable"] = true,

	["playSounds"] = true,
	["animations"] = true,
	["timeShown"] = 5,

	["checkBagsFull"] = true,
	["checkEvents"] = true,
	["checkGuildEvents"] = true,
	["checkMail"] = true,
}

C["tooltip"] = {
	["enable"] = true,		-- enable tooltip and modules
	["cursor"] = false,		-- tooltip at mouse
	["position"] = {"BOTTOMRIGHT", -25, 30},	-- tooltip position
	["ilvlspec"] = false,		-- show gear info and specialization on tooltip
	["sbHeight"] = 2,
	["scale"] = 1,
	["pBar"] = false,
	["fadeOnUnit"] = false,
	["combathide"] = false,
	["combathideALL"] = false,
	["showGRank"] = false,
	["showRealm"] = true,
}

C["quests"] = {
	["questRewardHighlight"] = true,				-- highlights the quest reward with highest vendor price
	["rememberObjectiveTrackerState"] = true,		-- saves objective tracker expanded/collapsed state per character
 		["alwaysCollapseObjectiveTracker"] = false,	-- always collapses objective tracker on login
}

C["unitframes"] = {
	["enable"] = true, 						-- enable the unit frames and their included modules

	["healerClasscolours"] = false,
	["spellRange"] = true,					
	["shadow"] = true,						-- add shadow border around unit frames
	["gradient"] = false,					-- gradient mode
	["rectangleAura"] = false,

	["enableGroup"] = true,					-- enable party/raid frames
		["limitRaidSize"] = false, 					-- show a maximum of 25 players in a raid
		["showRaidFrames"] = true, 					-- show the raid frames
		["partyNameAlways"] = false,				-- show name on party/raid frames in dps/tank layout
	["enableArena"] = false,					-- enable arena/flag carrier frames

	["absorb"] = true, 							-- absorb bar/over absorb glow
	["powerTypeColor"] = false,					-- 玩家框体的能量条染色按照能量类型
	["castbar"] = true,							-- 启用内置施法条
	["castbarSeparate"] = false,				-- 施法条分离
	["pvp"] = true, 							-- show pvp icon on player frame
	["statusIndicator"] = false,					-- show combat/resting status on player frame
		["statusIndicatorCombat"] = true,				-- show combat status (else: only resting)

	["player"] = {"BOTTOM", UIParent, "BOTTOM", 0, 200},						-- player unitframe position
	["target"] = {"LEFT", 'oUF_FreePlayer', "RIGHT", 26, 120},					-- target unitframe position
	["focus"] = {"LEFT", 'oUF_FreePlayer', "RIGHT", 26, -40},					-- focus unitframe position
	["party"] = {"BOTTOMRIGHT", 'oUF_FreePlayer', "TOPLEFT", -110, 50},					-- party unitframe position
	["raid"] = {"BOTTOMRIGHT", 'oUF_FreePlayer', "TOPLEFT", -110, 80},			-- raid unitframe position		
	["boss"] = {a='LEFT', b='oUF_FreeTarget', c="RIGHT", x=10, y=80},			-- boss unitframe position
	["arena"] = {a='LEFT', b='UIParent', c="LEFT", x=20, y=100},				-- arena unitframe position		

	["player_castbar"] = {"CENTER", 'oUF_FreePlayer', "CENTER", 0, -90},		-- player castbar position
	["target_castbar"] = {"CENTER", 'oUF_FreeTarget', "CENTER", 0, 40},		-- target castbar position
	["focus_castbar"] = {"LEFT", 'oUF_FreeFocus', "LEFT", 0, -40},				-- focus castbar position

	["castbarColorInterrupt"] = {241/255, 80/255, 241/255},
	["castbarColorNormal"] = {89/255, 216/255, 237/255},
	["castbarHeight"] = 6,

	["power_height"] = 2,
	["altpower_height"] = 2,

	["player_width"] = 229,
	["player_height"] = 12,
	["target_width"] = 229,
	["target_height"] = 12,
	["targettarget_width"] = 80,
	["targettarget_height"] = 12,
	["focus_width"] = 112,
	["focus_height"] = 12,
	["focustarget_width"] = 112,
	["focustarget_height"] = 12,
	["pet_width"] = 80,
	["pet_height"] = 12,
	["boss_width"] = 160,
	["boss_height"] = 16,
	["arena_width"] = 229,
	["arena_height"] = 12,
	["party_width"] = 86,
	["party_height"] = 32,
	["raid_width"] = 66,
	["raid_height"] = 26,

	["num_player_debuffs"] = 8,
	["num_target_debuffs"] = 16,
	["num_target_buffs"] = 16,
	["num_boss_buffs"] = 5,
	["num_arena_buffs"] = 8,
	["num_focus_debuffs"] = 4,
}

C["classmod"] = {
	["deathknight"] = true, 	-- runes
	["druidMana"] = true, 		-- shapeshift mana bar
	["mage"] = true, 			-- rune of power
	["monk"] = true, 			-- chi, stagger bar
	["paladinHP"] = true, 		-- holy power
	["paladinRF"] = true, 		-- righteous fury
	["warlock"] = true, 		-- spec bar
}

-- lower = smoother = more CPU usage
C["performance"] = {
	["mapcoords"] = .1, 	-- update interval for map coords in seconds (only with map open)
	["nameplates"] = .1, 	-- update interval for nameplates in seconds (always)
	["nameplatesHealth"] = .2, 	-- update interval for nameplate health bar colour (only with name plates shown)
}

-- [[ Filters ]]

-- Debuffs by other players or NPCs you want to show on enemy target

C["debuffFilter"] = {
	-- CC
	[33786]  = true, -- Cyclone
	[605]    = true, -- Dominate Mind (Mind Control)
	[20549]  = true, -- War Stomp
	[107079] = true, -- Quaking Palm
	[129597] = true, -- Arcane Torrent
		[28730]  = true, -- Arcane Torrent
		[25046]  = true, -- Arcane Torrent
		[50613]  = true, -- Arcane Torrent
		[69179]  = true, -- Arcane Torrent
		[155145] = true, -- Arcane Torrent
		[80483]  = true, -- Arcane Torrent
	[155335] = true, -- Touched by Ice
	[5246]   = true, -- Intimidating Shout
	[24394]  = true, -- Intimidation
	[132168] = true, -- Shockwave
	[132169] = true, -- Storm Bolt
	[853]    = true, -- Hammer of Justice
	[10326]  = true, -- Turn Evil
	[20066]  = true, -- Repentance
	[31935]  = true, -- Avengers Shield
	[105421] = true, -- Blinding Light
	[105593] = true, -- Fist of Justice
	[119072] = true, -- Holy Wrath
	[3355]   = true, -- Freezing Trap
	[19386]  = true, -- Wyvern Sting
	[117526] = true, -- Binding Shot
	[408]    = true, -- Kidney Shot
	[1330]   = true, -- Garrote - Silence
	[1776]   = true, -- Gouge
	[1833]   = true, -- Cheap Shot
	[2094]   = true, -- Blind
	[6770]   = true, -- Sap
	[88611]  = true, -- Smoke Bomb
	[8122]   = true, -- Psychic Scream
	[9484]   = true, -- Shackle Undead
	[15487]  = true, -- Silence
	[64044]  = true, -- Psychic Horror
	[87204]  = true, -- Sin and Punishment
	[88625]  = true, -- Holy Word: Chastise
	[47476] = true, -- Strangulate
		[115502] = true, -- Strangulate (Asphyxiate)
	[91797]  = true, -- Monstrous Blow
	[91800]  = true, -- Gnaw
	[108194] = true, -- Asphyxiate
	[115001] = true, -- Remorseless Winter
	[51514]  = true, -- Hex
	[77505]  = true, -- Earthquake
	[118345] = true, -- Pulverize
	[118905] = true, -- Static Charge (Capacitor Totem)
	[118]    = true, -- Polymorph
		[61305]  = true, -- Polymorph Black Cat
		[28272]  = true, -- Polymorph Pig
		[61721]  = true, -- Polymorph Rabbit
		[61780]  = true, -- Polymorph Turkey
		[28271]  = true, -- Polymorph Turtle
	[31661]  = true, -- Dragon's Breath
	[44572]  = true, -- Deep Freeze
	[82691]  = true, -- Ring of Frost
	[102051] = true, -- Frostjaw
	[710]    = true, -- Banish
	[5484]   = true, -- Howl of Terror
	[6358]   = true, -- Seduction
	[6789]   = true, -- Mortal Coil
	[22703]  = true, -- Infernal Awakening
	[30283]  = true, -- Shadowfury
	[31117]  = true, -- Unstable Affliction (Silence)
	[89766]  = true, -- Axe Toss
	[115268] = true, -- Mesmerize
	[118699] = true, -- Fear
		[130616] = true, -- Fear (Glyph of Fear)
	[137143] = true, -- Blood Horror
	[115078] = true, -- Paralysis
	[119381] = true, -- Leg Sweep
	[119392] = true, -- Charging Ox Wave
	[120086] = true, -- Fists of Fury
	[123393] = true, -- Breath of Fire
	[137460] = true, -- Incapacitated
	[99]     = true, -- Incapacitating Roar
	[5211]   = true, -- Mighty Bash
	[22570]  = true, -- Maim
	[81261]  = true, -- Solar Beam
	[114238] = true, -- Fae Silence
	[163505] = true, -- Rake

	-- Roots
	[122]    = true, -- Frost Nova
		[33395] = true, -- Freeze
	[339]    = true, -- Entangling Roots
		[113770] = true, -- Entangling Roots
		[170855] = true, -- Entangling Roots (Nature's Grasp)
	[53148]  = true, -- Charge (Hunter)
	[105771] = true, -- Charge (Warrior)
	[63685]  = true, -- Frozen Power
	[64695]  = true, -- Earthgrab Totem
	[87194]  = true, -- Glyph of Mind Blast
	[96294]  = true, -- Chains of Ice
	[102359] = true, -- Mass Entanglement
	[111340] = true, -- Ice Ward
	[114404] = true, -- Void Tendrils
	[116706] = true, -- Disable
	[135373] = true, -- Entrapment
	[136634] = true, -- Narrow Escape
	[55536]  = true, -- Frostweave Net
	[157997] = true, -- Ice Nova
	[45334]  = true, -- Wild Charge

	--
	[30108]	=	true,  -- Unstable Affliction
	[34914]	=	true,  -- Vampiric Touch
	[102355]	=	true, -- Faerie Swarm
	[770]	=	true,    -- Faerie Fire
	[2944]	=	true,   -- Devouring Plague
	[114866]	=	true, -- Soul Reaper (Blood)
	[130736]	=	true, -- Soul Reaper (Unholy)
	[130735]	=	true, -- Soul Reaper (Frost)
	[114916]	=	true, -- Execution Sentence
}

-- Buffs to show on enemy players

C["dangerousBuffs"] = {
	-- Immunities
	[46924]  = true, -- Bladestorm
	[642]    = true, -- Divine Shield
	[19263]  = true, -- Deterrence
		[148467] = true, -- Deterrence (Glyph of Mirrored Blades)
	[51690]  = true, -- Killing Spree
	[115018] = true, -- Desecrated Ground
	[45438]  = true, -- Ice Block
	[115760] = true, -- Glyph of Ice Block
	[157913] = true, -- Evanesce

	-- Spell Immunities
	[23920]  = true, -- Spell Reflection
		[114028] = true, -- Mass Spell Reflection
	[31821]  = true, -- Devotion Aura
	[31224]  = true, -- Cloak of Shadows
	[159630] = true, -- Shadow Magic
	[8178]   = true, -- Grounding Totem
		[89523]  = true, -- Grounding Totem (Glyph of Grounding Totem)
	[159652] = true, -- Glyph of Spiritwalker's Aegis
	[48707]  = true, -- Anti-Magic Shell
	[104773] = true, -- Unending Resolve
	[159546] = true, -- Glyph of Zen Focus
	[159438] = true, -- Glyph of Enchanted Bark

	-- Defensive Buffs
	[871]    = true, -- Shield Wall
	[108271] = true, -- Astral Shift
	[157128] = true, -- Saved by the Light
	[33206]  = true, -- Pain Suppression
	[116849] = true, -- Life Cocoon
	[47788]  = true, -- Guardian Spirit
	[47585]  = true, -- Dispersion
	[122783] = true, -- Diffuse Magic
	[178858] = true, -- Contender
	[61336]  = true, -- Survival Instincts
	[98007]  = true, -- Spirit Link
	[118038] = true, -- Die by the Sword
	[74001]  = true, -- Combat Readiness
	[30823]  = true, -- Shamanistic Rage
	[114917] = true, -- Stay of Execution
	[114029] = true, -- Safeguard
	[5277]   = true, -- Evasion
	[49039]  = true, -- Lichborne
	[117679] = true, -- Incarnation: Tree of Life
	[137562] = true, -- Nimble Brew
	[102342] = true, -- Ironbark
	[22812]  = true, -- Barkskin
	[110913] = true, -- Dark Bargain
	[122278] = true, -- Dampen Harm
	[53480]  = true, -- Roar of Sacrifice
	[55694]  = true, -- Enraged Regeneration
	[12975]  = true, -- Last Stand
	[1966]   = true, -- Feint
	[6940]   = true, -- Hand of Sacrifice
	[97463]  = true, -- Rallying Cry
	[115176] = true, -- Zen Meditation
	[120954] = true, -- Fortifying Brew
	[118347] = true, -- Reinforce
	[81782]  = true, -- Power Word: Barrier
	[30884]  = true, -- Nature's Guardian
	[155835] = true, -- Bristling Fur
	[62606]  = true, -- Savage Defense
	[1022]   = true, -- Hand of Protection
	[48743]  = true, -- Death Pact
	[31850]  = true, -- Ardent Defender
	[114030] = true, -- Vigilance
	[498]    = true, -- Divine Protection
	[122470] = true, -- Touch of Karma
	[48792]  = true, -- Icebound Fortitude
	[55233]  = true, -- Vampiric Blood
	[114039] = true, -- Hand of Purity
	[86659]  = true, -- Guardian of Ancient Kings
	[108416] = true, -- Sacrificial Pact

	-- Offensive Buffs
	[19574]  = true, -- Bestial Wrath
	[84747]  = true, -- Deep Insight
	[131894] = true, -- A Murder of Crows
	[152151] = true, -- Shadow Reflection
	[31842]  = true, -- Avenging Wrath
	[114916] = true, -- Execution Sentence
	[83853]  = true, -- Combustion
	[51690]  = true, -- Killing Spree
	[79140]  = true, -- Vendetta
	[102560] = true, -- Incarnation: Chosen of Elune
	[102543] = true, -- Incarnation: King of the Jungle
	[123737] = true, -- Heart of the Wild
		[108291] = true, -- Heart of the Wild (Balance)
		[108292] = true, -- Heart of the Wild (Feral)
		[108293] = true, -- Heart of the Wild (Guardian)
		[108294] = true, -- Heart of the Wild (Restoration)
	[124974] = true, -- Nature's Vigil
	[12472]  = true, -- Icy Veins
	[77801]  = true, -- Dark Soul
		[113860] = true, -- Dark Soul (Misery)
		[113861] = true, -- Dark Soul (Knowledge)
		[113858] = true, -- Dark Soul (Instability)
	[16166]  = true, -- Elemental Mastery
	[114049] = true, -- Ascendance
		[114052] = true, -- Ascendance (Restoration)
		[114050] = true, -- Ascendance (Elemental)
		[114051] = true, -- Ascendance (Enhancement)
	[107574] = true, -- Avatar
	[51713]  = true, -- Shadow Dance
	[13750]  = true, -- Adrenaline Rush
	[1719]   = true, -- Recklessness
	[84746]  = true, -- Moderate Insight
	[112071] = true, -- Celestial Alignment
	[106951] = true, -- Berserk
	[12042]  = true, -- Arcane Power
	[51271]  = true, -- Pillar of Frost
	[152279] = true, -- Breath of Sindragosa

	[41425]  = true, -- Hypothermia
	[130736] = true, -- Soul Reaper (Blood)
		[114866] = true, -- Soul Reaper (Unholy)
		[130735] = true, -- Soul Reaper (Frost)
	[12043]  = true, -- Presence of Mind
	[16188]  = true, -- Ancestral Swiftness
	[132158] = true, -- Nature's Swiftness
	[6346]   = true, -- Fear Ward
	[77606]  = true, -- Dark Simulacrum
	[172786] = true, -- Drink
		[167152] = true, -- Refreshment
	[114239] = true, -- Phantasm
	[119032] = true, -- Spectral Guise
	[1044]   = true, -- Hand of Freedom
	[10060]  = true, -- Power Infusion
	[5384]   = true, -- Feign Death
	[108978] = true, -- Alter Time
	[170856] = true, -- Nature's Grasp
	[110959] = true, -- Greater Invisibility
	[18499]  = true, -- Berserker Rage	
	[111397] = true, -- Blood Horror (Buff)
	[114896] = true, -- Windwalk Totem
}

-- Debuffs healers don't want to see on raid frames

C["hideDebuffs"] = {
	[57724] = true, -- Sated
	[57723] = true, -- Exhaustion
	[80354] = true, -- Temporal Displacement
	[41425] = true, -- Hypothermia
	[95809] = true, -- Insanity
	[36032] = true, -- Arcane Blast
	[26013] = true, -- Deserter
	[95223] = true, -- Recently Mass Resurrected
	[97821] = true, -- Void-Touched (death knight resurrect)
	[36893] = true, -- Transporter Malfunction
	[36895] = true, -- Transporter Malfunction
	[36897] = true, -- Transporter Malfunction
	[36899] = true, -- Transporter Malfunction
	[36900] = true, -- Soul Split: Evil!
	[36901] = true, -- Soul Split: Good
	[25163] = true, -- Disgusting Oozeling Aura
	[85178] = true, -- Shrink (Deviate Fish)
	[8064] = true, -- Sleepy (Deviate Fish)
	[8067] = true, -- Party Time! (Deviate Fish)
	[24755] = true, -- Tricked or Treated (Hallow's End)
	[42966] = true, -- Upset Tummy (Hallow's End)
	[89798] = true, -- Master Adventurer Award (Maloriak kill title)
	[6788] = true, -- Weakened Soul
	[92331] = true, -- Blind Spot (Jar of Ancient Remedies)
	[71041] = true, -- Dungeon Deserter
	[26218] = true, -- Mistletoe
	[117870] = true, -- Touch of the Titans
	[173658] = true, -- Delvar Ironfist defeated
	[173659] = true, -- Talonpriest Ishaal defeated
	[173661] = true, -- Vivianne defeated
	[173679] = true, -- Leorajh defeated
	[173649] = true, -- Tormmok defeated
	[173660] = true, -- Aeda Brightdawn defeated
 	[173657] = true, -- Defender Illona defeated
}

if select(2, UnitClass("player")) == "PRIEST" then C.hideDebuffs[6788] = false end

-- Buffs cast by the player that healers want to see on raid frames

C["myBuffs"] = {
	[774] = true, -- Rejuvenation
	[8936] = true, -- Regrowth
	[33763] = true, -- Lifebloom

	[33110] = true, -- Prayer of Mending
	[33076] = true, -- Prayer of Mending
	[41635] = true, -- Prayer of Mending
	[41637] = true, -- Prayer of Mending
	[139] = true, -- Renew
	[17] = true, -- Power Word: Shield

	[61295] = true, -- Riptide
	[974] = true, -- Earth Shield

	[53563] = true, -- Beacon of Light
	[114163] = true, -- Eternal Flame
	[20925] = true, -- Sacred Shield

	[119611] = true, -- Renewing Mist
	[116849] = true, -- Life Cocoon
	[124682] = true, -- Enveloping Mist
	[124081] = true, -- Zen Sphere
}

-- Buffs cast by anyone that healers want to see on raid frames

C["allBuffs"] = {
	[86657] = true, -- Ancient Guardian
	[31850] = true, -- Ardent Defender
	[642] = true, -- Divine Shield
	[110959] = true, -- Greater Invisibility
	[86659] = true, -- Guardian of Ancient Kings
	[47788] = true, -- Guardian Spirit
	[45438] = true, -- Ice Block
	[48792] = true, -- Icebound Fortitude
	[66] = true, -- Invisibility
	[12975] = true, -- Last Stand
	[33206] = true, -- Pain Suppression
	[871] = true, -- Shield Wall
	[61336] = true, -- Survival Instincts
	[122470] = true, -- Touch of Karma

	[1022] = true, -- Hand of Protection
	[1038] = true, -- Hand of Salvation
	[6940] = true, -- Hand of Sacrifice
}
