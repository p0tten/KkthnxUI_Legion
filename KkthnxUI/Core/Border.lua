local K, C, _ = select(2, ...):unpack()

local _G = _G
local floor = math.floor
local pairs, type = pairs, type
local unpack = unpack

local BORDER_TEXTURE = C.Media.Border
local BORDER_TEXTURE_SHADOW = C.Media.Border_Shadow
local BORDER_SIZE = 10
local PADDING_SIZE = 1

local sections = { "TOPLEFT", "TOPRIGHT", "TOP", "BOTTOMLEFT", "BOTTOMRIGHT", "BOTTOM", "LEFT", "RIGHT" }

local function SetBackdropBorderColor(self, r, g, b, a)
	local t = self.borderTextures
	if not t then return end

	if not r or not g or not b or a == 0 then
		r, g, b = unpack(C.Media.Border_Color)
	end

	for pos, tex in pairs(t) do
		tex:SetVertexColor(r, g, b)
	end
end

local function SetBorderColor(self, r, g, b, a)
	local t = self.borderTextures
	if t then
		if not r or not g and not b then
			r, g, b = 1, 1, 1
		end
		for _, tex in pairs (t) do
			tex:SetVertexColor(r, g, b, a or 1)
		end
	end
end

local function SetBorderShadowColor(self, r, g, b, a)
	local t = self.borderShadow
	if t then
		if not r or not g and not b then
			r, g, b = 1, 1, 1
		end

		for _, tex in pairs (t) do
			tex:SetVertexColor(r, g, b, a or 1)
		end
	end
end

local function SetBorderTexture(self, texture)
	local b = self.borderTextures
	if b then
		texture = BORDER_TEXTURE
		for _, tex in pairs(b) do
			tex:SetTexture(texture)
		end
	end
end

local function SetBorderSize(self, size)
	local b = self.borderTextures
	local s = self.borderShadow
	if b then
		for _, tex in pairs(b) do
			tex:SetSize(size, size)
		end
	end
	if s then
		for _, tex in pairs(s) do
			tex:SetSize(size, size)
		end
	end
end

local function GetBorderSize(self)
	if self.borderTextures then
		local size = self.borderTextures.TOPRIGHT:GetSize()
		return size
	end
end

local function SetBorderPadding(self, T, B, L, R)
	local b = self.borderTextures
	local s = self.borderShadow
	if b and T then
		if not R and not B and not B and not L then
			R, B, L = T, T, T
		end

		b.TOPLEFT:SetPoint("TOPLEFT", self, -L, T)
		b.TOPRIGHT:SetPoint("TOPRIGHT", self, R, T)
		b.TOP:SetPoint("TOPLEFT", b.TOPLEFT, "TOPRIGHT")
		b.TOP:SetPoint("TOPRIGHT", b.TOPRIGHT, "TOPLEFT")
		b.BOTTOMLEFT:SetPoint("BOTTOMLEFT", self, -L, -B)
		b.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", self, R, -B)
		b.BOTTOM:SetPoint("BOTTOMLEFT", b.BOTTOMLEFT, "BOTTOMRIGHT")
		b.BOTTOM:SetPoint("BOTTOMRIGHT", b.BOTTOMRIGHT, "BOTTOMLEFT")
		b.LEFT:SetPoint("TOPLEFT", b.TOPLEFT, "BOTTOMLEFT")
		b.LEFT:SetPoint("BOTTOMLEFT", b.BOTTOMLEFT, "TOPLEFT")
		b.RIGHT:SetPoint("TOPRIGHT", b.TOPRIGHT, "BOTTOMRIGHT")
		b.RIGHT:SetPoint("BOTTOMRIGHT", b.BOTTOMRIGHT, "TOPRIGHT")

		local space = (self:GetBorderSize()) / 3.5

		s.TOPLEFT:SetPoint("TOPLEFT", self, -(L+space), (T+space))
		s.TOPRIGHT:SetPoint("TOPRIGHT", self, (R+space), (T+space))
		s.TOP:SetPoint("TOPLEFT", s.TOPLEFT, "TOPRIGHT")
		s.TOP:SetPoint("TOPRIGHT", s.TOPRIGHT, "TOPLEFT")
		s.BOTTOMLEFT:SetPoint("BOTTOMLEFT", self, -(L+space), -(B+space))
		s.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", self, (R+space), -(B+space))
		s.BOTTOM:SetPoint("BOTTOMLEFT", s.BOTTOMLEFT, "BOTTOMRIGHT")
		s.BOTTOM:SetPoint("BOTTOMRIGHT", s.BOTTOMRIGHT, "BOTTOMLEFT")
		s.LEFT:SetPoint("TOPLEFT", s.TOPLEFT, "BOTTOMLEFT")
		s.LEFT:SetPoint("BOTTOMLEFT", s.BOTTOMLEFT, "TOPLEFT")
		s.RIGHT:SetPoint("TOPRIGHT", s.TOPRIGHT, "BOTTOMRIGHT")
		s.RIGHT:SetPoint("BOTTOMRIGHT", s.BOTTOMRIGHT, "TOPRIGHT")
	end
