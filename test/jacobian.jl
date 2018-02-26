using SimpleFEMJulia

function case1()
    #linear 2 node
    l1 = create_line(0,2)
    element = BAR2N()
    mesh = create_mesh(l1,element,0.2)

    elemnum = 1
    gp = 1
    Te = mesh.t[elemnum,:]
    Xe  = mesh.x[Te,1:element.dim]

    (J,Jinv,Jdet) = jacobian(element,Xe,gp)
end

function case2()
    # quad4 element

    sq1 = create_rectangle(0,1,0,2)
    elem = QUAD4N()
    m3 = create_mesh(sq1,elem,0.5)

    elemnum = 1
    gp = 1
    Te = m3.t[elemnum,:]
    Xe  = m3.x[Te,1:elem.dim]

    return jacobian(elem,Xe,gp)
end

case2()
