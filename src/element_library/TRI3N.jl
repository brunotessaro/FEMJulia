type TRI3N <: Dim2
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

function TRI3N()
    ename = "TRI3N"
    dim = 2
    nnodes = 3
    ngp = 3
    (zgp,wgp) = gauss_triang(ngp)
    eta = zgp[1,:]
    xi = zgp[2,:]

    N = zeros(3,ngp)
    N[1,1:ngp] = 1-eta-xi
    N[2,1:ngp] = eta
    N[3,1:ngp] = xi

    Nx = zeros(3,ngp)
    Nx[1,1:ngp] = 1-xi
    Nx[2,1:ngp] = 1
    Nx[3,1:ngp] = 0

    Ny = zeros(3,ngp)
    Ny[1,1:ngp] = 1-eta
    Ny[2,1:ngp] = 0
    Ny[3,1:ngp] = 1

    Nxx = zeros(3,ngp)
    Nxy = zeros(3,ngp)
    Nxy[1,1:ngp] = -1
    Nyx = Nxy
    Nyy = zeros(3,ngp)

    TRI3N(ename,dim,nnodes,ngp,
              zgp,wgp,N,Nx,Ny,Nxx,Nxy,Nyx,Nyy)
end

#=
function jacobian(element::TRI3N, Xe::Matrix{Float64}, ig::Int64)
    J = [-Xe[1,1]+Xe[1,2] -Xe[2,1]+Xe[2,2];
         -Xe[1,1]+Xe[1,3] -Xe[2,1]+Xe[2,3]]
    detJ = det(J)
    return (J,detJ)
end

function matrix_B(element::TRI3N, ig::Int64)
    return [element.Nx[:,ig]';
            element.Ny[:,ig]']
end
=#
