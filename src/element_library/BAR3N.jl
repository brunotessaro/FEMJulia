type BAR3N <: Dim1
    ename :: String                 #name of the element
    dim :: Int64                    #space dim
    nnodes :: Int64                 #number of nodes in element
    ngp :: Int64                    #number of gauss points
    zgp :: Vector{Float64}          #location of gp
    wgp :: Vector{Float64}          #weights of gp
    N :: Matrix{Float64}            #shape functions evaluated at gp
    Nx :: Matrix{Float64}           #derivatives of N at gp
end

function BAR3N()
    ename = "BAR3N"
    dim = 1
    nnodes = 3
    ngp = 2
    (zgp,wgp) = gauss_bar(ngp)
    N = zeros(3,ngp)
    N[1,:] = 1/2*zgp.*(zgp-1)
    N[2,:] = 1-zgp.^2
    N[3,:] = 1/2*zgp.*(zgp+1)
    Nx = zeros(3,ngp)
    Nx[1,:] = zgp-1/2
    Nx[2,:] = -2*zgp
    Nx[3,:] = zgp+1/2
    BAR3N(ename,dim,nnodes,ngp,zgp,wgp,N,Nx)
end

#=
function jacobian(element::BAR3N, Xe::Vector{Float64},ig::Int64)
    J = (Xe[1,3] - Xe[1,1])/2
    detJ = det(J)
    return (J,detJ)
end

function matrix_B(element::BAR3N, ig::Int64)
    return element.Nx[:,ig]';
end
=#
