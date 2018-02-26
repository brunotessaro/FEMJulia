using SimpleFEMJulia

element1 = BAR2N()
dump(element1)

element2 = BAR3N()
dump(element2)

element3 = TRI3N()
dump(element3)

element4 = QUAD4N()
dump(element4)

pb1 = thermal()
pb2 = structural_plane_stress()
pb3 = structural_plane_strain()

nat1 = quasi_static()

nat2 = transient()
