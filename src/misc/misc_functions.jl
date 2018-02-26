#should not contain anything but standard types and abstract types
function residual(A :: Matrix{Float64}, B :: Vector{Float64}, u ::Vector{Float64})
    return A*u-B
end

function norm_residual(A :: Matrix{Float64}, B :: Vector{Float64}, u ::Vector{Float64})
    res =  A*u-B
    return norm(res,2)
end

function save_to_file(x :: Matrix{Float64}, u :: Vector{Float64}, name :: String)
    out = [x u]
    writedlm(name, out)
end
