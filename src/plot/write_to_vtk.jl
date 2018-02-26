using WriteVTK

function write_sol_to_vtk(elem::QUAD4N,msh::Mesh,u::Vector{Float64},field_name::String,file_name::String)
    #Write solution for 4-node quads into vtk format
    nnodes = msh.nnodes
    nelems = msh.nelems
    t = msh.t
    x = msh.x
    cell_type = VTKCellTypes.VTK_QUAD
    cells = MeshCell[]

    for i=1:nelems
        c = MeshCell(cell_type, t[i,:])
        push!(cells,c)
    end

    vtkfile = vtk_grid(file_name, x', cells)
    vtk_point_data(vtkfile, u, field_name)
    vtk_save(vtkfile)
end

function write_sol_to_vtk(elem::TRI3N,msh::Mesh,u::Vector{Float64},field_name::String,file_name::String)
    #Write solution for 3-node triangles into vtk format
    nnodes = msh.nnodes
    nelems = msh.nelems
    t = msh.t
    x = msh.x
    cell_type = VTKCellTypes.VTK_TRIANGLE
    cells = MeshCell[]

    for i=1:nelems
        c = MeshCell(cell_type, t[i,:])
        push!(cells,c)
    end

    vtkfile = vtk_grid(file_name, x', cells)
    vtk_point_data(vtkfile, u, field_name)
    vtk_save(vtkfile)
end

function write_msh_to_vtk(elem::QUAD4N,msh::Mesh,file_name::String)

    nnodes = msh.nnodes
    nelems = msh.nelems
    t = msh.t
    x = msh.x
    cell_type = VTKCellTypes.VTK_QUAD
    cells = MeshCell[]

    for i=1:nelems
        c = MeshCell(cell_type, t[i,:])
        push!(cells,c)
    end

    vtkfile = vtk_grid(file_name, x', cells)
    vtk_save(vtkfile)
end

function write_msh_to_vtk(elem::TRI3N,msh::Mesh,file_name::String)
    #Write mesh for 3-node triangles into vtk format
    nnodes = msh.nnodes
    nelems = msh.nelems
    t = msh.t
    x = msh.x
    cell_type = VTKCellTypes.VTK_TRIANGLE
    cells = MeshCell[]

    for i=1:nelems
        c = MeshCell(cell_type, t[i,:])
        push!(cells,c)
    end

    vtkfile = vtk_grid(file_name, x', cells)
    vtk_save(vtkfile)
end
