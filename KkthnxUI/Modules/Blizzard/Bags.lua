local K, C, L, _ = select(2, ...):unpack()
if C.Bag.Enable ~= true then return end

-- BASED ON STUFFING(BY HUNGTAR, EDITOR TUKZ)
local BAGS_BACKPACK = {0, 1, 2, 3, 4}
local BAGS_BANK = {-1, 5, 6, 7, 8, 9, 10, 11}
local ST_NORMAL = 1
local ST_FISHBAG = 2
local ST_SPECIAL = 3
local bag_bars = 0
local unusable

if K.Class == "DEATHKNIGHT" then
	unusable = {{LE_ITEM_WEAPON_BOWS, LE_ITEM_WEAPON_GUNS, LE_ITEM_WEAPON_WARGLAIVE, LE_ITEM_WEAPON_STAFF, LE_ITEM_WEAPON_UNARMED, LE_ITEM_WEAPON_DAGGER, LE_ITEM_WEAPON_THROWN, LE_ITEM_WEAPON_CROSSBOW, LE_ITEM_WEAPON_WAND}, {LE_ITEM_ARMOR_SHIELD}} -- weapons, armor, dual wield
elseif K.Class == "DEMONHUNTER" then
	unusable = {{LE_ITEM_WEAPON_AXE2H, LE_ITEM_WEAPON_BOWS, LE_ITEM_WEAPON_GUNS, LE_ITEM_WEAPON_MACE2H, LE_ITEM_WEAPON_POLEARM, LE_ITEM_WEAPON_SWORD2H, LE_ITEM_WEAPON_STAFF, LE_ITEM_WEAPON_THROWN, LE_ITEM_WEAPON_CROSSBOW, LE_ITEM_WEAPON_WAND}, {LE_ITEM_ARMOR_MAIL, LE_ITEM_ARMOR_PLATE, LE_ITEM_ARMOR_SHIELD}}
elseif K.Class == "DRUID" then
	unusable = {{LE_ITEM_WEAPON_AXE1H, LE_ITEM_WEAPON_AXE2H, LE_ITEM_WEAPON_BOWS, LE_ITEM_WEAPON_GUNS, LE_ITEM_WEAPON_SWORD1H, LE_ITEM_WEAPON_SWORD2H, LE_ITEM_WEAPON_WARGLAIVE, LE_ITEM_WEAPON_THROWN, LE_ITEM_WEAPON_CROSSBOW, LE_ITEM_WEAPON_WAND}, {LE_ITEM_ARMOR_MAIL, LE_ITEM_ARMOR_PLATE, LE_ITEM_ARMOR_SHIELD}, true}
elseif K.Class == "HUNTER" then
	unusable = {{LE_ITEM_WEAPON_MACE1H, LE_ITEM_WEAPON_MACE2H, LE_ITEM_WEAPON_WARGLAIVE, LE_ITEM_WEAPON_THROWN, LE_ITEM_WEAPON_WAND}, {LE_ITEM_ARMOR_PLATE, LE_ITEM_ARMOR_SHIELD}}
elseif K.Class == "MAGE" then
	unusable = {{LE_ITEM_WEAPON_AXE1H, LE_ITEM_WEAPON_AXE2H, LE_ITEM_WEAPON_BOWS, LE_ITEM_WEAPON_GUNS, LE_ITEM_WEAPON_MACE1H, LE_ITEM_WEAPON_MACE2H, LE_ITEM_WEAPON_POLEARM, LE_ITEM_WEAPON_SWORD2H, LE_ITEM_WEAPON_WARGLAIVE, LE_ITEM_WEAPON_UNARMED, LE_ITEM_WEAPON_THROWN, LE_ITEM_WEAPON_CROSSBOW}, {LE_ITEM_ARMOR_LEATHER, LE_ITEM_ARMOR_MAIL, LE_ITEM_ARMOR_PLATE, LE_ITEM_ARMOR_SHIELD,}, true}
elseif K.Class == "MONK" then
	unusable = {{LE_ITEM_WEAPON_AXE2H, LE_ITEM_WEAPON_BOWS, LE_ITEM_WEAPON_GUNS, LE_ITEM_WEAPON_MACE2H, LE_ITEM_WEAPON_SWORD2H, LE_ITEM_WEAPON_WARGLAIVE, LE_ITEM_WEAPON_DAGGER, LE_ITEM_WEAPON_THROWN, LE_ITEM_WEAPON_CROSSBOW, LE_ITEM_WEAPON_WAND}, {LE_ITEM_ARMOR_MAIL, LE_ITEM_ARMOR_PLATE, LE_ITEM_ARMOR_SHIELD}}
elseif K.Class == "PALADIN" then
	unusable = {{LE_ITEM_WEAPON_BOWS, LE_ITEM_WEAPON_GUNS, LE_ITEM_WEAPON_WARGLAIVE, LE_ITEM_WEAPON_STAFF, LE_ITEM_WEAPON_UNARMED, LE_ITEM_WEAPON_DAGGER, LE_ITEM_WEAPON_THROWN, LE_ITEM_WEAPON_CROSSBOW, LE_ITEM_WEAPON_WAND}, {}, true}
elseif K.Class == "PRIEST" then
	unusable = {{LE_ITEM_WEAPON_AXE1H, LE_ITEM_WEAPON_AXE2H, LE_ITEM_WEAPON_BOWS, LE_ITEM_WEAPON_GUNS, LE_ITEM_WEAPON_MACE2H, LE_ITEM_WEAPON_POLEARM, LE_ITEM_WEAPON_SWORD1H, LE_ITEM_WEAPON_SWORD2H, LE_ITEM_WEAPON_WARGLAIVE, LE_ITEM_WEAPON_UNARMED, LE_ITEM_WEAPON_THROWN, LE_ITEM_WEAPON_CROSSBOW}, {LE_ITEM_ARMOR_LEATHER, LE_ITEM_ARMOR_MAIL, LE_ITEM_ARMOR_PLATE, LE_ITEM_ARMOR_SHIELD}, true}
elseif K.Class == "ROGUE" then
	unusable = {{LE_ITEM_WEAPON_AXE2H, LE_ITEM_WEAPON_MACE2H, LE_ITEM_WEAPON_POLEARM, LE_ITEM_WEAPON_SWORD2H, LE_ITEM_WEAPON_WARGLAIVE, LE_ITEM_WEAPON_STAFF, LE_ITEM_WEAPON_WAND}, {LE_ITEM_ARMOR_MAIL, LE_ITEM_ARMOR_PLATE, LE_ITEM_ARMOR_SHIELD}}
elseif K.Class == "SHAMAN" then
	unusable = {{LE_ITEM_WEAPON_BOWS, LE_ITEM_WEAPON_GUNS, LE_ITEM_WEAPON_POLEARM, LE_ITEM_WEAPON_SWORD1H, LE_ITEM_WEAPON_SWORD2H, LE_ITEM_WEAPON_WARGLAIVE, LE_ITEM_WEAPON_THROWN, LE_ITEM_WEAPON_CROSSBOW, LE_ITEM_WEAPON_WAND}, {LE_ITEM_ARMOR_PLATEM}}
