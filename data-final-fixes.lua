-- ------------------------------------------------------------------------------------------------
-- ---------- 调整数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.GetData( SITypes.fluid , "steam" ).max_temperature = 3000
for name , func in pairs( SIGen.F ) do func() end