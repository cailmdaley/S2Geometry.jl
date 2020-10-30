using S2Geometry, PyCall, Cxx
using Plots

hp = pyimport("healpy")
py"""
from spt3g.lensing.map_spec_utils import get_camb_lensedcl
"""

function st2θϕ(face, s, t)
    i, j = icxx"S2::STtoIJ($s);", icxx"S2::STtoIJ($t);"
    latlng = icxx"S2CellId::FromFaceIJ($face, $i, $j).ToLatLng();"
    θ, ϕ = icxx"$latlng.lat().radians();" + π/2, icxx"$latlng.lng().radians();" + π
end

function healpix_to_cube(healpix_map, cube_Nside)
    faces = [zeros(cube_Nside, cube_Nside) for i in 1:6]
    st_range = range(0, 1, length=cube_Nside)
    for face in 1:6
        for j in 1:cube_Nside, i in 1:cube_Nside
            s, t = st_range[j], st_range[i]
            faces[face][i,j] = hp.get_interp_val(healpix_map, st2θϕ(face, s, t)...)
        end
    end
    faces
end

healpix_Nside, face_Nside = 256, 512
healpix_map = hp.synfast(py"get_camb_lensedcl()['TT']", healpix_Nside)
faces = healpix_to_cube(healpix_map, face_Nside)

for face in 1:6
    heatmap(faces[face], aspect_ratio=:equal, framestyle=:none, margin=-0.2Plots.cm,
            cbar=false, ticks=false, size=(700, 700))
    savefig("example/plots/face$face.png")
end
