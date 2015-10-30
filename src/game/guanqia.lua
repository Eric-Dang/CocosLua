---------------------------------------------------------------------------------------------------
-- 关卡信息
---------------------------------------------------------------------------------------------------
local d_chunk = require "game.chunk"
---------------------------------------------------------------------------------------------------
local chuck_color = {
	pink	= 1, -- 粉色
	red	 	= 2, -- 红色
	yellow	= 3, -- 黄色
	blue	= 4, -- 蓝色
	green	= 5, -- 绿色
	purple  = 6, -- 紫色
}

-- 各种颜色各种状态对应的贴图信息
local chunk_file_names = {
	[chuck_color.pink] = {
	 	normal = "yuansu_fen.PNG",
		normalTNT = "fanweifen.png", normalRowMissile = "hengzadanfen.png", normalColumnMissile = "suzadanfen.png", normalSpecter = "zadanfen.png",
		specialTNT = "fanwei.png", specialRowMissile = "henzadan.png", specialColumnMissile = "suzadan.png", specialSpecter = "yuansu_ranse.png"
	},

	[chuck_color.red] = {
		normal = "yuansu_hong.PNG",
	 	normalTNT = "fanweihong.png", normalRowMissile = "hengzadanhong.png", normalColumnMissile = "suzadanhong.png", normalSpecter = "zadanhong.png",
	 	specialTNT = "fanwei.png", specialRowMissile = "henzadan.png", specialColumnMissile = "suzadan.png", specialSpecter = "yuansu_ranse.png"
	},

	[chuck_color.yellow] = {
		normal = "yuansu_huang.PNG",
	 	normalTNT = "fanweihuang.png", normalRowMissile = "hengzadanhuang.png", normalColumnMissile = "suzadanhuang.png", normalSpecter = "zadanhuang.png",
	 	specialTNT = "fanwei.png", specialRowMissile = "henzadan.png", specialColumnMissile = "suzadan.png", specialSpecter = "yuansu_ranse.png"
	},

	[chuck_color.blue] = {
		normal = "yuansu_lan.PNG",
	 	normalTNT = "fanweilan.png", normalRowMissile = "hengzadanlan.png", normalColumnMissile = "suzadanlan.png", normalSpecter = "zadanlan.png",
	 	specialTNT = "fanwei.png", specialRowMissile = "henzadan.png", specialColumnMissile = "suzadan.png", specialSpecter = "yuansu_ranse.png"
	},

	[chuck_color.green] = {
		normal = "yuansu_lv.PNG",
	 	normalTNT = "fanweilv.png", normalRowMissile = "hengzadanlv.png", normalColumnMissile = "suzadanlv.png", normalSpecter = "zadanlv.png",
	 	specialTNT = "fanwei.png", specialRowMissile = "henzadan.png", specialColumnMissile = "suzadan.png", specialSpecter = "yuansu_ranse.png"
	},

	[chuck_color.purple] = {
		normal = "yuansu_zhi.PNG",
	 	normalTNT = "fanweizhi.png", normalRowMissile = "hengzadanzhi.png", normalColumnMissile = "suzadanzhi.png", normalSpecter = "zadanzhi.png",
	 	specialTNT = "fanwei.png", specialRowMissile = "henzadan.png", specialColumnMissile = "suzadan.png", specialSpecter = "yuansu_ranse.png"
	},
}
---------------------------------------------------------------------------------------------------
local Guanqia = class("Guanqia")
---------------------------------------------------------------------------------------------------
-- 根据touch的位置确定点击的是哪个块
-- 返回值为m_guanqia_info中的索引
-- index顺序和m_guanqia_info存储方式相同
local function GetIndexByTouchPos(x, y)
	return 1, 1
end

function Guanqia:ctor(tContainer, winSize)
	-- 玩家选择关卡的填充数据 i26对应的数据信息为self.m_guanqia_info[2][6]
	-- 优先行存储
	-- 列\行 1	2	3	4	5
	--	 1	i11 i12 i13 i14 i15
	--	 2  i26
	--	 3
	--	 4
	--	 5				    i55
	self.m_guanqia_info 	= {}			-- 关卡信息
	self.m_Container		= tContainer	-- 点消块容器
	self.m_winSize 			= winSize		-- 尺寸
	self.m_chunkLength 		= 40			-- 点消块大小
	self.m_chunkWidth  		= 40			-- 点消块大小
	self.m_chunkRowCount	= 9				-- 容器可以容纳点消块的纵横数量
	self.m_chunkColumnCount	= 9				-- 容器可以容纳点消块的纵横数量
	self.GuanqiaRect		= {}			-- 容器存放点消块的Rect
	self:CalcGuanqiaRect()
end

function Guanqia:CalcGuanqiaRect()
	-- for k, v in pairs(self.m_winSize) do print(k, v) end
	local centerX = math.floor(self.m_winSize.width/2)
	local centerY = math.floor(self.m_winSize.height/2)

	local chunkRowLen    = self.m_chunkRowCount * self.m_chunkLength
	local chunkColumnLen = self.m_chunkColumnCount * self.m_chunkWidth

	local allChunkCenterX = math.floor(chunkRowLen/2)
	local allChunkCenterY = math.floor(chunkColumnLen/2)

	-- 默认的锚点是(0.5, 0.5)
	self.GuanqiaRect.left   = centerX - allChunkCenterX	+ math.floor(self.m_chunkLength/2)
	self.GuanqiaRect.right  = centerX + allChunkCenterX
	self.GuanqiaRect.top	= centerY + allChunkCenterY
	self.GuanqiaRect.bottom	= centerY - allChunkCenterY + math.floor(self.m_chunkWidth/2)


end

function Guanqia:GetDropChunk(row, column)
	return math.random(1, 6)
end

function Guanqia:GetLevelConfig(level)
	for i = 1, 9 do
		self.m_guanqia_info[i] = {}
		for j = 1, 9 do
			self.m_guanqia_info[i][j] = math.random(1, 6)
		end
	end

	return self.m_guanqia_info
end

function Guanqia:InitAllChunk()
	local level_config = self:GetLevelConfig(1)
	for row, row_info in pairs(level_config) do
		for column, chunkType in pairs(row_info) do
			local chunk_inof = {
				row  		= row,
				column 		= column,
				type 		= chunkType,
				chartlet 	= chunk_file_names[chunkType],
				container 	= self.m_Container,
			}
			local chunk = d_chunk.Chunk:create(chunk_inof)
			local chunkPos = {
				x = self.GuanqiaRect.left + self.m_chunkLength * (row - 1),
				y = self.GuanqiaRect.bottom + self.m_chunkWidth * (column - 1)
			}
			chunk:Init(chunkPos)
			self.m_guanqia_info[row][column] = chunk
		end
	end
end

function Guanqia:Clear()

end


function Guanqia:ClickChunk(row, column)
	print("Guanqia:ClickChunk", row, column)
end

return Guanqia
