-----------------------------------------------------------------------------------
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")
-----------------------------------------------------------------------------------
-- main入口
-----------------------------------------------------------------------------------
-- 测试打开
_DEBUG = false
-----------------------------------------------------------------------------------
require "config"
require "cocos.init"
-----------------------------------------------------------------------------------
if _DEBUG then
	local old_require = _G.require
	_G.require = function (filename)
		print(filename, "Load Begin")
		local mol = old_require(filename)
		print(filename, "Load End")
		return mol
	end

	local old_print = _G.print
	_G.print = function(...)
		local all_print = {...}
		for _, p in pairs(all_print) do
			if type(p) == "table" then
				old_print(p, "{")
				for k, v in pairs(p) do
					old_print(k, v)
				end
				old_print("}")
			else
				old_print(p)
			end
		end
	end
end
-----------------------------------------------------------------------------------
local d_game = require "game.game"
-----------------------------------------------------------------------------------
local function main()
	d_game.init_game()
	d_game.register_event()
	d_game.runScene()
end

-----------------------------------------------------------------------------------
local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
