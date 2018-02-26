//+
Point(1) = {-0.6, 0.1, 0, 1.0};
//+
Point(2) = {-0.2, 0.5, -0, 1.0};
//+
Point(3) = {0.5, -0.1, -0, 1.0};
//+
Point(4) = {-0.1, -0.5, 0, 1.0};
//+
Line(1) = {1, 2};
//+
Line(2) = {2, 3};
//+
Line(3) = {3, 4};
//+
Line(4) = {4, 1};
//+
Line Loop(1) = {1, 2, 3, 4};
//+
Plane Surface(1) = {1};
//+
Plane Surface(2) = {1};
//+
Physical Line("Bc1", 500) = {1};
//+
Physical Line("Bc2", 501) = {3};
//+
Physical Surface("vol") = {1};