elseif K.Class == "WARLOCK" then
	unusable = {{LE_ITEM_WEAPON_AXE1H, LE_ITEM_WEAPON_AXE2H, LE_ITEM_WEAPON_BOWS, LE_ITEM_WEAPON_GUNS, LE_ITEM_WEAPON_MACE1H, LE_ITEM_WEAPON_MACE2H, LE_ITEM_WEAPON_POLEARM, LE_ITEM_WEAPON_SWORD2H, LE_ITEM_WEAPON_WARGLAIVE, LE_ITEM_WEAPON_UNARMED, LE_ITEM_WEAPON_THROWN, LE_ITEM_WEAPON_CROSSBOW}, {LE_ITEM_ARMOR_LEATHER, LE_ITEM_ARMOR_MAIL, LE_ITEM_ARMOR_PLATE, LE_ITEM_ARMOR_SHIELD}, true}
elseif K.Class == "WARRIOR" then
	unusable = {{LE_ITEM_WEAPON_WARGLAIVE, LE_ITEM_WEAPON_WAND}, {}}
else
	unusable = {{}, {}}
end

local subs = {}
for k = 0, 20 do
	subs[k + 1] = GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, k)
end

for i, subclass in ipairs(unusable[1]) do
	unusable[subs[subclass+1]] = true
end

subs = {}
for k = 0, 11 do
	subs[k + 1] = GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, k)
end

for i, subclass in ipairs(unusable[2]) do
	unusable[subs[subclass + 1]] = true
end


local function IsClassUnusable(subclass, slot)
	if subclass then
		return slot ~= "" and unusable[subclass] or slot == "INVTYPE_WEAPONOFFHAND" and unusable[3]
	end
end

local function IsItemUnusable(...)
	if ... then
		local subclass, _, slot = select(7, GetItemInfo(...))
		return IsClassUnusable(subclass, slot)
	end
end

Stuffing = CreateFrame("Frame", nil, UIParent)
Stuffing:RegisterEvent("ADDON_LOADED")
Stuffing:RegisterEvent("PLAYER_ENTERING_WORLD")
Stuffing:SetScript("OnEvent", function(this, event, ...)
	if K.IsAddOnEnabled("AdiBags") or K.IsAddOnEnabled("ArkInventory") or K.IsAddOnEnabled("cargBags_Nivaya") or K.IsAddOnEnabled("cargBags") or K.IsAddOnEnabled("Bagnon") or K.IsAddOnEnabled("Combuctor") or K.IsAddOnEnabled("TBag") or K.IsAddOnEnabled("BaudBag") then return end
	Stuffing[event](this, ...)
end)

-- Drop down menu stuff from Postal
local Stuffing_DDMenu = CreateFrame("Frame", "StuffingDropDownMenu")
Stuffing_DDMenu.displayMode = "MENU"
Stuffing_DDMenu.info = {}
Stuffing_DDMenu.HideMenu = function()
	if UIDROPDOWNMENU_OPEN_MENU == Stuffing_DDMenu then
		CloseDropDownMenus()
	end
end

local function Stuffing_OnShow()
	Stuffing:PLAYERBANKSLOTS_CHANGED(29)

	for i = 0, #BAGS_BACKPACK - 1 do
		Stuffing:BAG_UPDATE(i)
	end

	Stuffing:Layout()
	Stuffing:SearchReset()
	PlaySound("igBackPackOpen")
	collectgarbage("collect")
end

local function StuffingBank_OnHide()
	CloseBankFrame()
	if Stuffing.frame:IsShown() then
		Stuffing.frame:Hide()
	end
	PlaySound("igBackPackClose")
end

local function Stuffing_OnHide()
	if Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
		Stuffing.bankFrame:Hide()
	end
	PlaySound("igBackPackClose")
end

local function Stuffing_Open()
	if not Stuffing.frame:IsShown() then
		Stuffing.frame:Show()
	end
end

local function Stuffing_Close()
	Stuffing.frame:Hide()
end

local function Stuffing_Toggle()
	if Stuffing.frame:IsShown() then
		Stuffing.frame:Hide()
	else
		Stuffing.frame:Show()
	end
end

-- Bag slot stuff
local trashButton = {}
local trashBag = {}

local upgrades = {
	["1"] = 8, ["373"] = 4, ["374"] = 8, ["375"] = 4, ["376"] = 4, ["377"] = 4,
	["379"] = 4, ["380"] = 4, ["446"] = 4, ["447"] = 8, ["452"] = 8, ["454"] = 4,
	["455"] = 8, ["457"] = 8, ["459"] = 4, ["460"] = 8, ["461"] = 12, ["462"] = 16,
	["466"] = 4, ["467"] = 8, ["469"] = 4, ["470"] = 8, ["471"] = 12, ["472"] = 16,
	["477"] = 4, ["478"] = 8, ["480"] = 8, ["492"] = 4, ["493"] = 8, ["495"] = 4,
	["496"] = 8, ["497"] = 12, ["498"] = 16, ["504"] = 12, ["505"] = 16, ["506"] = 20,
	["507"] = 24, ["530"] = 5, ["531"] = 10, ["535"] = 15, ["536"] = 30, ["537"] = 45
}

local function BOALevel(level, id)
	if level > 97 then
		if id == 133585 or id == 133595 or id == 133596 or id == 133597 or id == 133598 then
			level = 815 - (110 - level) * 10
		else
			level = 605 - (100 - level) * 5
		end
	elseif level > 90 then
		level = 590 - (97 - level) * 10
	elseif level > 85 then
		level = 463 - (90 - level) * 19.75
	elseif level > 80 then
		level = 333 - (85 - level) * 13.5
	elseif level > 67 then
		level = 187 - (80 - level) * 4
	elseif level > 57 then
		level = 105 - (67 - level) * 2.88
	elseif level > 5 then
		level = level + 5
	else
		level = 10
	end

	return floor(level + 0.5)
end

local timewarped = {
	["615"] = 660, -- Dungeon drops
	["692"] = 675, -- Timewarped badge vendors
	["656"] = 675, -- Warforged Dungeon drops
}

local itemLevelPattern = gsub(ITEM_LEVEL, "%%d", "(%%d+)")
local tooltipLines = {
	"KkthnxUI_ItemScanningTooltipTextLeft2",
	"KkthnxUI_ItemScanningTooltipTextLeft3",
	"KkthnxUI_ItemScanningTooltipTextLeft4"
}
local tooltip = CreateFrame("GameTooltip", "KkthnxUI_ItemScanningTooltip", UIParent, "GameTooltipTemplate")
tooltip:SetOwner(UIParent, "ANCHOR_NONE")

-- Scan tooltip for item level information
local function GetItemLevelFromTooltip(itemLink)
	if not itemLink or not GetItemInfo(itemLink) then
		return
	end

	tooltip:ClearLines()
	tooltip:SetHyperlink(itemLink)

	local text, itemLevel
	for index = 1, #tooltipLines do
		text = _G[tooltipLines[index]]:GetText()

		if text then
			itemLevel = tonumber(string.match(text, itemLevelPattern))
			if itemLevel then
				return itemLevel
			end
		end
	end
end

