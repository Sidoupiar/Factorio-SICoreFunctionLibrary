-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function Balance( level )
	return
	{
		[SITypes.moduleEffect.speed] = { bonus = level*5 } ,
		[SITypes.moduleEffect.product] = { bonus = level*1 } ,
		[SITypes.moduleEffect.consumption] = { bonus = -level*5 } ,
		[SITypes.moduleEffect.pollut] = { bonus = -level*5 }
	}
end

SIGen.NewTypeModule( "sicfl-module-balance" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建插件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

for level = 1 , 3 , 1 do
	SIGen.NewModule( "module-balance-mk"..level , 100 )
	.SetLevel( level )
	.SetCustomData
	{
		category = "sicfl-module-balance" ,
		effect = Balance( level )
	}
end