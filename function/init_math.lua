function math.Cnum( num , max , min )
	return math.max( math.min( num , max ) , min )
end

function math.Cnum_i( num , max , min )
	return math.Cnum( math.floor( num ) , max , min )
end