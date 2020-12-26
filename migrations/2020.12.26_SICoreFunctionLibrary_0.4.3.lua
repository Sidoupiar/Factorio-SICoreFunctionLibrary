-- ------------------------------------------------------------------------------------------------
-- -------- 修改窗口数据 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 创建全局引用
SIGlobal.CreateOnMigrations()

local players = {}
for playerIndex , viewData in pairs( SITitlebarViews ) do
	SITitlebar.CloseView( playerIndex , viewData )
	table.insert( players , playerIndex )
end

for playerIndex , viewData in pairs( SIViewGameSpeedViews ) do
	if not viewData.data then viewData.data = {} end
end

for index , playerIndex in pairs( players ) do
	local event = { player_index = playerIndex }
	SITitlebar.OnInitPlayer( event )
end

SIOremap.HideViews()