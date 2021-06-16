function math.Range( num , min , max )
	return math.max( math.min( num , max ) , min )
end

function math.Cnum( num , min , max )
	return math.Range( math.floor( num ) , min , max )
end