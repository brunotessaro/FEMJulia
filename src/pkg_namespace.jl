# geometry
abstract type Geometry end
type Line <: Geometry
    name :: String
    x1 :: Float64
    x2 :: Float64
end
type Rectangle <: Geometry
    name :: String
    x1 :: Float64
    x2 :: Float64
    y1 :: Float64
    y2 :: Float64
end

#problemtype
abstract type ProblemType end
type Thermal <: ProblemType end

#elements
abstract type Element end
abstract type Dim1 <: Element end
abstract type Dim2 <: Element end
abstract type Dim3 <: Element end
type SAMPLE <: Dim2
    ename :: String                 #name of the element
    dim :: Int64                    #space dim
    nnodes :: Int64                 #number of nodes in element
    ngp :: Int64                    #number of gauss points
    zgp :: Matrix{Float64}          #location of gp
    wgp :: Vector{Float64}          #weights of gp
    N :: Matrix{Float64}            #shape functions evaluated at gp
    Nx :: Matrix{Float64}           #derivatives of N at gp
    Ny :: Matrix{Float64}
    Nxx :: Matrix{Float64}
    Nxy :: Matrix{Float64}
    Nyx :: Matrix{Float64}
    Nyy :: Matrix{Float64}
end

#mesh related
type Mesh
    # Complete mesh information
    x :: Matrix{Float64}
    t :: Array{Int64,2}
    nnodes :: Int64
    nodeperelem :: Int64
    ndofs :: Int64
    nelems :: Int64
    ename :: String
    Mesh(x,t,nnodes,nodeperelem,ndofs,nelems,ename) =
    new(x,t,nnodes,nodeperelem,ndofs,nelems,ename)
end

#field related
abstract type Field end
type ScalarField <: Field
    # Contain source, diffusions coeffs etc
    name :: String
    nval :: Vector{Float64}
    ScalarField(name, nval) = new(name, nval)
end

#fem system related
type FEMSystem
    # Ax = B including Dirichlet BC (lagrange)
    A :: Matrix{Float64}
    B :: Vector{Float64}
    ndof :: Int64
    ndof_dir_bc :: Int64
    FEMSystem(A,B,ndof,ndof_dir_bc) = new(A,B,ndof,ndof_dir_bc)
end

#BC related
abstract type BC end
type DirichletBC <: BC
    # Lagrange matrices for dirichlet BC
    nset :: Array{Int64,1}
    A_bc :: Array{Int64,2}
    B_bc :: Vector{Float64}
    ndof_dir_bc :: Int64
    DirichletBC(nset,A_bc,B_bc,ndof_dir_bc) = new(nset,A_bc,B_bc,ndof_dir_bc)
end
type NeumannBC <: BC
    # Set of nodes and values
    nset :: Array{Int64,1}
    nval :: Vector{Float64}
    NeumannBC(nset, nval) = new(nset,nval)
end
