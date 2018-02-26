using SimpleFEMJulia
tic()
l = create_line(0,2)
element = BAR2N()
mesh = create_mesh(l,element,0.25)
set1 = dirichlet_bc(mesh.ndofs,[1],[1.0])
last_node = mesh.nnodes
set2 = neumann_bc([last_node],[1.3])
fem_sys = initialize_femsystem(mesh.ndofs, set1.ndof_dir_bc)
diffusion_data = ones(mesh.ndofs,)
field1 = scalar_field("diffusion",diffusion_data)


update_femsystem!(mesh, element, field1, fem_sys)


source_data = 3*ones(mesh.ndofs,)
field2 = scalar_field("source",source_data)
update_femsystem!(mesh, element, field2, fem_sys)


dirichlet_bc!(fem_sys, set1)
neumann_bc!(fem_sys, set2)

u = solve(fem_sys)

#display(plot!(mesh.x[:,1],u))
#println(u)
toc()
