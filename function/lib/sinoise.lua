-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local SINoise =
{
	_VERSION     = "noise.lua 1.0.0" ,
	_DESCRIPTION = "Noise function in Lua (5.1-3, LuaJIT)" ,
	_URL         = "https://github.com/Sidoupiar/Lua-SINoise.lua" ,
	_LICENSE     =
	[[
		MIT LICENSE
		Copyright (c) 2013 Enrique García Cota + Adam Baldwin + hanzao + Equi 4 Software
		Permission is hereby granted, free of charge, to any person obtaining a
		copy of this software and associated documentation files (the
		"Software"), to deal in the Software without restriction, including
		without limitation the rights to use, copy, modify, merge, publish,
		distribute, sublicense, and/or sell copies of the Software, and to
		permit persons to whom the Software is furnished to do so, subject to
		the following conditions:
		
		The above copyright notice and this permission notice shall be included
		in all copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
		OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
		MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
		IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
		CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
		TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
		RE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	]]
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 添加引用 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local bit = require( "sibit" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 内部函数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function noise( x , y , seed )
	local n = x + y * 57;
	n = bit.LShift( 13 , n ) ^ n;
	return 1 - bit.And( ( n * ( n * n * seed + 789221 ) + 1376312589 ) , 0x7fffffff ) / 1073741824;
end

local function smoothed_noise( x , y , seed )
	local corners = noise( x-1 , y-1 , seed ) + noise( x+1 , y-1 , seed ) + noise( x-1 , y+1 , seed ) + noise( x+1 , y+1 , seed );
	local sides = noise( x-1 , y , seed ) + noise( x+1 , y , seed ) + noise( x , y-1 , seed ) + noise( x , y+1 , seed );
	local center = noise( x , y , seed ) / 4;
	return corners / 16 + sides / 8 + center;
end

local function cosine_interpolate( a , b , x )
	local ft = x * 3.1415927;
	local f = ( 1 - math.cos( ft ) ) * 0.5;
	return a * ( 1 - f ) + b * f;
end

local function interpolated_noise( x , y , seed )
	local intX = math.floor( x );
	local fractionalX = x - intX;
	local intY = math.floor( y );
	local fractionalY = y - intY;
	local v1 = smoothed_noise( intX , intY , seed );
	local v2 = smoothed_noise( intX+1 , intY , seed );
	local v3 = smoothed_noise( intX , intY+1 , seed );
	local v4 = smoothed_noise( intX+1 , intY+1 , seed );
	local i1 = cosine_interpolate( v1 , v2 , fractionalX );
	local i2 = cosine_interpolate( v3 , v4 , fractionalX );
	return cosine_interpolate( i1 , i2 , fractionalY );
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 外部函数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

----------------------------------------------------------------
-- x 横坐标 , int
-- y 纵坐标 , int
----------------------------------------------------------------
local function Get( self , x , y )
	x = x / self.size
	y = y / self.size
	
	local total = 0
	for i = 0 , self.octaves-1 , 1 do
		local frequency = math.pow( 2 , i );
		total = total + interpolated_noise( x*frequency , y*frequency , self.seed ) * math.pow( self.persistence , i )
	end
	return total
end

----------------------------------------------------------------
-- seed 种子 , int  , 不同的种子会有不同的模型
-- octaves 倍频 , int , 值越大 , 波动越频繁
-- persistence 持续度 , double , 值越大 , 频率越高 , 变化越尖锐
-- size 大小 , double , 值越大 , 单位距离返回值的变化速度越慢
----------------------------------------------------------------
function SINoise.New( seed , octaves , persistence , size )
	return
	{
		seed = seed ,
		octaves = octaves ,
		persistence = persistence ,
		size = size ,
		Get = Get
	}
end

return SINoise