function Stuffing:SlotUpdate(b)
	local texture, count, locked, quality = GetContainerItemInfo(b.bag, b.slot)
	local clink = GetContainerItemLink(b.bag, b.slot)
	local isQuestItem, questId = GetContainerItemQuestInfo(b.bag, b.slot)

	-- Set all slot color to default KkthnxUI on update
	if not b.frame.lock then
		b.frame:SetBackdropBorderColor(unpack(C.Media.Border_Color))
	end

	if C.Bag.ItemLevel == true then
		b.frame.text:SetText("")
	end

	if b.cooldown and StuffingFrameBags and StuffingFrameBags:IsShown() then
		local start, duration, enable = GetContainerItemCooldown(b.bag, b.slot)
		CooldownFrame_Set(b.cooldown, start, duration, enable)
	end

	if clink then
		b.name, _, _, b.itemlevel, b.level, _, _, _, _, _, _, b.itemClassID = GetItemInfo(clink)

		if C.Bag.ItemLevel == true and b.itemlevel and quality > 1 and (b.itemClassID == 2 or b.itemClassID == 4) then
			if quality == 7 and b.itemlevel == 1 then
				local id = tonumber(strmatch(clink, "item:(%d+)"))
				b.frame.text:SetText(BOALevel(K.Level, id))
			elseif b.itemlevel > 1 then
				local tid = strmatch(clink, ".+:512:22.+:(%d+):100")
				if timewarped[tid] then
					b.itemlevel = timewarped[tid]
				end

				local upgradeTypeID = select(12, strsplit(":", clink))
				if upgradeTypeID and upgradeTypeID ~= "" then
					local uid = clink:match("[-:%d]+:([-%d]+)")
					if upgrades[uid] then
						b.itemlevel = b.itemlevel + upgrades[uid]
					end
				end

				local numBonusIDs = tonumber(strmatch(clink, ".+:%d+:512:%d*:(%d+).+"))
				if numBonusIDs then
					if GetDetailedItemLevelInfo then
						local effectiveLevel, previewLevel, origLevel = GetDetailedItemLevelInfo(clink)
						b.itemlevel = effectiveLevel or b.itemlevel
					end
				end

				if quality == 6 then
					b.itemlevel = GetItemLevelFromTooltip(clink) or b.itemlevel
				end

				b.frame.text:SetText(b.itemlevel)
			end
		end

		if (IsItemUnusable(clink) or b.level and b.level > K.Level) and not locked then
			_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 0.1, 0.1)
		else
			_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 1, 1)
		end

		-- Color slot according to item quality
		if not b.frame.lock and quality and quality > 1 and not (isQuestItem or questId) then
			b.frame:SetBackdropBorderColor(GetItemQualityColor(quality))
		elseif isQuestItem or questId then
			b.frame:SetBackdropBorderColor(1, 1, 0)
		end
	else
		b.name, b.level = nil, nil
	end

	SetItemButtonTexture(b.frame, texture)
	SetItemButtonCount(b.frame, count)
	SetItemButtonDesaturated(b.frame, locked)

	b.frame:Show()
end

function Stuffing:BagSlotUpdate(bag)
	if not self.buttons then
		return
	end

	for _, v in ipairs(self.buttons) do
		if v.bag == bag then
			self:SlotUpdate(v)
		end
	end
end

function CreateReagentContainer()
	ReagentBankFrame:StripTextures()

	local Reagent = CreateFrame("Frame", "StuffingFrameReagent", UIParent)
	local SwitchBankButton = CreateFrame("Button", nil, Reagent)
	local NumButtons = ReagentBankFrame.size
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ReagentBankFrameItem1, 1, ReagentBankFrameItem1
	local Deposit = ReagentBankFrame.DespositButton

	Reagent:SetWidth(((C.Bag.ButtonSize + C.Bag.ButtonSpace) * C.Bag.BankColumns) + 17)
	Reagent:SetPoint("TOPLEFT", _G["StuffingFrameBank"], "TOPLEFT", 0, 0)
	Reagent:SetTemplate("Transparent")
	Reagent:SetFrameStrata(_G["StuffingFrameBank"]:GetFrameStrata())
	Reagent:SetFrameLevel(_G["StuffingFrameBank"]:GetFrameLevel() + 5)
	Reagent:EnableMouse(true)
	Reagent:SetMovable(true)
	Reagent:SetClampedToScreen(true)
	Reagent:SetClampRectInsets(0, 0, 0, -20)
	Reagent:SetScript("OnMouseDown", function(self, button)
		if IsShiftKeyDown() and button == "LeftButton" then
			self:StartMoving()
		end
	end)
	Reagent:SetScript("OnMouseUp", Reagent.StopMovingOrSizing)

	SwitchBankButton:SetSize(80, 20)
	--	SwitchBankButton:SkinButton()
	SwitchBankButton:SetPoint("TOPLEFT", 10, -4)
	SwitchBankButton:FontString("text", C.Media.Font, C.Media.Font_Size, C.Media.Font_Style)
	SwitchBankButton.text:SetPoint("CENTER")
	SwitchBankButton.text:SetText(BANK)
	SwitchBankButton:SetScript("OnClick", function()
		Reagent:Hide()
		_G["StuffingFrameBank"]:Show()
		_G["StuffingFrameBank"]:SetAlpha(1)
		BankFrame_ShowPanel(BANK_PANELS[1].name)
		PlaySound("igBackPackOpen")
	end)

	Deposit:SetParent(Reagent)
	Deposit:ClearAllPoints()
	Deposit:SetSize(170, 20)
	Deposit:SetPoint("TOPLEFT", SwitchBankButton, "TOPRIGHT", 3, 0)
	--Deposit:SkinButton()
	Deposit:FontString("text", C.Media.Font, C.Media.Font_Size, C.Media.Font_Style)
	Deposit.text:SetShadowOffset((K.Mult or 1), -(K.Mult or 1))
	Deposit.text:SetTextColor(1, 1, 1)
	Deposit.text:SetText(REAGENTBANK_DEPOSIT)
	Deposit:SetFontString(Deposit.text)

	-- Close button
	local Close = CreateFrame("Button", "StuffingCloseButtonReagent", Reagent, "UIPanelCloseButton")
	Close:SetSize(32, 32)
	Close:RegisterForClicks("AnyUp")
	Close:SetPoint("TOPRIGHT", -2, -2)
	Close:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			if Stuffing_DDMenu.initialize ~= Stuffing.Menu then
				CloseDropDownMenus()
				Stuffing_DDMenu.initialize = Stuffing.Menu
			end
			ToggleDropDownMenu(nil, nil, Stuffing_DDMenu, self:GetName(), 0, 0)
			return
		else
			StuffingBank_OnHide()
		end
	end)

	local tooltip_hide = function()
		GameTooltip:Hide()
	end

	local tooltip_show = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT", 19, 7)
		GameTooltip:ClearLines()
		GameTooltip:SetText(L_BAG_RIGHT_CLICK_CLOSE)
	end

	Close:HookScript("OnEnter", tooltip_show)
	Close:HookScript("OnLeave", tooltip_hide)

	for i = 1, 98 do
		local button = _G["ReagentBankFrameItem" .. i]
		local icon = _G[button:GetName() .. "IconTexture"]
		local count = _G[button:GetName().."Count"]

		ReagentBankFrame:SetParent(Reagent)
		ReagentBankFrame:ClearAllPoints()
		ReagentBankFrame:SetAllPoints()

		button:StyleButton()
		button:SetTemplate("Default")
		button:SetNormalTexture(nil)
		button.IconBorder:SetAlpha(0)

		button:ClearAllPoints()
		button:SetSize(C.Bag.ButtonSize, C.Bag.ButtonSize)

		local _, _, _, quality = GetContainerItemInfo(-3, i)
		local clink = GetContainerItemLink(-3, i)
		if clink then
			if quality and quality > 1 then
				button:SetBackdropBorderColor(GetItemQualityColor(quality))
			end
		end

		if i == 1 then
			button:SetPoint("TOPLEFT", Reagent, "TOPLEFT", 10, -27)
			LastRowButton = button
			LastButton = button
		elseif NumButtons == C.Bag.BankColumns then
			button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(C.Bag.ButtonSpace + C.Bag.ButtonSize))
			button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(C.Bag.ButtonSpace + C.Bag.ButtonSize))
			LastRowButton = button
			NumRows = NumRows + 1
			NumButtons = 1
		else
			button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (C.Bag.ButtonSpace + C.Bag.ButtonSize), 0)
			button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (C.Bag.ButtonSpace + C.Bag.ButtonSize), 0)
			NumButtons = NumButtons + 1
		end

		icon:SetTexCoord(unpack(K.TexCoords))
		icon:SetPoint("TOPLEFT", 4, -4)
		icon:SetPoint("BOTTOMRIGHT", -4, 4)

		count:SetFont(C.Media.Font, C.Media.Font_Size, C.Media.Font_Style)
		count:SetShadowOffset((K.Mult or 1), -(K.Mult or 1))
		count:SetPoint("BOTTOMRIGHT", -3, 3)

		LastButton = button
	end
	Reagent:SetHeight(((C.Bag.ButtonSize + C.Bag.ButtonSpace) * (NumRows + 1) + 40) - C.Bag.ButtonSpace)

	MoneyFrame_Update(ReagentBankFrame.UnlockInfo.CostMoneyFrame, GetReagentBankCost())
	ReagentBankFrameUnlockInfo:SetAllPoints(Reagent)
	ReagentBankFrameUnlockInfo:SetFrameStrata("FULLSCREEN")
