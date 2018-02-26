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
