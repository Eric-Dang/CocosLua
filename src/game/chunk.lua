---------------------------------------------------------------------------------------------------
-- 点消块
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
-- 块显示图片的缩放系数
local ChunkImageScale = 0.5
---------------------------------------------------------------------------------------------------
local GameRes = _G.GameRes
---------------------------------------------------------------------------------------------------
-- self.m_Chartlet 数据结构
-- normal normal			正常图片	默认显示
-- normal TNT				范围炸弹 贴图
-- normal row missile		横向导弹 贴图
-- normal column missile	纵向导弹 贴图
-- normal specter			幽灵 贴图 吞吃一种颜色
-- special TNT				炸弹块
-- special row missile		横向导弹
-- special column missile	纵向导弹
-- special specter			幽灵
---------------------------------------------------------------------------------------------------
function Chunk:ctor(param)
	self.m_Row		= param.row
	self.m_Column	= param.column
	self.m_Type 	= param.type		-- 索引
	self.m_Chartlet	= param.chartlet	-- 贴图	包含各种贴图 正常，炸弹，导弹，幽灵
	self.m_Container= param.container	-- 容器
	self.m_Item		= false
end
---------------------------------------------------------------------------------------------------
-- 生成新的块
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
-- 预先显示
---------------------------------------------------------------------------------------------------
-- 改为TNT贴图
function Chunk:SetNormalTNT()
end

-- 改为横向导弹贴图
function Chunk:SetNormalRowMissile()
end

-- 改为纵向导弹贴图
function Chunk:SetNormalColumnMissile()
end
-- 改为幽灵贴图
function Chunk:SetNormalSpecter()
end

-- 改为正常图片
function Chunk:SetReNormal()
end
---------------------------------------------------------------------------------------------------
-- 特殊效果
---------------------------------------------------------------------------------------------------
-- 改为TNT贴图
function Chunk:SetSpecialTNT()
end

-- 改为横向导弹贴图
function Chunk:SetSpecialRowMissile()
end

-- 改为纵向导弹贴图
function Chunk:SetSpecialColumnMissile()
end

-- 改为幽灵贴图
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

