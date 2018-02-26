type QUAD4N <: Dim2
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

function QUAD4N()
    ename = "QUAD4N"
    dim = 2
    nnodes = 4
    ngp = 4
    (zgp,wgp) = gauss_quad(ngp)
    eta = zgp[1,:]
    xi = zgp[2,:]
    coef = [-1 -1; 1 -1; 1 1; -1 1]

    N = zeros(nnodes,ngp)
    N[1,:] = 1/4*(1+xi*coef[1,1]).*(1+eta*coef[1,2])
    N[2,:] = 1/4*(1+xi*coef[2,1]).*(1+eta*coef[2,2])
    N[3,:] = 1/4*(1+xi*coef[3,1]).*(1+eta*coef[3,2])
    N[4,:] = 1/4*(1+xi*coef[4,1]).*(1+eta*coef[4,2])

    Nx = zeros(nnodes,ngp)
    Nx[1,:] = coef[1,1]/4*(1+eta*coef[1,2])
    Nx[2,:] = coef[2,1]/4*(1+eta*coef[2,2])
    Nx[3,:] = coef[3,1]/4*(1+eta*coef[3,2])
    Nx[4,:] = coef[4,1]/4*(1+eta*coef[4,2])

    Ny = zeros(nnodes,ngp)
    Ny[1,:] = coef[1,2]/4*(1+xi*coef[1,1])
    Ny[2,:] = coef[2,2]/4*(1+xi*coef[2,1])
    Ny[3,:] = coef[3,2]/4*(1+xi*coef[3,1])
    Ny[4,:] = coef[4,2]/4*(1+xi*coef[4,1])

    Nxx = zeros(nnodes,ngp)
    Nxy = zeros(nnodes,ngp)
    Nxy[1,:] = 1/4*coef[1,1]*coef[1,2]*ones(1,ngp)
    Nxy[2,:] = 1/4*coef[1,1]*coef[1,2]*ones(1,ngp)
    Nxy[3,:] = 1/4*coef[1,1]*coef[1,2]*ones(1,ngp)
    Nxy[4,:] = 1/4*coef[1,1]*coef[1,2]*ones(1,ngp)
    Nyx = Nxy
    Nyy = zeros(nnodes,ngp)

    QUAD4N(ename,dim,nnodes,ngp,
               zgp,wgp,N,Nx,Ny,Nxx,Nxy,Nyx,Nyy)
end

#=
function jacobian(element::QUAD4N, Xe::Matrix{Float64}, ig::Int64)
    Nx = element.Nx
    Ny = element.Ny
    J = [Nx[:,ig]'*Xe[1,:] Nx[:,ig]'*Xe[2,:];
         Ny[:,ig]'*Xe[1,:] Ny[:,ig]'*Xe[2,:]]
    detJ = det(J)
    return (J,detJ)
end

function matrix_B(element::QUAD4N, ig::Int64)
    return [element.Nx[:,ig]';
            element.Ny[:,ig]']
end
=#
