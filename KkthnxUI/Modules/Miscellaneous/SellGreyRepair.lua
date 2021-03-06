local K, C, L, _ = select(2, ...):unpack()

local Merchant = CreateFrame("Frame")

Merchant.MerchantFilter = {
	[6289]  = true, -- Raw Longjaw Mud Snapper
	[6291]  = true, -- Raw Brilliant Smallfish
	[6308]  = true, -- Raw Bristle Whisker Catfish
	[6309]  = true, -- 17 Pound Catfish
	[6310]  = true, -- 19 Pound Catfish
	[41808] = true, -- Bonescale Snapper
	[42336] = true, -- Bloodstone Band
	[42337] = true, -- Sun Rock Ring
	[43244] = true, -- Crystal Citrine Necklace
	[43571] = true, -- Sewer Carp
	[43572] = true, -- Magic Eater
}

function Merchant:OnEvent()
	if C.Misc.AutoSellGrays or C.Misc.SellMisc then
		local Cost = 0

		for Bag = 0, 4 do
			for Slot = 1, GetContainerNumSlots(Bag) do
				local Link, ID = GetContainerItemLink(Bag, Slot), GetContainerItemID(Bag, Slot)

				if (Link and ID) then
					local Price = 0
					local Mult1, Mult2 = select(11, GetItemInfo(Link)), select(2, GetContainerItemInfo(Bag, Slot))

					if (Mult1 and Mult2) then
						Price = Mult1 * Mult2
					end

					if (C.Misc.AutoSellGrays and select(3, GetItemInfo(Link)) == 0 and Price > 0) then
						UseContainerItem(Bag, Slot)
						PickupMerchantItem()
						Cost = Cost + Price
					end

					if C.Misc.SellMisc and self.MerchantFilter[ID] then
						UseContainerItem(Bag, Slot)
						PickupMerchantItem()
						Cost = Cost + Price
					end
				end
			end
		end

		if (Cost > 0) then
			local Gold, Silver, Copper = math.floor(Cost / 10000) or 0, math.floor((Cost % 10000) / 100) or 0, Cost % 100

			DEFAULT_CHAT_FRAME:AddMessage(L_MISC_SOLDTRASH.." |cffffffff"..Gold..L_SHORT_GOLD.." |cffffffff"..Silver..L_SHORT_SILVER.." |cffffffff"..Copper..L_SHORT_COPPER..".", 0255, 255, 0)
		end
	end

	if (not IsShiftKeyDown()) then
		if (CanMerchantRepair() and C.Misc.AutoRepair) then
			local Cost, Possible = GetRepairAllCost()

			if (Cost > 0) then
				if (IsInGuild() and C.Misc.UseGuildRepair) then
					local CanGuildRepair = (CanGuildBankRepair() and (Cost <= GetGuildBankWithdrawMoney()))

					if CanGuildRepair then
						RepairAllItems(1)

						return
					end
				end

				if Possible then
					RepairAllItems()

					local Copper = Cost % 100
					local Silver = math.floor((Cost % 10000) / 100)
					local Gold = math.floor(Cost / 10000)
					DEFAULT_CHAT_FRAME:AddMessage(L_REPAIR_REPAIRCOST.." |cffffffff"..Gold..L_SHORT_GOLD.." |cffffffff"..Silver..L_SHORT_SILVER.." |cffffffff"..Copper..L_SHORT_COPPER..".", 255, 255, 0)
				else
					DEFAULT_CHAT_FRAME:AddMessage(L_REPAIR_NOTENOUGHMONEY, 255, 0, 0)
				end
			end
		end
	end
end

Merchant:RegisterEvent("PLAYER_ENTERING_WORLD")
Merchant:RegisterEvent("MERCHANT_SHOW")
Merchant:SetScript("OnEvent", Merchant.OnEvent)
Merchant:UnregisterEvent("PLAYER_ENTERING_WORLD") -- ??