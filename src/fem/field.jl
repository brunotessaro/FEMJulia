# field is input by user, for example, ν distribution in case of thermal problems
# or say D matrix in case of structural problems,
# condition it should be defined on all nodes in the domain.




function scalar_field(name::String, nval::Array{Float64,1})
    obj = ScalarField(name,nval)
    return obj
end

function get_field_local(mesh::Mesh, scalar_field::ScalarField, elemnum)
    # returns the local element level vector of various fields
    Te = mesh.t[elemnum,:]
    nval = scalar_field.nval[Te]
    field_local_obj = ScalarField(scalar_field.name, nval)
    return field_local_obj
end


function get_field_gp(local_field::ScalarField, Nig)
    # returns the value of a vector data interpolated at gp
    return local_field.nval'*Nig
end
