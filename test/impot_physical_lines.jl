using SimpleFEMJulia

filename = "test/gmsh_sample_mesh/test1.msh"

corner_nodes = gmsh_get_corner_nodes(filename)

edge_nodes = gmsh_get_edge_nodes(filename)

e1 = TRI3N()
m1 = gmsh_get_mesh(filename,e1)
