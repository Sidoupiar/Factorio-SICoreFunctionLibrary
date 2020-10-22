need( "sidata" )
need( "sinumbers" )
need( "siflags" )
need( "sitypes" )
need( "sicolors" )
need( "simods" )

SIEvents = {}
for k , v in pairs( defines.events ) do SIEvents[k] = v end

SIOrderList = { "a" , "b" , "c" , "d" , "e" , "f" , "g" , "h" , "i" , "j" , "k" , "l" , "m" , "n" , "o" , "p" , "q" , "r" , "s" , "t" , "u" , "v" , "w" , "x" , "y" , "z" }
SIOrderListSize = #SIOrderList