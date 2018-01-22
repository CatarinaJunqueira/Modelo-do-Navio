
function model = gera_restr_4(model,N,R,C,mapObj_x,nvar)

nr = (N-1)*(R-1)*C;
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for j=2:N
   for r=1:R-1
       for c=1:C
          w = w +1;
          rest_name(w) = {strcat('rest4_',int2str(j),'_',int2str(r),'_',int2str(c))}; 
             
           for i=1:j-1
              for p=j:N              
                  A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(p),'_',int2str(j),'_',int2str(r),'_',int2str(c))))=1;                       
              end
              for p= j+1:N
                  for v= j+1:p
                      A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(p),'_',int2str(v),'_',int2str(r+1),'_',int2str(c))))=1;
                  end
              end
           end 
       end
   end    
end

rest_name = char(rest_name);
lhs = -inf(nr,1);
rhs = ones(nr,1);
model.addRows(lhs,A1,rhs,rest_name);
end