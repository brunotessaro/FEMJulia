function plot_mesh_2D(mesh::Mesh, nodenum::Bool)
    
    edge_style = "b-"
    
    if mesh.ename == "QUAD2D4N"
        order = [1,2,3,4]
        for i = 1:mesh.nelems
            plot!(mesh.x[mesh.t[i,order],1], mesh.x[mesh.t[i,order],2], edge_style)
        end
    else
        error("Plotting not implemented for this element name")
    end
    
end
















#=
% Nodes
plot(X(:,1),X(:,2),str1)
hold on
% Elements
for j = 1:size(T,1)
    plot(X(T(j,order),1),X(T(j,order),2),str2)
end


% nodes number
if nargin==5
    if nonum==1
        for I=1:size(X,1)
            text(X(I,1)+0.02,X(I,2)+0.03,int2str(I),'FontSize',16)
        end
    end
end

axis('equal')
axis('off')

hold off
=#
