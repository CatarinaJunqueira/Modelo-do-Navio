
function model = gera_restr_2(model,N,R,C,mapObj_x,mapObj_y,nvar)

nr = (N-1)*R*C;
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for i=1:N-1
   for r=1:R
       for c=1:C
          w = w +1;
          rest_name(w) = {strcat('rest2_',int2str(i),'_',int2str(r),'_',int2str(c))}; 
          A1(w,mapObj_y(strcat('y_',int2str(i),'_',int2str(r),'_',int2str(c))))=-1;
           
           for k=1:i
              for j=i+1:N
                  for v=i+1:j
                    A1(w,mapObj_x(strcat('x_',int2str(k),'_',int2str(j),'_',int2str(v),'_',int2str(r),'_',int2str(c))))=1;                 
                  end         
              end
           end 
       end
   end    
end

lhs = zeros(nr,1);
rest_name = char(rest_name);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end