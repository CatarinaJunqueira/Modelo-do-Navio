% \sum_{v=i+1}^{j}\sum_{r=1}^{R}\sum_{c=1}^{C}x_{ijvrc} - \sum_{k=1}^{i-1}\sum_{r=1}^{R}\sum_{c=1}^{C}x_{kjirc} = T_{ij}, \\  \nonumber  i = 1, \cdots, N-1;~~j=i+1, \cdots, N;
% Restricao de conservacao de fluxo

function model = gera_restricao_1(model,N,H,W,T,mapObj_b,nvar)

nr = W*(H-1)*T;
A1 = sparse(nr,nvar);

rest_name = cell(1,nr);
w=0;
for i=1:W
   for j=1:H-1
       for t=1:T
          w = w +1;
          rest_name(w) = {strcat('rest3_',int2str(i),'_',int2str(j),'_',int2str(t)) };

          for n=1:N
              %\sum_{n=1}^{N}b_{i,j+1,n,t}
               A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j+1),'_',int2str(n),'_',int2str(t))))=1;
               %-\sum_{n=1}^{N}b_{i,j,n,t}
               A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t))))=-1;          
          end
       end       
   end    
end

rest_name = char(rest_name);


lhs = -inf(nr,1);
rhs = sparse(nr,1);
model.addRows(lhs,A1,rhs,rest_name);
%addRows(0, A4, Inf);
end