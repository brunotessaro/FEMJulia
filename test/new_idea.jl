#=
N = [N1; N2; N3] = Vector{Float64}(nN)

Matrix{Float64}(nDim,nN)
dN = [  dN1/dxi dN2/dxi dN3/dxi ...
        dN1/deta dN2/deta ....
        dN1/dzeta .....
        ]

dN[:,1] = derivatives of shape function 1 at this gp

Jinv = Matrix{Float64}(nDim,nDim)

B = Matrix{Float64}

=#
#=
abstract type BAR2N end
abstract type Thermal end

function N(elem::BAR2N,ig::Int64)
    xi = z[ig]
    N[1] = (1+xi)/2
    N[2] = (1-xi)/2
end

function dN(elem::BAR2N,ig::Int64)
    xi = z[ig]
    dN = [0.5 -0.5; 0 0; 0 0;]
end

function Jinv(elem::BAR2N,ig::Int64)
    #return J, detJ, Jinv
end

function Ke(pb::Thermal,elem::BAR2N,ig::Int64,Jinv::Matrix{Float64},dN::Matrix{Float64},K::Matrix{Float64},D::Matrix{Float64})
    dNdX[:,1] = Jinv*dN[:,1] #loop over 1
    B = dNdX
    K += B'*D*B*detJ*w[ig]
end

function Me(pb::Thermal,elem::BAR2N,ig::Int64,Jinv::Matrix{Float64},dN::Matrix{Float64},M::Matrix{Float64},D::Matrix{Float64})
    M += N'*D*N
end
=#

N = rand(2,3,4)
