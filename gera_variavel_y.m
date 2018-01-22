


function [model,mapObj_y,nvar] = gera_variavel_y(model,N,R,C,nvar)

ny1 = (N-1)*R*C;
ny = 0;
colnames = cell(1,ny1);


for i = 1:N-1 
    for r = 1:R
       for c = 1:C                   
           ny = ny+1;
           colnames(ny) = {strcat('y_',int2str(i),'_',int2str(r),'_',int2str(c))};
       end
    end
end

pos = linspace(nvar+1,nvar+ny,ny);
nvar = nvar + ny;
mapObj_y = containers.Map(colnames,pos);
colnames = char(colnames);

obj = sparse(ny,1);
lb = sparse(ny,1);
ub = ones(ny,1);
ctypes = char (ones ([1, ny]) * ('B'));

model.addCols(obj, [], lb, ub,ctypes,colnames);

end