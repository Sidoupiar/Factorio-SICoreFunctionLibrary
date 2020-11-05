local entity = SIGen.Base:Copy( "entity" )
entity:AddDefaultValue( "width" , 0 )
:AddDefaultValue( "height" , 0 )
:AddDefaultValue( "addenWidth" , 0 )
:AddDefaultValue( "addenHeight" , 0 )
:AddDefaultValue( "shadowWidth" , 0 )
:AddDefaultValue( "shadowHeight" , 0 )
:AddDefaultValue( "hasHr" , false )
:AddDefaultValue( "animShadow" , false )
:AddDefaultValue( "patchLocation" , nil )
:AddDefaultValue( "waterLocation" , nil )
:AddDefaultValue( "itemStackSize" , 0 )
:AddDefaultValue( "itemName" , nil )
:AddDefaultValue( "item" , nil )



function entity:SetAddenSize( addenWidth , addenHeight )
	self.addenWidth = addenWidth
	self.addenHeight = addenHeight
	return self
end

function entity:SetAddenWidth( addenWidth )
	self.addenWidth = addenWidth
	return self
end

function entity:SetAddenHeight( addenHeight )
	self.addenHeight = addenHeight
	return self
end

function entity:SetShadowSize( shadowWidth , shadowHeight )
	self.shadowWidth = shadowWidth
	self.shadowHeight = shadowHeight
	return self
end

function entity:SetShadowWidth( shadowWidth )
	self.shadowWidth = shadowWidth
	return self
end

function entity:SetShadowHeight( shadowHeight )
	self.shadowHeight = shadowHeight
	return self
end

function entity:SetHasHr( hasHr )
	self.hasHr = hasHr
	return self
end

function entity:SetAnimShadow( animShadow )
	self.animShadow = animShadow
	return self
end

function entity:SetPatchLocation( x , y )
	self.patchLocation = { x , y }
	return self
end

function entity:SetWaterLocation( x , y )
	self.waterLocation = { x , y }
	return self
end

function entity:SetItemName( itemName )
	self.itemName = itemName
	return self
end

function entity:GetWidth()
	return self.width
end

function entity:GetHeight()
	return self.height
end

function entity:GetAddenWidth()
	return self.addenWidth
end

function entity:GetAddenHeight()
	return self.addenHeight
end

function entity:GetShadowWidth()
	return self.shadowWidth
end

function entity:GetShadowHeight()
	return self.shadowHeight
end

function entity:GetHasHr()
	return self.hasHr
end

function entity:GetAnimShadow()
	return self.animShadow
end

function entity:GetPatchLocation()
	return self.patchLocation
end

function entity:GetWaterLocation()
	return self.waterLocation
end

function entity:GetItemStackSize()
	return self.itemStackSize
end

function entity:GetItemName()
	return self.itemName
end

function entity:GetItem()
	return self.item
end



function entity:DefaultFlags()
	return self:SetParam( "flags" , {} )
end



function entity:SetStackSize( stackSize )
	if type( stackSize ) == "number" then self.itemStackSize = stackSize end
	return self
end

function entity:SetSize( width , height )
	if not width or width <= 0 then
		e( "模块构建 : 实体的宽度(width)不能为 0 或负数" )
		return self
	end
	if not height then height = width end
	if height <= 0 then
		e( "模块构建 : 实体的高度(height)不能为 0 或负数" )
		return self
	end
	local currentWidth = self.width
	local currentHeight = self.height
	if currentWidth ~= width or currentHeight ~= height then
		self.width = width
		self.height = height
		return self:SetParam( "selection_box" , SIPackers.BoundBox( self.width , self.height ) )
		:SetParam( "collision_box" , SIPackers.CollisionBoundBox( self.width , self.height ) )
		:SetImage( SIGen.GetCurrentConstantsData().picturePath )
	else return self end
end

function entity:SetLight( intensity , size , color )
	intensity = intensity or 0.75
	size = size or ( math.max( self:GetWidth() , self:GetHeight() ) * SINumbers.lightSizeMult )
	color = color or SIColors.baseColor.baseWhite
	return self:SetParam( "light" , SIPackers.Light( intensity , size , color ) )
end



function entity:Fill( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Fill( currentEntity )
	local stackSize = currentEntity:GetItemStackSize()
	if stackSize and stackSize > 0 then
		local item = currentEntity:GetItem()
		if not item then
			currentEntity.item = SIGen.Item:New( currentEntity:GetItemName() or currentEntity:GetBaseName() )
			:Init()
			:DefaultFlags()
			:SetGroup( SIGen.GetCurrentSubGroupEntity() )
			:SetOrder( SIGen.GetCurrentDataOrder() )
			:SetStackSize( stackSize )
			:SetResults( currentEntity:GetName() , SIGen.resultType.entity )
			:Fill()
		end
	end
	return self
end

function entity:Auto( currentEntity )
	if not currentEntity then currentEntity = self end
	self.super:Auto( currentEntity )
	local item = currentEntity:GetItem()
	if item and not item:HasExtend() then item:Extend():Finish() end
	return self
end

return entity