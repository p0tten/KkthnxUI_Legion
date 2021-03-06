local K, C, L, _ = select(2, ...):unpack()

local ObjectiveTracker = CreateFrame("Frame", "ObjectiveTracker", UIParent)

function ObjectiveTracker:SetTrackerPosition()
	ObjectiveTrackerFrame:SetPoint("TOPRIGHT", ObjectiveTracker)
end

function ObjectiveTracker:Enable()
	if K.IsAddOnEnabled("DugisGuideViewerZ") then
		return
	end

	local Movers = K.Movers
	local Frame = ObjectiveTrackerFrame
	local ScenarioStageBlock = ScenarioStageBlock
	local Data = SavedPositions
	local Anchor1, Parent, Anchor2, X, Y = "TOPRIGHT", UIParent, "TOPRIGHT", -K.ScreenHeight / 8, -K.ScreenHeight / 4

	self:SetSize(235, 23)
	self:SetPoint(Anchor1, Parent, Anchor2, X, Y)
	self.SetTrackerPosition(Frame)

	Movers:RegisterFrame(self)
	Movers:SaveDefaults(self, Anchor1, Parent, Anchor2, X, Y)

	if Data and Data.Move and Data.Move.ObjectiveTracker then
		self:ClearAllPoints()
		self:SetPoint(unpack(Data.Move.ObjectiveTracker))
	end

	for i = 1, 5 do
		local Module = ObjectiveTrackerFrame.MODULES[i]

		if Module then
			local Header = Module.Header

			Header:StripTextures()
			Header:Show()
		end
	end

	Frame.ClearAllPoints = function() end
	Frame.SetPoint = function() end
end

ObjectiveTracker:RegisterEvent("PLAYER_ENTERING_WORLD")
ObjectiveTracker:SetScript("OnEvent", function(self, event, ...)
	ObjectiveTracker:Enable()
	ObjectiveTracker:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)