end

function K.CreateBorder(self, size, padding, layer)
	if type(self) ~= "table" or self.borderTextures then return end

	if not (self.borderTextures) then
		local b = {}
		local s = {}

		for i = 1, 8 do
			local t = self:CreateTexture(nil, layer or "OVERLAY")
			t:SetParent(self)
			t:SetTexture(BORDER_TEXTURE)
			t:SetVertexColor(1, 1, 1, 1)
			b[sections[i]] = t
		end

		for i = 1, 8 do
			local t = self:CreateTexture(nil, layer or "BORDER")
			t:SetParent(self)
			t:SetTexture(BORDER_TEXTURE_SHADOW)
			t:SetVertexColor(0, 0, 0, 1)
			s[sections[i]] = t
		end

		b.TOPLEFT:SetTexCoord(0, 1/3, 0, 1/3)
		b.TOPRIGHT:SetTexCoord(2/3, 1, 0, 1/3)
		b.TOP:SetTexCoord(1/3, 2/3, 0, 1/3)
		b.BOTTOMLEFT:SetTexCoord(0, 1/3, 2/3, 1)
		b.BOTTOMRIGHT:SetTexCoord(2/3, 1, 2/3, 1)
		b.BOTTOM:SetTexCoord(1/3, 2/3, 2/3, 1)
		b.LEFT:SetTexCoord(0, 1/3, 1/3, 2/3)
		b.RIGHT:SetTexCoord(2/3, 1, 1/3, 2/3)

		s.TOPLEFT:SetTexCoord(0, 1/3, 0, 1/3)
		s.TOPRIGHT:SetTexCoord(2/3, 1, 0, 1/3)
		s.TOP:SetTexCoord(1/3, 2/3, 0, 1/3)
		s.BOTTOMLEFT:SetTexCoord(0, 1/3, 2/3, 1)
		s.BOTTOMRIGHT:SetTexCoord(2/3, 1, 2/3, 1)
		s.BOTTOM:SetTexCoord(1/3, 2/3, 2/3, 1)
		s.LEFT:SetTexCoord(0, 1/3, 1/3, 2/3)
		s.RIGHT:SetTexCoord(2/3, 1, 1/3, 2/3)

		self.borderTextures = b
		self.borderShadow = s

		self.SetBackdropBorderColor = SetBackdropBorderColor
		self.SetBorderColor = SetBorderColor
		self.SetBorderShadowColor = SetBorderShadowColor
		self.SetBorderTexture = SetBorderTexture
		self.SetBorderSize = SetBorderSize
		self.GetBorderSize = GetBorderSize
		self.SetBorderPadding = SetBorderPadding

		self:SetBorderSize(size or BORDER_SIZE)
		self:SetBorderPadding(padding or PADDING_SIZE)
	end
end