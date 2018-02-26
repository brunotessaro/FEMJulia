

function create_mesh(geom::Line,element::BAR2N,esize::Float64)
    xmax = geom.x2
    xmin = geom.x1
    nelems = Int(ceil((xmax-xmin)/esize))
    nnodes = nelems + 1
    nodeperelem = 2
    ename = element.ename
    ndofs = nnodes

    x = zeros(Float64,nnodes,3)
    t = zeros(Int64,nelems,nodeperelem)

    x[:,1] = linspace(xmin,xmax,nnodes)
    t[:,1] = 1:nnodes-1
    t[:,2] = 2:nnodes

    return Mesh(x, t, nnodes, nodeperelem, ndofs, nelems, ename)
end

function create_mesh(geom::Line,element::BAR3N,esize::Float64)
    xmax = geom.x2
    xmin = geom.x1
    nelems = Int(ceil((xmax-xmin)/esize))
    nnodes = 2*nelems + 1
    nodeperelem = 3
    ename = "BAR1D3N"
    dim = 1
    ndofs = nnodes

    x = zeros(Float64,nnodes,3)
    t = zeros(Int64,nelems,nodeperelem)

    x[:,1] = linspace(xmin,xmax,nnodes)
    t[:,1] = 1:2:nnodes-2
    t[:,2] = 2:2:nnodes-1
    t[:,3] = 3:2:nnodes

    meshobj = Mesh(x, t, nnodes, ndofs, nelems, nodeperelem, ename)
    return meshobj
end

function create_mesh(geom::Rectangle,element::QUAD4N,esize::Float64)
    xmax = geom.x2
    xmin = geom.x1
    ymax = geom.y2
    ymin = geom.y1
    nelems_x = Int(ceil((xmax-xmin)/esize))
    nelems_y = Int(ceil((ymax-ymin)/esize))
    nnodes_x = nelems_x+1
    nnodes_y = nelems_y+1

    nelems = nelems_x*nelems_y
    nnodes = nnodes_x*nnodes_y

    ename = element.ename
    nodeperelem = 4
    dim = 2
    ndofs = nnodes

    x = zeros(Float64,nnodes,3)
    t = zeros(Int64, nelems, nodeperelem)

    X = linspace(xmin,xmax,nnodes_x)
    Y = linspace(ymin,ymax,nnodes_y)

    nodenum = 1
    for i = 1:nnodes_y
        for j = 1:nnodes_x
            x[nodenum,1] = X[j]
            x[nodenum,2] = Y[i]
            nodenum += 1
        end
    end
    #logic: start with first elem, bottom-left (base_nodes)
    # when moving right, indices of next elem increase by 1
    # when moving up, indices of next elem increase by nnodes_x
    elemnum = 1
    for i = 1:nelems_y
        for j = 1:nelems_x
            base_nodes = [1, 2, nnodes_x+2, nnodes_x+1]
            t[elemnum,:] = base_nodes + j-1 + (i-1)*nnodes_x
            elemnum = elemnum + 1
        end
    end
    return Mesh(x, t, nnodes, ndofs, nelems, nodeperelem, ename)
end
