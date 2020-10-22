local entity = SIGen.Base:Copy( "entity" )
entity:AddDefaultValue( "width" , 0 )
:AddDefaultValue( "height" , 0 )
:AddDefaultValue( "totalHeight" , 0 )
:AddDefaultValue( "itemStackSize" , 0 )
:AddDefaultValue( "itemName" , nil )
:AddDefaultValue( "item" , nil )



function entity:SetTotalHeight( totalHeight )
	self.totalHeight = totalHeight
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

function entity:GetTotalHeight()
	return self.totalHeight
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
	if not width or width < 0 then
		e( "模块构建 : 实体的宽度(width)不能为 0 或负数" )
		return self
	end
	if not height then height = width end
	if height < 0 then
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
	if not intensity then intensity = 0.75 end
	if not size then size = math.max( self:GetWidth() , self:GetHeight() )*SINumbers.lightSizeMult end
	if not color then color = SIColors.baseColor.baseWhite end
	return self:SetParam( "light" , { intensity = intensity , size = size , color = color } )
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