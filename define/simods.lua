SIMods =
{
	list =
	{
		SIBasicTechnologies = "SI 基础技术[SI Basic Technologies]" ,
		SIColorfulWorld = "SI 多彩世界[SI Colorful World]" ,
		SISuddenInspiration = "SI 突发灵感[SI Sudden Inspiration]" ,
		
		SIModeRPG = "SI 角色扮演[SI RPG Mode]" ,
		SIModeRTS = "SI 即时战略[SI RTS Mode]" ,
		
		SIEXInfinityTechnologies = "SI EX 无尽科技[SI EX Infinity Technologies]" ,
		SIEXHyperspaceStorage = "SI EX 超空间仓储[SI EX Hyperspace Storage]" ,
		SIEXPipeAndBarrel = "SI EX 管道和装桶[SI EX Pipe And Barrel]" ,
		SIEXItemStack = "SI EX 物品堆叠[SI EX Item Stack]" ,
		SIEXQuickStart = "SI EX 快速开始[SI EX Quick Start]" ,
		
		SISPRepairSelf = "SI SP 修理自己[SI SP Repair Self]" ,
		SISPOneStackChallenge = "SI SP 单堆叠挑战[SI SP One Stack Challenge]" ,
		
		SIAgriculture = "SI 农业[SI Agriculture]" ,
		SIAnimalHusbandry = "SI 牧业[SI Animal Husbandry]" ,
		SIMiningIndustry = "SI 矿业[SI Mining Industry]" ,
		SIBasicMaterialsScience = "SI 基础材料学[SI Basic Materials Science]" ,
		SIElementaryStudies = "SI 元素学[SI Elementary Studies]" ,
		SIManufacturingCraftsmanship = "SI 制造工艺[SI Manufacturing Craftsmanship]" ,
		SIAdvancedMaterialsScience = "SI 进阶材料学[SI Advanced Materials Science]" ,
		SIPrecisionElectronics = "SI 精密电子学[SI Precision Electronics]" ,
		SIAncientInheritance = "SI 远古传承[SI Ancient Inheritance]" ,
		SILegendCreation = "SI 传奇创造[SI Legend Creation]" ,
		SISummitCraftsmanship = "SI 巅峰工艺[SI Summit Craftsmanship]" ,
		SISummitTechnology = "SI 巅峰科技[SI Summit Technology]" ,
		
		base = "基础游戏" ,
		Krastorio2 = "k2" ,
		SpaceExploration = "太空扩展"
	}
}

local modList = nil
if mods then modList = mods
elseif script and script.active_mods then modList = script.active_mods end

if modList then
	local loaded
	local version
	for realname , displayName in pairs( SIMods.list ) do
		loaded = false
		version = 0
		for name , versionString in pairs( modList ) do
			if name == realname then
				loaded = true
				version = tonumber( string.gsub( versionString , "." , "" ) )
				break
			end
		end
		SIMods[realname] =
		{
			displayName = displayName ,
			loaded = loaded ,
			version = version
		}
	end
end