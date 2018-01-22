% \sum_{v=i+1}^{j}\sum_{r=1}^{R}\sum_{c=1}^{C}x_{ijvrc} - \sum_{k=1}^{i-1}\sum_{r=1}^{R}\sum_{c=1}^{C}x_{kjirc} = T_{ij}, \\  \nonumber  i = 1, \cdots, N-1;~~j=i+1, \cdots, N;
% Restricao de conservacao de fluxo

function model = gera_restr_1(model,N,R,C,T,mapObj_x,nvar)

nr = (N-1)*N/2;
A1 = sparse(nr,nvar);
rhs = zeros(nr,1);
rest_name = cell(1,nr);
w=0;
for i=1:N-1
   for j=i+1:N
        w = w +1;
        rest_name(w) = {strcat('rest1_',int2str(i),'_',int2str(j))};
        rhs(w) = T(i,j);
       for v=i+1:j
          for r=1:R
              for c=1:C
                A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(j),'_',int2str(v),'_',int2str(r),'_',int2str(c))))=1;                
              end         
          end
       end
       
       for k=1:i-1
          for r=1:R
              for c=1:C
                A1(w,mapObj_x(strcat('x_',int2str(k),'_',int2str(j),'_',int2str(i),'_',int2str(r),'_',int2str(c))))=-1;                 
              end         
          end
       end 
       
   end    
end

rest_name = char(rest_name);

lhs = rhs;
model.addRows(lhs,A1,rhs,rest_name);
end