end

function Stuffing:BagFrameSlotNew(p, slot)
	for _, v in ipairs(self.bagframe_buttons) do
		if v.slot == slot then
			return v, false
		end
	end

	local ret = {}

	if slot > 3 then
		ret.slot = slot
		slot = slot - 4
		ret.frame = CreateFrame("CheckButton", "StuffingBBag"..slot.."Slot", p, "BankItemButtonBagTemplate")
		ret.frame:StripTextures()
		ret.frame:SetID(slot)
		table.insert(self.bagframe_buttons, ret)

		BankFrameItemButton_Update(ret.frame)
		BankFrameItemButton_UpdateLocked(ret.frame)

		if not ret.frame.tooltipText then
			ret.frame.tooltipText = ""
		end
	else
		ret.frame = CreateFrame("CheckButton", "StuffingFBag"..slot.."Slot", p, "BagSlotButtonTemplate")

		hooksecurefunc(ret.frame.IconBorder, "SetVertexColor", function(self, r, g, b)
			if r ~= 0.65882 and g ~= 0.65882 and b ~= 0.65882 then
				self:GetParent():SetBackdropBorderColor(r, g, b)
			end
			self:SetTexture("")
		end)

		hooksecurefunc(ret.frame.IconBorder, "Hide", function(self)
			self:GetParent():SetBackdropBorderColor(unpack(C.Media.Border_Color))
		end)

		ret.slot = slot
		table.insert(self.bagframe_buttons, ret)
	end

	ret.frame:SetTemplate("Default")
	ret.frame:StyleButton()
	ret.frame:SetNormalTexture("")
	ret.frame:SetCheckedTexture("")

	ret.icon = _G[ret.frame:GetName().."IconTexture"]
	ret.icon:SetTexCoord(unpack(K.TexCoords))
	ret.icon:SetPoint("TOPLEFT", ret.frame, 4, -4)
	ret.icon:SetPoint("BOTTOMRIGHT", ret.frame, -4, 4)

	return ret
end

function Stuffing:SlotNew(bag, slot)
	for _, v in ipairs(self.buttons) do
		if v.bag == bag and v.slot == slot then
			v.lock = false
			return v, false
		end
	end

	local tpl = "ContainerFrameItemButtonTemplate"

	if bag == -1 then
		tpl = "BankItemButtonGenericTemplate"
	end

	local ret = {}

	if #trashButton > 0 then
		local f = -1
		for i, v in ipairs(trashButton) do
			local b, s = v:GetName():match("(%d+)_(%d+)")

			b = tonumber(b)
			s = tonumber(s)

			if b == bag and s == slot then
				f = i
				break
			else
				v:Hide()
			end
		end

		if f ~= -1 then
			ret.frame = trashButton[f]
			table.remove(trashButton, f)
			ret.frame:Show()
		end
	end

	if not ret.frame then
		ret.frame = CreateFrame("Button", "StuffingBag"..bag.."_"..slot, self.bags[bag], tpl)
		ret.frame:StyleButton()
		ret.frame:SetTemplate("Default")
		ret.frame:SetNormalTexture(nil)

		ret.icon = _G[ret.frame:GetName().."IconTexture"]
		ret.icon:SetTexCoord(unpack(K.TexCoords))
		ret.icon:SetPoint("TOPLEFT", ret.frame, 4, -4)
		ret.icon:SetPoint("BOTTOMRIGHT", ret.frame, -4, 4)

		ret.count = _G[ret.frame:GetName().."Count"]
		ret.count:SetFont(C.Media.Font, C.Media.Font_Size, C.Media.Font_Style)
		ret.count:SetShadowOffset((K.Mult or 1), -(K.Mult or 1))
		ret.count:SetPoint("BOTTOMRIGHT", -3, 3)

		if C.Bag.ItemLevel == true then
			ret.frame:FontString("text", C.Media.Font, C.Media.Font_Size, C.Media.Font_Style)
			ret.frame.text:SetPoint("TOPLEFT", 3, -3)
			ret.frame.text:SetTextColor(1, 1, 0)
		end

		local Battlepay = _G[ret.frame:GetName()].BattlepayItemTexture
		if Battlepay then
			Battlepay:SetAlpha(0)
		end
	end

	ret.bag = bag
	ret.slot = slot
	ret.frame:SetID(slot)

	ret.cooldown = _G[ret.frame:GetName().."Cooldown"]
	ret.cooldown:Show()
	ret.cooldown:SetInside(ret.frame, 4, 4)

	self:SlotUpdate(ret)

	return ret, true
end

-- From OneBag
local BAGTYPE_PROFESSION = 0x0008 + 0x0010 + 0x0020 + 0x0040 + 0x0080 + 0x0200 + 0x0400 + 0x10000
local BAGTYPE_FISHING = 32768

function Stuffing:BagType(bag)
	local bagType = select(2, GetContainerNumFreeSlots(bag))

	if bagType and bit.band(bagType, BAGTYPE_FISHING) > 0 then
		return ST_FISHBAG
	elseif bagType and bit.band(bagType, BAGTYPE_PROFESSION) > 0 then
		return ST_SPECIAL
	end

	return ST_NORMAL
end

function Stuffing:BagNew(bag, f)
	for i, v in pairs(self.bags) do
		if v:GetID() == bag then
			v.bagType = self:BagType(bag)
			return v
		end
	end

	local ret

	if #trashBag > 0 then
		local f = -1
		for i, v in pairs(trashBag) do
			if v:GetID() == bag then
				f = i
				break
			end
		end

		if f ~= -1 then
			ret = trashBag[f]
			table.remove(trashBag, f)
			ret:Show()
			ret.bagType = self:BagType(bag)
			return ret
		end
	end

	ret = CreateFrame("Frame", "StuffingBag"..bag, f)
	ret.bagType = self:BagType(bag)

	ret:SetID(bag)
	return ret
end

