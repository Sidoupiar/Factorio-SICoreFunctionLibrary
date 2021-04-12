-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local SIBit =
{
	_VERSION     = "SIBit.lua 1.0.0" ,
	_DESCRIPTION = "Noise function in Lua (5.2.1, LuaJIT)" ,
	_URL         = "https://github.com/Sidoupiar/Lua-SIBit.lua" ,
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
-- ---------- 内部函数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function BitToNumber( tbl )
	local result = 0
	local power = 1
	for i = 1 , #tbl do
		result = result + tbl[i] * power
		power = power * 2
	end
	return result
end

local function Expand( t1 , t2 )
	local big , small = t1 , t2
	if #big < #small then big , small = small , big end
	for i = #small + 1 , #big do small[i] = 0 end -- 扩展 small
end

local ToBits -- 需要在 SIBit.Not 前面定义

-- ------------------------------------------------------------------------------------------------
-- ---------- 外部函数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIBit.Not( n )
	local tbl = ToBits( n )
	local size = math.max( #tbl , 32 )
	for i = 1 , size do
		if tbl[i] == 1 then tbl[i] = 0
		else tbl[i] = 1 end
	end
	return BitToNumber( tbl )
end

function SIBit.Or( m , n )
	local tbl_m = ToBits( m )
	local tbl_n = ToBits( n )
	Expand( tbl_m , tbl_n )
	
	local tbl = {}
	for i = 1 , #tbl_m do
		if tbl_m[i]== 0 and tbl_n[i] == 0 then tbl[i] = 0
		else tbl[i] = 1 end
	end
	return BitToNumber( tbl )
end

function SIBit.And( m , n )
	local tbl_m = ToBits( m )
	local tbl_n = ToBits( n )
	Expand( tbl_m , tbl_n )
	
	local tbl = {}
	for i = 1 , #tbl_m do
		if tbl_m[i]== 0 or tbl_n[i] == 0 then tbl[i] = 0
		else tbl[i] = 1 end
	end
	return BitToNumber( tbl )
end

function SIBit.XOr( m , n )
	local tbl_m = ToBits( m )
	local tbl_n = ToBits( n )
	Expand( tbl_m , tbl_n )
	
	local tbl = {}
	for i = 1 , #tbl_m do
		if tbl_m[i] ~= tbl_n[i] then tbl[i] = 1
		else tbl[i] = 0 end
	end
	return BitToNumber( tbl )
end

function SIBit.RShift( n , bits )
	local high_bit = 0
	if n < 0 then
		-- 负数
		n = SIBit.Not( math.abs( n ) ) + 1
		high_bit = 0x80000000
	end
	
	local floor = math.floor
	for i = 1 , bits do
		n = n / 2
		n = SIBit.Or( floor( n ) , high_bit )
	end
	return floor( n )
end

function SIBit.LShift( n , bits )
	if n < 0 then n = SIBit.Not( math.abs( n ) ) + 1 end -- 负数
	for i = 1 , bits do n = n * 2 end
	return SIBit.And( n , 0xFFFFFFFF )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 补充定义 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 定义上面的 ToBits 函数
ToBits = function( n )
	if n < 0 then return ToBits( SIBit.Not( math.abs( n ) )+1 ) end -- 负数
	-- to bits table
	local tbl = {}
	local cnt = 1
	local last
	while n > 0 do
		last     = n % 2
		tbl[cnt] = last
		n        = (n-last)/2
		cnt      = cnt + 1
	end
	return tbl
end

return SIBit