-- ------------------------------------------------------------------------------------------------
-- -------- 修改窗口数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 创建全局引用
SIGlobal.CreateOnMigrations()

local views = {}
for playerIndex , viewData in pairs( SIToolbarViews ) do views[playerIndex] = viewData end

for playerIndex , viewData in pairs( views ) do
	-- 移除旧的界面
	SIToolbarViews[playerIndex] = nil
	if viewData.view then viewData.view.destroy() end
	-- 创新新的界面
	SITitlebar.OnInitPlayer{ player_index = playerIndex }
end