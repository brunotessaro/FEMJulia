function dirichlet_bc(ndof::Int64, nset::Array{Int64,1}, nval::Array{Float64})
    # create a structure of dirichlet BC
    ndof_dir_bc = size(nset,1)

    A_bc = zeros(ndof_dir_bc,ndof)

    A_bc[:,nset] = eye(ndof_dir_bc)

    B_bc = zeros(ndof_dir_bc,)
    B_bc = nval

    obj = DirichletBC(nset, A_bc, B_bc, ndof_dir_bc)
    return obj
end

function neumann_bc(nset::Array{Int64,1}, nval::Array{Float64,1})
    obj = NeumannBC(nset,nval)
    return obj
end

function apply_bc!(femsys::FEMSystem, bc::DirichletBC)
    ndof_dir_bc = bc.ndof_dir_bc
    ndof = femsys.ndof

    femsys.A[ndof+1:end,1:ndof] = bc.A_bc
    femsys.A[1:ndof,ndof+1:end] = bc.A_bc'

    femsys.B[ndof+1:end,1] = bc.B_bc
end

function apply_bc!(femsys::FEMSystem, bc::NeumannBC)
    femsys.B[bc.nset] += bc.nval
end
