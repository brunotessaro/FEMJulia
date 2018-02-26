function gmsh_get_corner_nodes(filename::String)
    # logic, if etype in Gmsh is 15 (corner node) then add that node
    # to the set, benefit of set -> element is added to set only if it is not
    # part of the set already, so push all such nodes without worrying about
    # repititions
    # Step2 is to take elements from this set and then put them in a vector

    if !isfile(filename)
        error("Could not locate $filename")
    end

    lines = readlines(open(filename))
    id = 1
    nlines = length(lines)

    while lines[id] != "\$Elements" && id <= nlines
        id += 1
    end

    if id == nlines
        error("No Element Data in $filename")
    end

    id += 2

    node_set = IntSet()

    while lines[id] != "\$EndElements" && id < nlines
        p = split(lines[id])
        if p[2] == "15" #corner :: Gmsh nomenclature
            push!(node_set,parse(Int64,p[end]))
        end
        id += 1
    end

    #convert set into vector

    nodes = zeros(Int64,length(node_set))
    for i = 1:1:length(node_set)
        nodes[i] = pop!(node_set)
    end

    return nodes
end

function gmsh_get_edge_nodes(filename::String)
    # logic, if etype in Gmsh is 15 (corner node) then add that node
    # to the set, benefit of set -> element is added to set only if it is not
    # part of the set already, so push all such nodes without worrying about
    # repititions
    # Step2 is to take elements from this set and then put them in a vector

    if !isfile(filename)
        error("Could not locate $filename")
    end

    lines = readlines(open(filename))
    id = 1
    nlines = length(lines)

    while lines[id] != "\$Elements" && id <= nlines
        id += 1
    end

    if id == nlines
        error("No Element Data in $filename")
    end

    id += 2

    node_set = IntSet()

    while lines[id] != "\$EndElements" && id < nlines
        p = split(lines[id])
        if p[2] == "1" #edge :: Gmsh nomenclature
            push!(node_set,parse(Int64,p[end]))
            push!(node_set,parse(Int64,p[end-1]))
        end
        id += 1
    end

    #convert set into vector

    nodes = zeros(Int64,length(node_set))
    for i = 1:1:length(node_set)
        nodes[i] = pop!(node_set)
    end

    return nodes
end

function gmsh_get_mesh(filename::String,elem::TRI3N)
    # returns the mesh object for TRI3 element
    if !isfile(filename)
        error("Could not locate $filename")
    end

    lines = readlines(open(filename))
    id = 1
    nlines = length(lines)

    while lines[id] != "\$MeshFormat" && id < nlines
        id += 1
    end

    if id == nlines
        error("No MeshFormat in $filename")
    end

    # save mesh format
    id += 1
    mesh_format = lines[id]
    id += 1

    while lines[id] != "\$Nodes" && id < nlines
        id += 1
    end

    if id == nlines
        error("No Nodes Data in $filename")
    end

    # save the number of nodes
    id +=1
    nnodes = parse(Int,lines[id])

    # save nodal data
    x = Matrix{Float64}(nnodes,3)
    for i=1:nnodes
        id += 1
        x[i,:] = float(split(lines[id])[2:end])
    end

    # locate element data
    while lines[id] != "\$Elements" && id < nlines
        id += 1
    end

    if id == nlines
        error("No Element Data in $filename")
    end

    # get elements,
    # this section of gmsh contains, corners, edges and elements
    id +=1
    n_entries = parse(Int,lines[id])

    # count no of corner = c1 /edge = e2 /elements = tri3,quad4...
    n_tri3 = 0

    entry_id = id
    for i = 1:n_entries
        elem_line = lines[entry_id+i]
        p = split(elem_line)[2]
        if p == "2" #tri3 : Gmsh nomenclature
            n_tri3 += 1
        end
    end

    # assign storage for different element types
    t_tri3 = zeros(Int64,n_tri3,3)

    # fill in data
    id_tri3 = 1
    for i = 1:n_entries
        elem_line = lines[entry_id+i]
        p = split(elem_line)
        if  p[2] == "2"
            t_tri3[id_tri3,1] = parse(Int64,p[end-2])
            t_tri3[id_tri3,2] = parse(Int64,p[end-1])
            t_tri3[id_tri3,3] = parse(Int64,p[end])
            id_tri3 += 1
        end
    end
    nelems = n_tri3
    ename = "TRI3N"
    return Mesh(x, t_tri3, nnodes, 3, nnodes, nelems, ename)
end

