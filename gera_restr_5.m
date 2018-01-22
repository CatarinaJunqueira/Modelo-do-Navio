function model = gera_restr_5(model,R,C,TT,mapObj_y,nvar) %restricao de estabilidade

v=sum(TT);

N=zeros(size(TT,1),1);
for i=1:size(TT,1)
    N(i)=sum(TT(i,:));
end

vv=zeros(1,length(TT)-1);
vv(1)= N(1)-v(1);
for i=2:length(v)-1
    vv(i)= vv(i-1)+ N(i)-v(i); % Este eh o omega
end

nr=0;
for o=1:length(TT)-1
    if ceil((vv(o))/C) < R
       nr=nr+1;
    end
end
A1 = sparse(nr,nvar); 
rest_name = cell(1,nr);
w=0;

for o=1:length(TT)-1
    if ceil((vv(o))/C) < R
       w = w +1;
       rest_name(w) = {strcat('rest5_',int2str(o))};    
       for c=1:C
           for r=ceil(vv(o)/C)+1:R       
               A1(w,mapObj_y(strcat('y_',int2str(o),'_',int2str(r),'_',int2str(c))))=1;     
           end   
       end
    end
end
rest_name = char(rest_name);
lhs = zeros(nr,1);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end