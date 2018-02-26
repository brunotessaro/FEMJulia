# solver related functions

function solve(femsys::FEMSystem)
     u = femsys.A\femsys.B
     sol = u[1:femsys.ndof]
     return sol
end