function Stuffing:SearchUpdate(str)
	str = string.lower(str)

	for _, b in ipairs(self.buttons) do
		if b.frame and not b.name then
			b.frame:SetAlpha(0.2)
		end
		if b.name then
			local _, setName = GetContainerItemEquipmentSetInfo(b.bag, b.slot)
			setName = setName or ""
			local ilink = GetContainerItemLink(b.bag, b.slot)
			local class, subclass, _, equipSlot = select(6, GetItemInfo(ilink))
			local minLevel = select(5, GetItemInfo(ilink))
			equipSlot = _G[equipSlot] or ""
			if not string.find(string.lower(b.name), str) and not string.find(string.lower(setName), str) and not string.find(string.lower(class), str) and not string.find(string.lower(subclass), str) and not string.find(string.lower(equipSlot), str) then
				if IsItemUnusable(b.name) or minLevel > K.Level then
					_G[b.frame:GetName().."IconTexture"]:SetVertexColor(0.5, 0.5, 0.5)
				end
				SetItemButtonDesaturated(b.frame, true)
				b.frame:SetAlpha(0.2)
			else
				if IsItemUnusable(b.name) or minLevel > K.Level then
					_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 0.1, 0.1)
				end
				SetItemButtonDesaturated(b.frame, false)
				b.frame:SetAlpha(1)
			end
		end
	end
end

function Stuffing:SearchReset()
	for _, b in ipairs(self.buttons) do
		if IsItemUnusable(b.name) or (b.level and b.level > K.Level) then
			_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 0.1, 0.1)
		end
		b.frame:SetAlpha(1)
		SetItemButtonDesaturated(b.frame, false)
	end
end

local function DragFunction(self, mode)
	for index = 1, select("#", self:GetChildren()) do
		local frame = select(index, self:GetChildren())
		if frame:GetName() and frame:GetName():match("StuffingBag") then
			if mode then
				frame:Hide()
			else
				frame:Show()
			end
		end
	end
end

function Stuffing:CreateBagFrame(w)
	local n = "StuffingFrame"..w
	local f = CreateFrame("Frame", n, UIParent)
	f:EnableMouse(true)
	f:SetMovable(true)
	f:SetFrameStrata("MEDIUM")
	f:SetFrameLevel(5)
	f:RegisterForDrag("LeftButton")
	f:SetScript("OnDragStart", function(self)
		if IsShiftKeyDown() then
			self:StartMoving()
			DragFunction(self, true)
		end
	end)
	f:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		DragFunction(self, false)
	end)

	if w == "Bank" then
		f:SetPoint(unpack(C.Position.Bank))
	else
		f:SetPoint(unpack(C.Position.Bag))
	end

	if w == "Bank" then
		-- Reagent button
		f.b_reagent = CreateFrame("Button", "StuffingReagentButton"..w, f)
		f.b_reagent:SetSize(105, 20)
		f.b_reagent:SetPoint("TOPLEFT", 10, -4)
		f.b_reagent:RegisterForClicks("AnyUp")
		--		f.b_reagent:SkinButton()
		f.b_reagent:SetScript("OnClick", function()
			BankFrame_ShowPanel(BANK_PANELS[2].name)
			PlaySound("igBackPackOpen")
			if not ReagentBankFrame.isMade then
				CreateReagentContainer()
				ReagentBankFrame.isMade = true
			else
				_G["StuffingFrameReagent"]:Show()
			end
			_G["StuffingFrameBank"]:SetAlpha(0)
		end)
		f.b_reagent:FontString("text", C.Media.Font, C.Media.Font_Size, C.Media.Font_Style)
		f.b_reagent.text:SetPoint("CENTER")
		f.b_reagent.text:SetText(REAGENT_BANK)
		f.b_reagent:SetFontString(f.b_reagent.text)

		-- Buy button
		f.b_purchase = CreateFrame("Button", "StuffingPurchaseButton"..w, f)
		f.b_purchase:SetSize(80, 20)
		f.b_purchase:SetPoint("TOPLEFT", f.b_reagent, "TOPRIGHT", 3, 0)
		f.b_purchase:RegisterForClicks("AnyUp")
		--f.b_purchase:SkinButton()
		f.b_purchase:SetScript("OnClick", function(self) StaticPopup_Show("CONFIRM_BUY_BANK_SLOT") end)
		f.b_purchase:FontString("text", C.Media.Font, C.Media.Font_Size, C.Media.Font_Style)
		f.b_purchase.text:SetPoint("CENTER")
		f.b_purchase.text:SetText(BANKSLOTPURCHASE)
		f.b_purchase:SetFontString(f.b_purchase.text)
		local _, full = GetNumBankSlots()
		if full then
			f.b_purchase:Hide()
		else
			f.b_purchase:Show()
		end
	end

	-- Close button
	f.b_close = CreateFrame("Button", "StuffingCloseButton"..w, f, "UIPanelCloseButton")
	f.b_close:SetSize(32, 32)
	f.b_close:RegisterForClicks("AnyUp")
	f.b_close:SetPoint("TOPRIGHT", -2, -2)
	f.b_close:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			if Stuffing_DDMenu.initialize ~= Stuffing.Menu then
				CloseDropDownMenus()
				Stuffing_DDMenu.initialize = Stuffing.Menu
			end
			ToggleDropDownMenu(nil, nil, Stuffing_DDMenu, self:GetName(), 0, 0)
			return
		end
		self:GetParent():Hide()
	end)

	local tooltip_hide = function()
		GameTooltip:Hide()
	end

	local tooltip_show = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT", 19, 7)
		GameTooltip:ClearLines()
		GameTooltip:SetText(L_BAG_RIGHT_CLICK_CLOSE)
	end

	f.b_close:HookScript("OnEnter", tooltip_show)
	f.b_close:HookScript("OnLeave", tooltip_hide)

	-- Create the bags frame
	local fb = CreateFrame("Frame", n.."BagsFrame", f)
	fb:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, 3)
	fb:SetFrameStrata("MEDIUM")
	f.bags_frame = fb

	return f
end

function Stuffing:InitBank()
	if self.bankFrame then
		return
	end

	local f = self:CreateBagFrame("Bank")
	f:SetScript("OnHide", StuffingBank_OnHide)
	self.bankFrame = f
end

