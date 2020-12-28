if not SICFL.canGetDebugTools then return end

-- ------------------------------------------------------------------------------------------------
-- --------- 创建科技包 ---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local debugPack = SIGen.NewTool( "debug-science-pack" , 100000 ).SetHealth( 1 , SIFlags.sciencePack.key , SIFlags.sciencePack.value ).GetCurrentEntityName()

SIGen.NewRecipe( debugPack )
.SetEnergy( 15 )
.SetEnabled( true )
.AddCosts( "iron-ore" , 350 )
.AddCosts( "copper-ore" , 350 )
.AddCosts( "stone" , 350 )
.AddCosts( "coal" , 350 )
.AddResults( SIPackers.SingleItemProduct( debugPack , 1 , nil , nil , 1 ) )

SICFL.debugPack = { debugPack }

-- ------------------------------------------------------------------------------------------------
-- --------- 创建研究球 ---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function CreateOnAnimation( path )
	return
	{
		layers =
		{
			SIPics.NewLayer( path , 98 , 87 ).Shift( 0 , 1.5 ).Anim( 11 , 33 , 1/3 ).Get() ,
			SIPics.NewLayer( path.."-light" , 106 , 100 ).BlendMode( SIPics.blendMode.additive ).Shift( -1 , 1 ).Anim( 11 , 33 , 1/3 ).Light().Get() ,
			SIPics.NewLayer( path.."-shadow" , 122 , 68 ).Shift( 13 , 11 ).Repeat( 33 , 1/3 ).Shadow().Get()
		}
	}
end

local function CreateOffAnimation( path )
	return
	{
		layers =
		{
			SIPics.NewLayer( path , 98 , 87 ).Shift( 0 , 1.5 ).Frame().Get() ,
			SIPics.NewLayer( path.."-shadow" , 122 , 68 ).Shift( 13 , 11 ).Frame().Shadow().Get()
		}
	}
end

local baseLab = SIGen.GetData( SITypes.entity.lab , "lab" )

local labItem = SIGen.NewLab( "debug-science" )
.SetProperties( 3 , 3 , 1 , 1 , "233KW" , SIPackers.EnergySource( SITypes.energy.electric ) )
.SetCorpse( "lab-remnants" , "lab-explosion" )
.SetPic( "on_animation" , CreateOnAnimation( SIGen.GetLayerFile() ) )
.SetPic( "off_animation" , CreateOffAnimation( SIGen.GetLayerFile() ) )
.SetCustomData
{
	inputs = SICFL.debugPack ,
	open_sound = baseLab.open_sound ,
	close_sound = baseLab.close_sound ,
	working_sound = baseLab.working_sound ,
	vehicle_impact_sound = baseLab.vehicle_impact_sound
}
.GetCurrentEntityItemName()

SIGen.NewRecipe( labItem )
.SetEnergy( 35 )
.SetEnabled( true )
.AddCosts( baseLab.name , 100 )
.AddCosts( debugPack , 20 )
.AddResults( SIPackers.SingleItemProduct( labItem , 1 , nil , nil , 1 ) )