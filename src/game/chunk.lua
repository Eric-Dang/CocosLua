---------------------------------------------------------------------------------------------------
-- ������
---------------------------------------------------------------------------------------------------
local cc		= cc
local print 	= print
local class		= class
local assert 	= assert
local _G		= _G
---------------------------------------------------------------------------------------------------
module "game.chunk"
---------------------------------------------------------------------------------------------------
Chunk = class("Chunk")
---------------------------------------------------------------------------------------------------
-- ����ʾͼƬ������ϵ��
local ChunkImageScale = 0.5
---------------------------------------------------------------------------------------------------
local GameRes = _G.GameRes
---------------------------------------------------------------------------------------------------
-- self.m_Chartlet ���ݽṹ
-- normal normal			����ͼƬ	Ĭ����ʾ
-- normal TNT				��Χը�� ��ͼ
-- normal row missile		���򵼵� ��ͼ
-- normal column missile	���򵼵� ��ͼ
-- normal specter			���� ��ͼ �̳�һ����ɫ
-- special TNT				ը����
-- special row missile		���򵼵�
-- special column missile	���򵼵�
-- special specter			����
---------------------------------------------------------------------------------------------------
function Chunk:ctor(param)
	self.m_Row		= param.row
	self.m_Column	= param.column
	self.m_Type 	= param.type		-- ����
	self.m_Chartlet	= param.chartlet	-- ��ͼ	����������ͼ ������ը��������������
	self.m_Container= param.container	-- ����
	self.m_Item		= false
end
---------------------------------------------------------------------------------------------------
-- �����µĿ�
function Chunk:Init(pos)
	local normal = self.m_Chartlet.normal
	assert(self.m_Chartlet.normal)

	local function callBack(tag)
		print("chuck", self.m_Row, self.m_Column, tag)
		GameRes.Guanqia:ClickChunk(self.m_Row, self.m_Column)
	end


	self.m_Item = cc.MenuItemImage:create(normal, normal)
	self.m_Item:registerScriptTapHandler(callBack)
	self.m_Item:setPosition(pos)
	self.m_Item:setScale(ChunkImageScale)
	-- self.m_Item:setAnchorPoint({x = 0, y = 0})

	self.m_Container:addChild(self.m_Item)
end
---------------------------------------------------------------------------------------------------
-- Ԥ����ʾ
---------------------------------------------------------------------------------------------------
-- ��ΪTNT��ͼ
function Chunk:SetNormalTNT()
end

-- ��Ϊ���򵼵���ͼ
function Chunk:SetNormalRowMissile()
end

-- ��Ϊ���򵼵���ͼ
function Chunk:SetNormalColumnMissile()
end
-- ��Ϊ������ͼ
function Chunk:SetNormalSpecter()
end

-- ��Ϊ����ͼƬ
function Chunk:SetReNormal()
end
---------------------------------------------------------------------------------------------------
-- ����Ч��
---------------------------------------------------------------------------------------------------
-- ��ΪTNT��ͼ
function Chunk:SetSpecialTNT()
end

-- ��Ϊ���򵼵���ͼ
function Chunk:SetSpecialRowMissile()
end

-- ��Ϊ���򵼵���ͼ
function Chunk:SetSpecialColumnMissile()
end

-- ��Ϊ������ͼ
function Chunk:SetSpecialSpecter()
end
---------------------------------------------------------------------------------------------------
function GetChunkImageScale()
	print("ChunkImageScale", ChunkImageScale)
	return ChunkImageScale
end

function SetChunkImageScale(NewScale)
	print("Cur ChunkImageScale", ChunkImageScale)
	ChunkImageScale = NewScale
	print("Change ChunkImageScale", ChunkImageScale)
end
print("-------------------------------------------------")
---------------------------------------------------------------------------------------------------

