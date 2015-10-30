---------------------------------------------------------------------------------------------------
-- 用户信息
---------------------------------------------------------------------------------------------------
local User = class("User")

function User:ctor(param)
	self.m_name = "test"
end

function User:GetUserLevel()
	return 1
end

return User