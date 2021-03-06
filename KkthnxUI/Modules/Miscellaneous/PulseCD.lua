local K, C, L, _ = select(2, ...):unpack()
if C.PulseCD.Enable ~= true then return end

local select = select
local pairs = pairs
local unpack = unpack
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS

-- BASED ON DOOM COOLDOWN PULSE(BY WOFFLE OF DARK IRON, EDITOR AFFLI)
local GetTime = GetTime
local fadeInTime, fadeOutTime, maxAlpha, elapsed, runtimer = 0.5, 0.7, 1, 0, 0
local animScale, iconSize, holdTime, threshold = C.PulseCD.AnimationScale, C.PulseCD.Size, C.PulseCD.HoldTime, C.PulseCD.Threshold
local cooldowns, animating, watching = {}, {}, {}
local Movers = K.Movers

local anchor = CreateFrame("Frame", "PulseCDAnchor", UIParent)
anchor:SetSize(C.PulseCD.Size, C.PulseCD.Size)
anchor:SetPoint(unpack(C.Position.PulseCD))
Movers:RegisterFrame(anchor)

local frame = CreateFrame("Frame", "PulseCDFrame", anchor)
frame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
--K.CreateVirtualFrame(frame)
frame:SetPoint("CENTER", anchor, "CENTER")

local icon = frame:CreateTexture(nil, "ARTWORK")
icon:SetTexCoord(unpack(K.TexCoords))
icon:SetPoint("TOPLEFT", frame, "TOPLEFT", K.NoScaleMult * 2, -K.NoScaleMult * 2)
icon:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -K.NoScaleMult * 2, K.NoScaleMult * 2)

-- UTILITY FUNCTIONS
local function tcount(tab)
	local n = 0
	for _ in pairs(tab) do
		n = n + 1
	end
	return n
end

local function GetPetActionIndexByName(name)
	for i = 1, NUM_PET_ACTION_SLOTS, 1 do
		if GetPetActionInfo(i) == name then
			return i
		end
	end
	return nil
end

-- COOLDOWN/ANIMATION
local function OnUpdate(_, update)
	elapsed = elapsed + update
	if elapsed > 0.05 then
		for i, v in pairs(watching) do
			if GetTime() >= v[1] + 0.5 + threshold then
				local start, duration, enabled, texture, isPet
				if v[2] == "spell" then
					name = GetSpellInfo(v[3])
					texture = GetSpellTexture(v[3])
					start, duration, enabled = GetSpellCooldown(v[3])
				elseif v[2] == "item" then
					name = GetItemInfo(i)
					texture = v[3]
					start, duration, enabled = GetItemCooldown(i)
				elseif v[2] == "pet" then
					name, _, texture = GetPetActionInfo(v[3])
					start, duration, enabled = GetPetActionCooldown(v[3])
					isPet = true
				end
				if K.PulseIgnoredSpells[name] then
					watching[i] = nil
				else
					if enabled ~= 0 then
						if duration and duration > threshold and texture then
							cooldowns[i] = {start, duration, texture, isPet}
						end
					end
					if not (enabled == 0 and v[2] == "spell") then
						watching[i] = nil
					end
				end
			end
		end
		for i, v in pairs(cooldowns) do
			local remaining = v[2] - (GetTime() - v[1])
			if remaining <= 0 then
				tinsert(animating, {v[3], v[4]})
				cooldowns[i] = nil
			end
		end

		elapsed = 0
		if #animating == 0 and tcount(watching) == 0 and tcount(cooldowns) == 0 then
			frame:SetScript("OnUpdate", nil)
			return
		end
	end

	if #animating > 0 then
		runtimer = runtimer + update
		if runtimer > (fadeInTime + holdTime + fadeOutTime) then
			tremove(animating, 1)
			runtimer = 0
			icon:SetTexture(nil)
			frame:SetBackdropBorderColor(0, 0, 0, 0)
			frame:SetBackdropColor(0, 0, 0, 0)
		else
			if not icon:GetTexture() then
				icon:SetTexture(animating[1][1])
				if C.PulseCD.Sound == true then
					PlaySoundFile(C.Media.Proc_Sound, "Master")
				end
			end
			local alpha = maxAlpha
			if runtimer < fadeInTime then
				alpha = maxAlpha * (runtimer / fadeInTime)
			elseif runtimer >= fadeInTime + holdTime then
				alpha = maxAlpha - (maxAlpha * ((runtimer - holdTime - fadeInTime) / fadeOutTime))
			end
			frame:SetAlpha(alpha)
			local scale = iconSize + (iconSize * ((animScale - 1) * (runtimer / (fadeInTime + holdTime + fadeOutTime))))
			frame:SetWidth(scale)
			frame:SetHeight(scale)
			frame:SetBackdropBorderColor(0, 0, 0)
			frame:SetBackdropColor(unpack(C.Media.Backdrop_Color))
		end
	end
end

-- EVENT HANDLERS
function frame:ADDON_LOADED(addon)
	for _, v in pairs(K.PulseIgnoredSpells) do
		K.PulseIgnoredSpells[v] = true
	end
	self:UnregisterEvent("ADDON_LOADED")
end
frame:RegisterEvent("ADDON_LOADED")

function frame:UNIT_SPELLCAST_SUCCEEDED(unit, spell, _, _, spellID)
	if unit == "player" then
		watching[spellID] = {GetTime(), "spell", spellID}
		self:SetScript("OnUpdate", OnUpdate)
	end
end
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

function frame:COMBAT_LOG_EVENT_UNFILTERED(...)
	local _, eventType, _, _, _, sourceFlags, _, _, _, _, _, spellID = ...
	if eventType == "SPELL_CAST_SUCCESS" then
		if (bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PET) == COMBATLOG_OBJECT_TYPE_PET and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE) then
			local name = GetSpellInfo(spellID)
			local index = GetPetActionIndexByName(name)
			if index and not select(7, GetPetActionInfo(index)) then
				watching[spellID] = {GetTime(), "pet", index}
			elseif not index and spellID then
				watching[spellID] = {GetTime(), "spell", spellID}
			else
				return
			end
			self:SetScript("OnUpdate", OnUpdate)
		end
	end
end
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

function frame:PLAYER_ENTERING_WORLD()
	local _, instanceType = IsInInstance()
	if instanceType == "arena" then
		self:SetScript("OnUpdate", nil)
		wipe(cooldowns)
		wipe(watching)
	end
end
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

hooksecurefunc("UseAction", function(slot)
	local actionType, itemID = GetActionInfo(slot)
	if actionType == "item" then
		local texture = GetActionTexture(slot)
		watching[itemID] = {GetTime(), "item", texture}
	end
end)

hooksecurefunc("UseInventoryItem", function(slot)
	local itemID = GetInventoryItemID("player", slot)
	if itemID then
		local texture = GetInventoryItemTexture("player", slot)
		watching[itemID] = {GetTime(), "item", texture}
	end
end)

hooksecurefunc("UseContainerItem", function(bag, slot)
	local itemID = GetContainerItemID(bag, slot)
	if itemID then
		local texture = select(10, GetItemInfo(itemID))
		watching[itemID] = {GetTime(), "item", texture}
	end
end)

SlashCmdList.PulseCD = function()
	tinsert(animating, {GetSpellTexture(87214)})
	if C.PulseCD.Sound == true then
		PlaySoundFile(C.Media.Proc_Sound, "Master")
	end
	frame:SetScript("OnUpdate", OnUpdate)
end
SLASH_PulseCD1 = "/pulsecd"