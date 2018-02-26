# Generates FEM Matrices
# input = mat_list (mass/stiffness/convection etc)

# diffusion = nu dN/dx dN/dx
# convection = N v dN/dx
# reaction = N sigma N

# coefficient contains the field of respective operator, 0 array would mean
# it will not be calculated
# fields are stored at nodes



function initialize_femsystem(ndof_mesh, ndof_dir_bc)
    # intializes zeros in A and B
    ndof_total = ndof_mesh + ndof_dir_bc
    A = zeros(ndof_total,ndof_total)
    B = zeros(ndof_total,)
    sysobj = FEMSystem(A,B,ndof_mesh,ndof_dir_bc)
    return sysobj
end

function update_femsystem!(mesh::Mesh, element::Element, scalar_field::ScalarField, femsys::FEMSystem)
    # adds the matrix to the FEM system (updates in the memory)
    A = femsys.A
    B = femsys.B
    for elemnum=1:1:mesh.nelems
        Te = mesh.t[elemnum,:]
        local_field = get_field_local(mesh::Mesh, scalar_field::ScalarField, elemnum)
        (Ae,Be) = element_system(mesh::Mesh, element::Element, femsys::FEMSystem, local_field::ScalarField, elemnum)
        #assembly
        A[Te,Te] = A[Te,Te] + Ae
        B[Te] = B[Te] + Be
    end
end

function element_system(mesh::Mesh, element::Element, femsys::FEMSystem, local_field::ScalarField, elemnum)
    # calculates the element level stuff
    nodeperelem = mesh.nodeperelem
    Ae = zeros(nodeperelem, nodeperelem)
    Be = zeros(nodeperelem,)

    ngp = element.ngp
    w = element.wgp

    dim = element.dim
    nnodes = mesh.nnodes

    Te = mesh.t[elemnum,:]
    Xe = zeros(Float64,nodeperelem,3)
    Xe  = mesh.x[Te,:]

    for ig=1:1:ngp
        Nig = element.N[:,ig]
        (J,Jinv,Jdet) = jacobian(element, Xe, ig)
        field_ig = get_field_gp(local_field, Nig)

        dv = Jdet*w[ig]

        Ae = Ae + op_diffusion(element,ig,Jinv,field_ig) * dv
    end
    return (Ae,Be)
end


#=
function element_system(mesh::Mesh, element::Element, femsys::FEMSystem, local_field::ScalarField, elemnum)
    # calculates the element level stuff
    nodeperelem = mesh.nodeperelem
    Ae = zeros(nodeperelem, nodeperelem)
    Be = zeros(nodeperelem,)

    ngp = element.ngp
    w = element.wgp

    dim = element.dim
    nnodes = mesh.nnodes

    Te = mesh.t[elemnum,:]
    Xe = zeros(Float64,nodeperelem,3)
    Xe  = mesh.x[Te,:]

    for ig=1:1:ngp
        (J,Jinv,Jdet) = jacobian(element, Xe, ig)

        Nig = element.N[:,ig]

        deriv = zeros(Float64,dim,nodeperelem)

        deriv[1,:] = element.Nx[:,ig]
        deriv[2,:] = element.Ny[:,ig]

        transform = J\deriv
        Nxig = transform[1,:]
        Nyig = transform[2,:]
        dv = detJ*w[ig]

        field_gp = get_field_gp(local_field::ScalarField, Nig)

        if local_field.name == "mass"
            Ae = Ae + field_gp * (Nig*Nig')*dv
        elseif local_field.name == "diffusion"
            Ae = Ae + field_gp * (Nxig*Nxig'+Nyig*Nyig')*dv
        elseif local_field.name == "convection"
            Ae = Ae + field_gp * (Nig*Nxig')'*dv
        elseif local_field.name == "source"
            Be = Be + field_gp * Nig*dv
        else
            error("invalid field name, no operation defined for FEM Matrices")
        end

    end
    return (Ae,Be)
end
=#
