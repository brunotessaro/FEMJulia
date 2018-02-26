type BAR2N <: Dim1
    ename :: String                 #name of the element
    dim :: Int64                    #space dim
    nnodes :: Int64                 #number of nodes in element
    ngp :: Int64                    #number of gauss points
    zgp :: Vector{Float64}          #location of gp
    wgp :: Vector{Float64}          #weights of gp
    N :: Matrix{Float64}            #shape functions evaluated at gp
    Nx :: Matrix{Float64}           #derivatives of N at gp
end

function BAR2N()
    ename = "BAR2N"
    dim = 1
    nnodes = 2
    ngp = 2
    (zgp,wgp) = gauss_bar(ngp)
    N = zeros(2,ngp)
    N[1,:] = (1-zgp)/2
    N[2,:] = (zgp+1)/2
    Nx = [-1/2*ones(Float64,1,ngp); 1/2*ones(Float64,1,ngp)]
    BAR2N(ename,dim,nnodes,ngp,zgp,wgp,N,Nx)
end

function op_diffusion(element::BAR2N,ig::Int64,Jinv,field_ig::Float64)
    Nx = Jinv*element.Nx[:,ig]
    B = Nx'
    return B'*field_ig*B
end



#=
function jacobian(element::BAR2N, Xe::Vector{Float64},ig::Int64)
    J = (Xe[1,2] - Xe[1,1])/2
    detJ = det(J)
    return (J,detJ)
end

function matrix_B(element::BAR2N, ig::Int64)
    return element.Nx[:,ig]';
end
=#
