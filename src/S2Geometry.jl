module S2Geometry
__precompile__(false)

using Reexport

@reexport using Cxx, Cxx.CxxCore
using Libdl

Libdl.dlopen("/s2geometry/build/libs2.so", Libdl.RTLD_GLOBAL)
Libdl.dlopen("/usr/lib/x86_64-linux-gnu/libgflags.so", Libdl.RTLD_GLOBAL)
Libdl.dlopen("/usr/lib/x86_64-linux-gnu/libglog.so", Libdl.RTLD_GLOBAL)

cxx""" 
	#include <iostream>
	#include "s2/s2latlng.h"
	#include "s2/s2closest_cell_query.h"
	#include "s2/s2cell_index.h"
	#include "s2/value_lexicon.h"
	"""
	
################################################################################
# Show functions
################################################################################

const LatLng = cxxt"S2LatLng"
function Base.show(io::IO, ll::LatLng)
	lat, lng = icxx"$ll.lat().degrees();", icxx"$ll.lng().degrees();"
	print(io, "S2LatLng: ($lat, $lng)")
end

const Point = cxxt"S2Point"
function Base.show(io::IO, p::Point)
	print(io, "S2Point: ($(@cxx p->x()), $(@cxx p->y()), $(@cxx p->z())")
end
function Base.show(io::IO, id::cxxt"S2CellId") 
	print(io, "S2CellId $(@cxx id -> id())")
end


function Base.show(io::IO, index::cxxt"S2CellIndex*") 
	print(io, "(S2CellIndex *)[$(@cxx index -> num_cells())]")
end
function Base.show(io::IO, index::cxxt"S2CellIndex") 
	print(io, "S2CellIndex[$(@cxx index -> num_cells())]")
end
function Base.show(io::IO, lexicon::cxxt"ValueLexicon<$T>*" where T) 
	print(io, "(ValueLexicon *)[$(@cxx lexicon -> size())]")
end
function Base.show(io::IO, lexicon::cxxt"ValueLexicon<$T>" where T) 
	print(io, "ValueLexicon[$(@cxx lexicon -> size())]")
end

function Base.show(io::IO, index::cxxt"S2CellIndex::CellIterator*") 
	print(io, "S2CellIndex::CellIterator *, done = $(@cxx index -> done())")
end
function Base.show(io::IO, index::cxxt"S2CellIndex::CellIterator") 
	print(io, "S2CellIndex::CellIterator, done = $(@cxx index -> done())")
end

function Base.show(io::IO, query::cxxt"S2ClosestCellQuery*") 
	print(io, "S2ClosestCellQuery*")
end
function Base.show(io::IO, query::cxxt"S2ClosestCellQuery") 
	print(io, "S2ClosestCellQuery")
end

end  # module S2Geometry
