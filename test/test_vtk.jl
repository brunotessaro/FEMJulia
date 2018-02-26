using SimpleFEMJulia

# Test quads
x1 = 0; x2 = 1; y1 = 0; y2 = 1

geo = create_rectangle(x1,x2,y1,y2)
elem = QUAD4N()
size = 0.5
msh = create_mesh(geo, elem, size)
out_name = "vtk_samples/msh_quad"
write_msh_to_vtk(elem, msh, out_name)

field_name = "Temp"
out_name = "vtk_samples/sol_quad"
u = randn(msh.nnodes,)
write_sol_to_vtk(elem, msh, u, field_name, out_name)

# Test triangles
elem = TRI3N()
input_msh = "gmsh_sample_mesh/test1.msh"
msh = gmsh_get_mesh(input_msh, elem)
write_msh_to_vtk(elem, msh, "vtk_samples/msh_triangle")

field_name = "Temp"
out_name = "vtk_samples/sol_triangles"
u = randn(msh.nnodes,)
write_sol_to_vtk(elem, msh, u, field_name, out_name)
