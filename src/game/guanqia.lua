---------------------------------------------------------------------------------------------------
-- �ؿ���Ϣ
---------------------------------------------------------------------------------------------------
local d_chunk = require "game.chunk"
---------------------------------------------------------------------------------------------------
local chuck_color = {
	pink	= 1, -- ��ɫ
	red	 	= 2, -- ��ɫ
	yellow	= 3, -- ��ɫ
	blue	= 4, -- ��ɫ
	green	= 5, -- ��ɫ
	purple  = 6, -- ��ɫ
}

-- ������ɫ����״̬��Ӧ����ͼ��Ϣ
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
-- ����touch��λ��ȷ����������ĸ���
-- ����ֵΪm_guanqia_info�е�����
-- index˳���m_guanqia_info�洢��ʽ��ͬ
local function GetIndexByTouchPos(x, y)
	return 1, 1
end

function Guanqia:ctor(tContainer, winSize)
	-- ���ѡ��ؿ���������� i26��Ӧ��������ϢΪself.m_guanqia_info[2][6]
	-- �����д洢
	-- ��\�� 1	2	3	4	5
	--	 1	i11 i12 i13 i14 i15
	--	 2  i26
	--	 3
	--	 4
	--	 5				    i55
	self.m_guanqia_info 	= {}			-- �ؿ���Ϣ
	self.m_Container		= tContainer	-- ����������
	self.m_winSize 			= winSize		-- �ߴ�
	self.m_chunkLength 		= 40			-- �������С
	self.m_chunkWidth  		= 40			-- �������С
	self.m_chunkRowCount	= 9				-- �����������ɵ�������ݺ�����
	self.m_chunkColumnCount	= 9				-- �����������ɵ�������ݺ�����
	self.GuanqiaRect		= {}			-- ������ŵ������Rect
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

	-- Ĭ�ϵ�ê����(0.5, 0.5)
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
