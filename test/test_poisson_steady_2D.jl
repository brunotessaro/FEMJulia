using SimpleFEMJulia
#using Plots
#pyplot()

tic()
element = QUAD2D4N()
mesh = rectangle_mesh_QUAD2D4N(0,1,0,2,0.5)

dirlt_values = [0.0, 10.0]
dirlt_nodes = [1, 9]

set1 = dirichlet_bc(mesh.ndof, dirlt_nodes, dirlt_values)

set2 = neumann_bc([4],[10.0])

fem_sys = initialize_femsystem(mesh.ndof, set1.ndof_dir_bc)

diffusion_data = ones(mesh.ndof,)
field1 = scalar_field("diffusion",diffusion_data)

update_femsystem!(mesh, element, field1, fem_sys)

source_data = 3*ones(mesh.ndof,)
field2 = scalar_field("source",source_data)
#update_femsystem!(mesh, element, field2, fem_sys)


dirichlet_bc!(fem_sys, set1)
#neumann_bc!(fem_sys, set2)

u = solve(fem_sys)

#display(plot!(mesh.x[:,1],u))
println(u)
toc()
