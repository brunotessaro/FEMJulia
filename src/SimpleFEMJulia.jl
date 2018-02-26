__precompile__()

module SimpleFEMJulia

#load namespace of package
include("pkg_namespace.jl")

#Misc "independent" files
include("misc/misc_functions.jl")
export residual, norm_residual, save_to_file

#Geometry related
include("geometry/basic_geom.jl")
export create_line, create_rectangle

#ProblemType related
include("problemtype/problem_type.jl")
export thermal, structural_plane_stress, structural_plane_strain,
quasi_static, transient

#element related
include("element_library/gauss_integration.jl")
# Adding element library
include("element_library/BAR2N.jl")
export BAR2N, matrix_B
include("element_library/BAR3N.jl")
export BAR3N, matrix_B
include("element_library/TRI3N.jl")
export TRI3N, matrix_B
include("element_library/QUAD4N.jl")
export QUAD4N, matrix_B

#mesh related
include("mesh/create_mesh.jl")
export create_mesh
include("mesh/import_mesh.jl")
export gmsh_get_corner_nodes, gmsh_get_edge_nodes, gmsh_get_mesh
export gmsh_get_physical_lines

#field related
include("fem/field.jl")
export scalar_field

#fem system related
include("fem/jacobian.jl")
export jacobian, get_dN
include("fem/fem_system.jl")
export initialize_femsystem, update_femsystem!

#BC related
include("fem/bc.jl")
export dirichlet_bc, neumann_bc, apply_bc

#solver related
include("solver/solver.jl")
export solve

#plot related
include("plot/plot.jl")
export plot_mesh_2D
include("plot/write_to_vtk.jl")
export write_sol_to_vtk, write_msh_to_vtk


end
