---------------------------------------------------------------------------------------------------
-- ��Ϸ����
-- 		�¼�����
--		�û���Ϣ
-- 		��ǰ�ؿ�
--		��������Ϣ
---------------------------------------------------------------------------------------------------
local require	= require
local print 	= print
local pairs		= pairs
local cc 		= cc
local _G		= _G
---------------------------------------------------------------------------------------------------
-- app����ʱ������
GameRes = {}
GameRes.ResourceSize = {width = 720, height = 1280}
---------------------------------------------------------------------------------------------------
module "game.game"
---------------------------------------------------------------------------------------------------
local d_GuanQia = require "game.guanqia"
local GameRes = _G.GameRes
---------------------------------------------------------------------------------------------------
function touchCallBack(tag)
	if not GameRes.GameBegin then
		GameRes.GameBegin = true

		-- ����ť��ͼƬ
		-- local RefreshImg = cc.Sprite:createWithSpriteFrameName("refresh.png")
		-- GameRes.BeginButton:setNormalSpriteFrame(RefreshImg:getSpriteFrame())
		-- GameRes.BeginButton:setSelectedSpriteFrame(RefreshImg:getSpriteFrame())

		local RefreshImg = cc.Sprite:create("refresh.png")
		GameRes.BeginButton:setNormalSpriteFrame(RefreshImg:getSpriteFrame())
		GameRes.BeginButton:setSelectedSpriteFrame(RefreshImg:getSpriteFrame())
	end

	-- ˢ��
	if not GameRes.Guanqia then
		-- ��ʱʹ��ͬһ��menu
		GameRes.Guanqia = d_GuanQia:create(GameRes.BeginMenu, GameRes.winSize)
		GameRes.Guanqia:InitAllChunk()
	else
		GameRes.Guanqia:Clear()
		GameRes.Guanqia:InitAllChunk()
	end
end

function init_game()
	GameRes.director = cc.Director:getInstance()
	local glView   = GameRes.director:getOpenGLView()
	if nil == glView then
		glView = cc.GLViewImpl:createWithRect("Lua Tests", cc.rect(0,0,960,640))
		director:setOpenGLView(glView)
	end

	GameRes.glView = glView
	GameRes.winSize   = cc.Director:getInstance():getWinSize()
	GameRes.FrameSize = glView:getFrameSize()

	local function pp(name, a)
		print(name .. " {")
		for k, v in pairs(a) do
			print(k .. " = " .. v)
		end
		print("}")
	end

	---[[
	print("\n\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	pp("cc.Director:getInstance():getWinSize()", cc.Director:getInstance():getWinSize())
	pp("glView:getFrameSize()", glView:getFrameSize())
	pp("cc.Director:getInstance():getVisibleSize()", cc.Director:getInstance():getVisibleSize())
	print("---------------------------------------------")--]]

	local curAspectRatio = GameRes.FrameSize.width/GameRes.FrameSize.height
	local resAspectRatio = GameRes.ResourceSize.width/GameRes.ResourceSize.height
	print("curAspectRatio", curAspectRatio, "resAspectRatio", resAspectRatio)
	if curAspectRatio > resAspectRatio then	-- ���ÿ������Ӧ
		print(">> ResolutionPolicy.FIXED_HEIGH")
		glView:setDesignResolutionSize(GameRes.winSize.width, GameRes.winSize.height, cc.ResolutionPolicy.FIXED_HEIGHT)
	else	-- ���ø߶�����Ӧ
		print(">> ResolutionPolicy.FIXED_WIDTH")
		glView:setDesignResolutionSize(GameRes.winSize.width, GameRes.winSize.height, cc.ResolutionPolicy.FIXED_WIDTH)
	end

	GameRes.winSize   = cc.Director:getInstance():getWinSize()

	GameRes.scene = cc.Scene:create()
	local sp = cc.Sprite:create("beijintu.png")
	sp:setAnchorPoint(0, 0)
	sp:setPosition(0,0)
	sp:setScaleX(GameRes.winSize.width/GameRes.ResourceSize.width)
	sp:setScaleY(GameRes.winSize.height/GameRes.ResourceSize.height)
	-- print("GameRes.winSize.width", GameRes.winSize.width)
	-- print("GameRes.winSize.height", GameRes.winSize.height)

	---[[
	print("\n\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
	pp("cc.Director:getInstance():getWinSize()", cc.Director:getInstance():getWinSize())
	pp("glView:getFrameSize()", glView:getFrameSize())
	pp("cc.Director:getInstance():getVisibleSize()", cc.Director:getInstance():getVisibleSize())
	print("---------------------------------------------")	--]]

	GameRes.scene:addChild(sp)
	GameRes.curLayer = cc.Layer:create()
	GameRes.scene:addChild(GameRes.curLayer)


	if true then
		GameRes.BeginButton = cc.MenuItemImage:create("zantinganniu.PNG", "zantinganniu.PNG")
	    GameRes.BeginButton:registerScriptTapHandler(closeCallback)
	    GameRes.BeginButton:setPosition(cc.p(GameRes.winSize.width - 50, GameRes.winSize.height - 50))
	    GameRes.BeginButton:setScale(0.45)
	    -- ���ֱ����� �����յ�����¼� ������Ҫ���һ��emnu
		-- GameRes.curLayer:addChild(GameRes.BeginButton)

		GameRes.BeginMenu = cc.Menu:create()
		GameRes.BeginMenu:setPosition(0,0)
		GameRes.BeginMenu:addChild(GameRes.BeginButton)
		GameRes.curLayer:addChild(GameRes.BeginMenu)
	else
		-- GameRes.BeginButton = cc.ControlButton:create("zantinganniu.PNG", "zantinganniu.PNG")
		-- GameRes.BeginButton:registerScriptTapHandler(closeCallback)
	    -- GameRes.BeginButton:setPosition(cc.p(GameRes.winSize.width - 50, GameRes.winSize.height - 50))
	    -- GameRes.BeginButton:setScale(0.45)
	    -- GameRes.curLayer:addChild(GameRes.BeginButton)
	end

	--turn on display FPS
	GameRes.director:setDisplayStats(true)
	--set FPS. the default value is 1.0/60 if you don't call this
	GameRes.director:setAnimationInterval(1.0 / 60)


	local RefreshImg = cc.Sprite:create("zantinganniu.PNG")
	-- print(RefreshImg, "RefreshImg", cc.Sprite.create)
end

function register_event()
	-- print("register_event")
	-- �������
	GameRes.BeginButton:registerScriptTapHandler(touchCallBack)

--[[
	-- �������� ����touch�¼�
	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(function (touch, event)
        return true
    end,cc.Handler.EVENT_TOUCH_BEGAN)

	listener:registerScriptHandler(function (touch, event)
		print("listener:registerScriptHandler (%d).", event)
        return true
    end,cc.Handler.EVENT_TOUCH_END)
--]]
end

function runScene()
	if cc.Director:getInstance():getRunningScene() then
	    cc.Director:getInstance():replaceScene(GameRes.scene)
	else
	    cc.Director:getInstance():runWithScene(GameRes.scene)
	end
end
