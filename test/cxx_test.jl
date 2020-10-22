ll = @cxx S2LatLng::FromDegrees(10,20)
p = @cxx ll -> ToPoint()

coords = rand(2,10)
index = @cxx S2PointIndex{int64}()
for (i, latlng) in enumerate(eachcol(coords))
	point = @cxx (@cxx S2LatLng::FromDegrees(latlng...)) -> ToPoint()
	@cxx index -> Add(point, i)
end

query = @cxx S2ClosestPointQuery{int64}()
icxx"S2ClosestPointQuery<int> query(&$(index));"
typeof(index)

@cxx (@cxx query -> index()) -> Add(point, 1)
@cxx index -> Add(point, i)



index
typeof()
@cxx index -> num_points()
Array([1 1 ; 1 1])
it = @cxxnew S2PointIndex{int64}::Iterator(index)

function s2point_index()


x = @cxx S2LatLng::
x
foo = @cxxnew S2LatLng()
foo.

cxxt"S2LatLng"
ll

typeof(ll)
	
@cxx ll::ToStringInDegrees()
icxx"$l.lat();"
	