function Stuffing:InitBags()
	if self.frame then return end

	self.buttons = {}
	self.bags = {}
	self.bagframe_buttons = {}

	local f = self:CreateBagFrame("Bags")
	f:SetScript("OnShow", Stuffing_OnShow)
	f:SetScript("OnHide", Stuffing_OnHide)

	-- Search editbox (tekKonfigAboutPanel.lua)
	local editbox = CreateFrame("EditBox", nil, f)
	editbox:Hide()
	editbox:SetAutoFocus(true)
	editbox:SetHeight(32)
	editbox:CreateBackdrop("Default")
	editbox.backdrop:SetPoint("TOPLEFT", -4, 4)
	editbox.backdrop:SetPoint("BOTTOMRIGHT", 4, -4)

	local resetAndClear = function(self)
		self:GetParent().detail:Show()
		self:GetParent().gold:Show()
		self:ClearFocus()
		Stuffing:SearchReset()
	end

	local updateSearch = function(self, t)
		if t == true then
			Stuffing:SearchUpdate(self:GetText())
		end
	end

	editbox:SetScript("OnEscapePressed", resetAndClear)
	editbox:SetScript("OnEnterPressed", resetAndClear)
	editbox:SetScript("OnEditFocusLost", editbox.Hide)
	editbox:SetScript("OnEditFocusGained", editbox.HighlightText)
	editbox:SetScript("OnTextChanged", updateSearch)
	editbox:SetText(SEARCH)

	local detail = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
	detail:SetPoint("TOPLEFT", f, 11, -10)
	detail:SetPoint("RIGHT", f, -140, -10)
	detail:SetHeight(13)
	detail:SetShadowColor(0, 0, 0, 0)
	detail:SetJustifyH("LEFT")
	detail:SetText("|cff9999ff"..SEARCH.."|r")
	editbox:SetAllPoints(detail)

	local gold = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
	gold:SetJustifyH("RIGHT")
	gold:SetPoint("RIGHT", f.b_close, "LEFT", -10, 0)

	f:SetScript("OnEvent", function(self)
		self.gold:SetText(K.FormatMoney(GetMoney()))
	end)
	f:RegisterEvent("PLAYER_MONEY")
	f:RegisterEvent("PLAYER_LOGIN")
	f:RegisterEvent("PLAYER_TRADE_MONEY")
	f:RegisterEvent("TRADE_MONEY_CHANGED")

	local button = CreateFrame("Button", nil, f)
	button:EnableMouse(true)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:SetAllPoints(detail)
	button:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			self:GetParent().detail:Hide()
			self:GetParent().gold:Hide()
			self:GetParent().editbox:Show()
			self:GetParent().editbox:HighlightText()
		else
			if self:GetParent().editbox:IsShown() then
				self:GetParent().editbox:Hide()
				self:GetParent().editbox:ClearFocus()
				self:GetParent().detail:Show()
				self:GetParent().gold:Show()
				Stuffing:SearchReset()
			end
		end
	end)

	local tooltip_hide = function()
		GameTooltip:Hide()
	end

	local tooltip_show = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -12, 11)
		GameTooltip:ClearLines()
		GameTooltip:SetText(L_BAG_RIGHT_CLICK_SEARCH)
	end

	button:SetScript("OnEnter", tooltip_show)
	button:SetScript("OnLeave", tooltip_hide)

	f.editbox = editbox
	f.detail = detail
	f.button = button
	f.gold = gold
	self.frame = f
	f:Hide()
end

