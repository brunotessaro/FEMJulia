function get_dN(element::Dim1, ig::Int64)
    dN = element.Nx[:,ig]
end

function get_dN(element::Dim2, ig::Int64)
    dN = [element.Nx[:,ig] element.Ny[:,ig]]
end

function get_dN(element::Dim3, ig::Int64)
    dN = [element.Nx[:,ig] element.Ny[:,ig] element.Nz[:,ig]]
end

function jacobian(element::Element, Xe::Matrix{Float64}, ig::Int64)
    # Xe = Matrix{Float64}(nodeperelem,3)
    dN = get_dN(element,ig)
    dimXe = Xe[:,1:element.dim]
    J = zeros(element.dim,element.dim)
    J = dimXe'*dN

    Jmat = J[:,:]
    
    # the above statement is when there is product of 1xN and Nx1 matrix
    # stupid Julia, creates a vector of size 1, instead of a matrix of size
    # [1,1]. So the above lines does that job

    Jinv = inv(Jmat)
    detJ = det(Jmat)
    return (Jmat,Jinv,detJ)
end
