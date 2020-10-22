if not date then date = {} end

date.ticksPerDay = SINumbers.ticksPerDay
date.ticksPerHalfDay = SINumbers.ticksPerHalfDay

function date.FormatDateByTick( tick )
	local d , t = math.modf( tick/date.ticksPerDay )
	local h , m = math.modf( t*24 )
	return ( "%u-%02u:%02u" ):format( d+1 , h , math.floor( m*60 ) )
end