function Stuffing:Layout(isBank)
	local slots = 0
	local rows = 0
	local off = 20
	local cols, f, bs

	if isBank then
		bs = BAGS_BANK
		cols = C.Bag.BankColumns
		f = self.bankFrame
		f:SetAlpha(1)
	else
		bs = BAGS_BACKPACK
		cols = C.Bag.BagColumns
		f = self.frame

		f.gold:SetText(K.FormatMoney(GetMoney(), C.Media.Font_Size))
		f.editbox:SetFont(C.Media.Font, C.Media.Font_Size + 3)
		f.detail:SetFont(C.Media.Font, C.Media.Font_Size, C.Media.Font_Style)
		f.detail:SetShadowOffset((K.Mult or 1), -(K.Mult or 1))
		f.gold:SetFont(C.Media.Font, C.Media.Font_Size, C.Media.Font_Style)
		f.gold:SetShadowOffset(0, 0)

		f.detail:ClearAllPoints()
		f.detail:SetPoint("TOPLEFT", f, 12, -8)
		f.detail:SetPoint("RIGHT", f, -140, 0)
	end

	f:SetClampedToScreen(1)
	f:SetTemplate("Transparent")

	-- Bag frame stuff
	local fb = f.bags_frame
	if bag_bars == 1 then
		fb:SetClampedToScreen(1)
		fb:SetTemplate("Transparent")

		local bsize = C.Bag.ButtonSize

		local w = 2 * 10
		w = w + ((#bs - 1) * bsize)
		w = w + ((#bs - 2) * 4)

		fb:SetHeight(2 * 10 + bsize)
		fb:SetWidth(w)
		fb:Show()
	else
		fb:Hide()
	end

	local idx = 0
	for _, v in ipairs(bs) do
		if (not isBank and v <= 3 ) or (isBank and v ~= -1) then
			local bsize = C.Bag.ButtonSize
			local b = self:BagFrameSlotNew(fb, v)
			local xoff = 10

			xoff = xoff + (idx * bsize)
			xoff = xoff + (idx * 4)

			b.frame:ClearAllPoints()
			b.frame:SetPoint("LEFT", fb, "LEFT", xoff, 0)
			b.frame:SetSize(bsize, bsize)

			local btns = self.buttons
			b.frame:HookScript("OnEnter", function(self)
				local bag
				if isBank then bag = v else bag = v + 1 end

				for ind, val in ipairs(btns) do
					if val.bag == bag then
						val.frame:SetAlpha(1)
					else
						val.frame:SetAlpha(0.2)
					end
				end
			end)

			b.frame:HookScript("OnLeave", function(self)
				for _, btn in ipairs(btns) do
					btn.frame:SetAlpha(1)
				end
			end)

			b.frame:SetScript("OnClick", nil)

			idx = idx + 1
		end
	end

	for _, i in ipairs(bs) do
		local x = GetContainerNumSlots(i)
		if x > 0 then
			if not self.bags[i] then
				self.bags[i] = self:BagNew(i, f)
			end

			slots = slots + GetContainerNumSlots(i)
		end
	end

	rows = floor(slots / cols)
	if (slots % cols) ~= 0 then
		rows = rows + 1
	end

	f:SetWidth(cols * C.Bag.ButtonSize + (cols - 1) * C.Bag.ButtonSpace + 10 * 2)
	f:SetHeight(rows * C.Bag.ButtonSize + (rows - 1) * C.Bag.ButtonSpace + off + 10 * 2)

	local idx = 0
	for _, i in ipairs(bs) do
		local bag_cnt = GetContainerNumSlots(i)
		local specialType = select(2, GetContainerNumFreeSlots(i))
		if bag_cnt > 0 then
			self.bags[i] = self:BagNew(i, f)
			local bagType = self.bags[i].bagType

			self.bags[i]:Show()
			for j = 1, bag_cnt do
				local b, isnew = self:SlotNew(i, j)
				local xoff
				local yoff
				local x = (idx % cols)
				local y = floor(idx / cols)

				if isnew then
					table.insert(self.buttons, idx + 1, b)
				end

				xoff = 10 + (x * C.Bag.ButtonSize) + (x * C.Bag.ButtonSpace)
				yoff = off + 10 + (y * C.Bag.ButtonSize) + ((y - 1) * C.Bag.ButtonSpace)
				yoff = yoff * -1

				b.frame:ClearAllPoints()
				b.frame:SetPoint("TOPLEFT", f, "TOPLEFT", xoff, yoff)
				b.frame:SetSize(C.Bag.ButtonSize, C.Bag.ButtonSize)
				b.frame.lock = false
				b.frame:SetAlpha(1)

				if bagType == ST_FISHBAG then
					b.frame:SetBackdropBorderColor(1, 0, 0)	-- Tackle
					b.frame.lock = true
				elseif bagType == ST_SPECIAL then
					if specialType == 0x0008 then			-- Leatherworking
						b.frame:SetBackdropBorderColor(0.8, 0.7, 0.3)
					elseif specialType == 0x0010 then		-- Inscription
						b.frame:SetBackdropBorderColor(0.3, 0.3, 0.8)
					elseif specialType == 0x0020 then		-- Herbs
						b.frame:SetBackdropBorderColor(0.3, 0.7, 0.3)
					elseif specialType == 0x0040 then		-- Enchanting
						b.frame:SetBackdropBorderColor(0.6, 0, 0.6)
					elseif specialType == 0x0080 then		-- Engineering
						b.frame:SetBackdropBorderColor(0.9, 0.4, 0.1)
					elseif specialType == 0x0200 then		-- Gems
						b.frame:SetBackdropBorderColor(0, 0.7, 0.8)
					elseif specialType == 0x0400 then		-- Mining
						b.frame:SetBackdropBorderColor(0.4, 0.3, 0.1)
					elseif specialType == 0x10000 then		-- Cooking
						b.frame:SetBackdropBorderColor(0.9, 0, 0.1)
					end
					b.frame.lock = true
				end

				idx = idx + 1
			end
		end
	end
end

function Stuffing:SetBagsForSorting(c)
	Stuffing_Open()

	self.sortBags = {}

	local cmd = ((c == nil or c == "") and {"d"} or {strsplit("/", c)})

	for _, s in ipairs(cmd) do
		if s == "c" then
			self.sortBags = {}
		elseif s == "d" then
			if not self.bankFrame or not self.bankFrame:IsShown() then
				for _, i in ipairs(BAGS_BACKPACK) do
					if self.bags[i] and self.bags[i].bagType == ST_NORMAL then
						table.insert(self.sortBags, i)
					end
				end
			elseif not _G["StuffingFrameReagent"] or not _G["StuffingFrameReagent"]:IsShown() then
				for _, i in ipairs(BAGS_BANK) do
					if self.bags[i] and self.bags[i].bagType == ST_NORMAL then
						table.insert(self.sortBags, i)
					end
				end
			end
		elseif s == "p" then
			if not self.bankFrame or not self.bankFrame:IsShown() then
				for _, i in ipairs(BAGS_BACKPACK) do
					if self.bags[i] and self.bags[i].bagType == ST_SPECIAL then
						table.insert(self.sortBags, i)
					end
				end
			else
				for _, i in ipairs(BAGS_BANK) do
					if self.bags[i] and self.bags[i].bagType == ST_SPECIAL then
						table.insert(self.sortBags, i)
					end
				end
			end
		else
			table.insert(self.sortBags, tonumber(s))
		end
	end
end

function Stuffing:ADDON_LOADED(addon)
	if addon ~= "KkthnxUI" then return nil end

	-- Register Events for Updates
	self:RegisterEvent("BAG_UPDATE")
	--self:RegisterEvent("ITEM_LOCK_CHANGED")
	--self:RegisterEvent("BANKFRAME_OPENED")
	--self:RegisterEvent("BANKFRAME_CLOSED")
	--self:RegisterEvent("GUILDBANKFRAME_OPENED")
	--self:RegisterEvent("GUILDBANKFRAME_CLOSED")
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	--self:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
	self:RegisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
	self:RegisterEvent("BAG_CLOSED")
	--self:RegisterEvent("BAG_UPDATE_COOLDOWN")

	self:InitBags()

	tinsert(UISpecialFrames, "StuffingFrameBags")
	tinsert(UISpecialFrames, "StuffingFrameReagent")

	ToggleBackpack = Stuffing_Toggle
	ToggleBag = Stuffing_Toggle
	ToggleAllBags = Stuffing_Toggle
	OpenAllBags = Stuffing_Open
	OpenBackpack = Stuffing_Open
	CloseAllBags = Stuffing_Close
	CloseBackpack = Stuffing_Close

	--BankFrame:UnregisterAllEvents()
	BankFrame:SetScale(0.00001)
	BankFrame:SetAlpha(0)
	BankFrame:SetPoint("TOPLEFT")
end

function Stuffing:PLAYER_ENTERING_WORLD()
	Stuffing:UnregisterEvent("PLAYER_ENTERING_WORLD")
	ToggleAllBags()
	ToggleAllBags()
end

function Stuffing:PLAYERBANKSLOTS_CHANGED(id)
	if id > 28 then
		for _, v in ipairs(self.bagframe_buttons) do
			if v.frame and v.frame.GetInventorySlot then

				BankFrameItemButton_Update(v.frame)
				BankFrameItemButton_UpdateLocked(v.frame)

				if not v.frame.tooltipText then
					v.frame.tooltipText = ""
				end
			end
		end
	end

	if self.bankFrame and self.bankFrame:IsShown() then
		self:BagSlotUpdate(-1)
	end
end

function Stuffing:PLAYERREAGENTBANKSLOTS_CHANGED()
	for i = 1, 98 do
		local button = _G["ReagentBankFrameItem" .. i]
		if not button then return end
		local _, _, _, quality = GetContainerItemInfo(-3, i)
		local clink = GetContainerItemLink(-3, i)
		button:SetBackdropBorderColor(unpack(C.Media.Border_Color))

		if clink then
			if quality and quality > 1 then
				button:SetBackdropBorderColor(GetItemQualityColor(quality))
			end
		end
	end
end

function Stuffing:BAG_UPDATE(id)
	self:BagSlotUpdate(id)
end

function Stuffing:ITEM_LOCK_CHANGED(bag, slot)
	if slot == nil then return end
	for _, v in ipairs(self.buttons) do
		if v.bag == bag and v.slot == slot then
			self:SlotUpdate(v)
			break
		end
	end
end

function Stuffing:BANKFRAME_OPENED()
	if not self.bankFrame then
		self:InitBank()
	end

	self:Layout(true)
	for _, x in ipairs(BAGS_BANK) do
		self:BagSlotUpdate(x)
	end

	self.bankFrame:Show()
	Stuffing_Open()
end

function Stuffing:BANKFRAME_CLOSED()
	if StuffingFrameReagent then
		StuffingFrameReagent:Hide()
	end
	if self.bankFrame then
		self.bankFrame:Hide()
	end
end

function Stuffing:GUILDBANKFRAME_OPENED()
	Stuffing_Open()
end

function Stuffing:GUILDBANKFRAME_CLOSED()
	Stuffing_Close()
end

function Stuffing:BAG_CLOSED(id)
	local b = self.bags[id]
	if b then
		table.remove(self.bags, id)
		b:Hide()
		table.insert(trashBag, #trashBag + 1, b)
	end

	while true do
		local changed = false

		for i, v in ipairs(self.buttons) do
			if v.bag == id then
				v.frame:Hide()
				v.frame.lock = false

				table.insert(trashButton, #trashButton + 1, v.frame)
				table.remove(self.buttons, i)

				v = nil
				changed = true
			end
		end

		if not changed then
			break
		end
	end
end

function Stuffing:BAG_UPDATE_COOLDOWN()
	for i, v in pairs(self.buttons) do
		self:SlotUpdate(v)
	end
end

local function InBags(x)
	if not Stuffing.bags[x] then
		return false
	end

	for _, v in ipairs(Stuffing.sortBags) do
		if x == v then
			return true
		end
	end
	return false
end

local BS_bagGroups
local BS_itemSwapGrid

local function BS_clearData()
	BS_itemSwapGrid = {}
	BS_bagGroups = {}
end

function Stuffing:SortOnUpdate(elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed

	if self.elapsed < 0.05 then
		return
	end

	self.elapsed = 0

	local changed = false
	local blocked = false

	for bagIndex in pairs(BS_itemSwapGrid) do
		for slotIndex in pairs(BS_itemSwapGrid[bagIndex]) do
			local destinationBag = BS_itemSwapGrid[bagIndex][slotIndex].destinationBag
			local destinationSlot = BS_itemSwapGrid[bagIndex][slotIndex].destinationSlot

			local _, _, locked1 = GetContainerItemInfo(bagIndex, slotIndex)
			local _, _, locked2 = GetContainerItemInfo(destinationBag, destinationSlot)

			if locked1 or locked2 then
				blocked = true
			elseif bagIndex ~= destinationBag or slotIndex ~= destinationSlot then
				PickupContainerItem(bagIndex, slotIndex)
				PickupContainerItem(destinationBag, destinationSlot)

				local tempItem = BS_itemSwapGrid[destinationBag][destinationSlot]
				BS_itemSwapGrid[destinationBag][destinationSlot] = BS_itemSwapGrid[bagIndex][slotIndex]
				BS_itemSwapGrid[bagIndex][slotIndex] = tempItem

				changed = true
				return
			end
		end
	end

	if not changed and not blocked then
		self:SetScript("OnUpdate", nil)
		BS_clearData()
	end
end

function Stuffing:SortBags()
	BS_clearData()

	local bagList
	if _G["StuffingFrameReagent"] and _G["StuffingFrameReagent"]:IsShown() then
		bagList = {-3}
	elseif Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
		bagList = {11, 10, 9, 8, 7, 6, 5, -1}
	else
		bagList = {4, 3, 2, 1, 0}
	end

	for _, slotNum in pairs(bagList) do
		if GetContainerNumSlots(slotNum) > 0 then
			BS_itemSwapGrid[slotNum] = {}
			local family = select(2, GetContainerNumFreeSlots(slotNum))
			if family then
				if family == 0 then family = "Default" end
				if not BS_bagGroups[family] then
					BS_bagGroups[family] = {}
					BS_bagGroups[family].bagSlotNumbers = {}
				end
				table.insert(BS_bagGroups[family].bagSlotNumbers, slotNum)
			end
		end
	end

	for _, group in pairs(BS_bagGroups) do
		group.itemList = {}
		for _, bagSlot in pairs(group.bagSlotNumbers) do
			for itemSlot = 1, GetContainerNumSlots(bagSlot) do

				local itemLink = GetContainerItemLink(bagSlot, itemSlot)
				if itemLink ~= nil then

					local newItem = {}

					local n, _, q, iL, rL, c1, c2, _, Sl = GetItemInfo(itemLink)
					if n == GetItemInfo(6948) then c1 = "1" end	-- Hearthstone
					if n == GetItemInfo(110560) then c1 = "12" end	-- Garrison Hearthstone
					if n == GetItemInfo(64488) then c1 = "1" end	-- The Innkeeper's Daughter
					-- Fix for battle pets
					if not n then
						n = itemLink
						q = select(4, GetContainerItemInfo(bagSlot, itemSlot))
						iL = 1
						rL = 1
						c1 = "Pet"
						c2 = "Pet"
						Sl = ""
					end

					newItem.sort = q..c1..c2..rL..n..iL..Sl

					tinsert(group.itemList, newItem)

					BS_itemSwapGrid[bagSlot][itemSlot] = newItem
					newItem.startBag = bagSlot
					newItem.startSlot = itemSlot
				end
			end
		end

		table.sort(group.itemList, function(a, b)
			return a.sort > b.sort
		end)

		for index, item in pairs(group.itemList) do
			local gridSlot = index
			for _, bagSlotNumber in pairs(group.bagSlotNumbers) do
				if gridSlot <= GetContainerNumSlots(bagSlotNumber) then
					BS_itemSwapGrid[item.startBag][item.startSlot].destinationBag = bagSlotNumber
					BS_itemSwapGrid[item.startBag][item.startSlot].destinationSlot = GetContainerNumSlots(bagSlotNumber) - gridSlot + 1
					break
				else
					gridSlot = gridSlot - GetContainerNumSlots(bagSlotNumber)
				end
			end
		end
	end

	self:SetScript("OnUpdate", Stuffing.SortOnUpdate)
end

function Stuffing:RestackOnUpdate(e)
	if not self.elapsed then
		self.elapsed = 0
	end

	self.elapsed = self.elapsed + e

	if self.elapsed < 0.1 then return end

	self.elapsed = 0
	self:Restack()
end

function Stuffing:Restack()
	local st = {}

	Stuffing_Open()

	for i, v in pairs(self.buttons) do
		if InBags(v.bag) then
			local _, cnt, _, _, _, _, clink = GetContainerItemInfo(v.bag, v.slot)
			if clink then
				local n, _, _, _, _, _, _, s = GetItemInfo(clink)

				if n and cnt ~= s then
					if not st[n] then
						st[n] = {{item = v, size = cnt, max = s}}
					else
						table.insert(st[n], {item = v, size = cnt, max = s})
					end
				end
			end
		end
	end

	local did_restack = false

	for i, v in pairs(st) do
		if #v > 1 then
			for j = 2, #v, 2 do
				local a, b = v[j - 1], v[j]
				local _, _, l1 = GetContainerItemInfo(a.item.bag, a.item.slot)
				local _, _, l2 = GetContainerItemInfo(b.item.bag, b.item.slot)

				if l1 or l2 then
					did_restack = true
				else
					PickupContainerItem(a.item.bag, a.item.slot)
					PickupContainerItem(b.item.bag, b.item.slot)
					did_restack = true
				end
			end
		end
	end

	if did_restack then
		self:SetScript("OnUpdate", Stuffing.RestackOnUpdate)
	else
		self:SetScript("OnUpdate", nil)
	end
end

function Stuffing:PLAYERBANKBAGSLOTS_CHANGED()
	if not StuffingPurchaseButtonBank then return end
	local _, full = GetNumBankSlots()
	if full then
		StuffingPurchaseButtonBank:Hide()
	else
		StuffingPurchaseButtonBank:Show()
	end
end

function Stuffing.Menu(self, level)
	if not level then return end

	local info = self.info

	wipe(info)

	if level ~= 1 then return end

	wipe(info)
	info.text = BAG_FILTER_CLEANUP.." Blizzard"
	info.notCheckable = 1
	info.func = function()
		if _G["StuffingFrameReagent"] and _G["StuffingFrameReagent"]:IsShown() then
			SortReagentBankBags()
		elseif Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
			SortBankBags()
		else
			SortBags()
		end
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.text = BAG_FILTER_CLEANUP
	info.notCheckable = 1
	info.func = function()
		if InCombatLockdown() then
			K.Print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
		end
		Stuffing:SortBags()
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.text = L_BAG_STACK_MENU
	info.notCheckable = 1
	info.func = function()
		if InCombatLockdown() then
			K.Print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
		end
		Stuffing:SetBagsForSorting("d")
		Stuffing:Restack()
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.text = L_BAG_SHOW_BAGS
	info.checked = function()
		return bag_bars == 1
	end

	info.func = function()
		if bag_bars == 1 then
			bag_bars = 0
		else
			bag_bars = 1
		end
		Stuffing:Layout()
		if Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
			Stuffing:Layout(true)
		end
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.disabled = nil
	info.notCheckable = 1
	info.text = CLOSE
	info.func = self.HideMenu
	info.tooltipTitle = CLOSE
	UIDropDownMenu_AddButton(info, level)
end

-- Kill Blizzard functions
LootWonAlertFrame_OnClick = K.Noop
LootUpgradeFrame_OnClick = K.Noop
StorePurchaseAlertFrame_OnClick = K.Noop