#= Gmsh Nomenclature taken from http://gmsh.info/doc/texinfo/gmsh.html#MSH-ASCII-file-format
1   2-node line.
2   3-node triangle.
3   4-node quadrangle.
4   4-node tetrahedron.
5   8-node hexahedron.
6   6-node prism.
7   5-node pyramid.
8   3-node second order line (2 nodes associated with the vertices and 1 with the edge).
9   6-node second order triangle (3 nodes associated with the vertices and 3 with the edges).
10  9-node second order quadrangle (4 nodes associated with the vertices, 4 with the edges and 1 with the face).
11  10-node second order tetrahedron (4 nodes associated with the vertices and 6 with the edges).
12  27-node second order hexahedron (8 nodes associated with the vertices, 12 with the edges, 6 with the faces and 1 with the volume).
13  18-node second order prism (6 nodes associated with the vertices, 9 with the edges and 3 with the quadrangular faces).
14  14-node second order pyramid (5 nodes associated with the vertices, 8 with the edges and 1 with the quadrangular face).
15  1-node point.
16  8-node second order quadrangle (4 nodes associated with the vertices and 4 with the edges).
17  20-node second order hexahedron (8 nodes associated with the vertices and 12 with the edges).
18  15-node second order prism (6 nodes associated with the vertices and 9 with the edges).
19  13-node second order pyramid (5 nodes associated with the vertices and 8 with the edges).
20  9-node third order incomplete triangle (3 nodes associated with the vertices, 6 with the edges)
21  10-node third order triangle (3 nodes associated with the vertices, 6 with the edges, 1 with the face)
22  12-node fourth order incomplete triangle (3 nodes associated with the vertices, 9 with the edges)
23  15-node fourth order triangle (3 nodes associated with the vertices, 9 with the edges, 3 with the face)
24  15-node fifth order incomplete triangle (3 nodes associated with the vertices, 12 with the edges)
25  21-node fifth order complete triangle (3 nodes associated with the vertices, 12 with the edges, 6 with the face)
26  4-node third order edge (2 nodes associated with the vertices, 2 internal to the edge)
27  5-node fourth order edge (2 nodes associated with the vertices, 3 internal to the edge)
28  6-node fifth order edge (2 nodes associated with the vertices, 4 internal to the edge)
29  20-node third order tetrahedron (4 nodes associated with the vertices, 12 with the edges, 4 with the faces)
30  35-node fourth order tetrahedron (4 nodes associated with the vertices, 18 with the edges, 12 with the faces, 1 in the volume)
31  56-node fifth order tetrahedron (4 nodes associated with the vertices, 24 with the edges, 24 with the faces, 4 in the volume)
92  64-node third order hexahedron (8 nodes associated with the vertices, 24 with the edges, 24 with the faces, 8 in the volume)
93  125-node fourth order hexahedron (8 nodes associated with the vertices, 36 with the edges, 54 with the faces, 27 in the volume)
=#

function gmsh_get_physical_lines(filename::String)
    # logic, if etype in Gmsh is 15 (corner node) then add that node
    # to the set, benefit of set -> element is added to set only if it is not
    # part of the set already, so push all such nodes without worrying about
    # repititions
    # Step2 is to take elements from this set and then put them in a vector

    if !isfile(filename)
        error("Could not locate $filename")
    end

    lines = readlines(open(filename))
    id = 1
    nlines = length(lines)

    while lines[id] != "\$PhysicalNames" && id <= nlines
        id += 1
    end

    if id == nlines
        error("No Pysical entities data in $filename")
    end

    id += 2

    tags_set = IntSet()

    while lines[id] != "\$EndPhysicalNames" && id < nlines
        p = split(lines[id])
        if p[1] == 1
            push!(tags_set,parse(Int64,p[2]))
        end
        id += 1
    end

    while lines[id] != "\$Elements" && id <= nlines
        id += 1
    end

    if id == nlines
        error("No Element Data in $filename")
    end

    id += 2

    node_set = IntSet()
    while lines[id] != "\$EndElements" && id < nlines
        p = split(lines[id])
        for i=1:length(tags_set)
            if p[4] == tags_set[i] #edge :: Gmsh nomenclature
                push!(node_set,parse(Int64,p[end]))
                push!(node_set,parse(Int64,p[end-1]))
            end
        end
        id += 1
    end
    #convert set into vector

    nodes = zeros(Int64,length(node_set))
    for i = 1:1:length(node_set)
        nodes[i] = pop!(node_set)
    end

    return nodes
end
