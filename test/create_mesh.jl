using SimpleFEMJulia

l1 = create_line(0,2)
elem = BAR2N()
m1 = create_mesh(l1,elem,0.2)

dump(m1)

l2 = create_line(0,3)
elem = BAR3N()
m2 = create_mesh(l2,elem,0.34)

dump(m2)

sq1 = create_rectangle(0,1,0,2)
elem = QUAD4N()
m3 = create_mesh(sq1,elem,0.5)

dump(m3)

sq2 = create_rectangle(0,1,0,2)
elem = TRI3N()
m4 = create_mesh(sq2,elem,0.5)

dump(m4)
