


function [model,mapObj_x,nvar] = gera_variavel_x(model,N,R,C,nvar)


nx = 0;


for i = 1:N-1 
    for j = i+1:N
        for v = i+1:j
            nx = nx+R*C;
        end
    end
end
colnames = cell(1,nx);
obj = ones(nx,1);
w = 0;
for i = 1:N-1 
    for j = i+1:N
        for v = i+1:j
            for r = 1:R
               for c = 1:C                   
                   w = w+1;
                   colnames(w) = {strcat('x_',int2str(i),'_',int2str(j),'_',int2str(v),'_',int2str(r),'_',int2str(c))};
                   
                   if v == j
                      obj(w) = 0; 
                   end
               end
            end
        end
    end
end

pos = linspace(nvar+1,nvar+nx,nx);
nvar=nvar+nx;
mapObj_x = containers.Map(colnames,pos);
colnames = char(colnames);


lb = zeros(nx,1);
ub = ones(nx,1);
ctypes = char (ones ([1, nx]) * ('B'));

model.addCols(obj, [], lb, ub,ctypes,colnames);

end