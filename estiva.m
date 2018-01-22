% T = [9 2 5 3 0; 0 4 1 3 0; 0 0 0 3 4; 0 0 0 2 2; 0 0 0 0 4] 
% Navio=zeros(5,6);

function  [nmov,Navio] = estiva(T,Navio)

N = size(T,2); % número de portos

R = size(Navio,1); % número de linhas

C = size(Navio,2);  % número de colunas

model = Cplex('estiva');
model.Model.sense = 'minimize';

nvar = 0; 
nv = (N*T);
%v = triu(ones(nv,nv),1);

[model,mapObj_x,nvar] = gera_variavel_x(model,N,R,C,nvar);

nx=nvar;

[model,mapObj_y,nvar] = gera_variavel_y(model,N,R,C,nvar);

model = gera_restr_1(model,N,R,C,T,mapObj_x,nvar);

model = gera_restr_2(model,N,R,C,mapObj_x,mapObj_y,nvar);

model = gera_restr_3(model,N,R,C,mapObj_y,nvar);

model = gera_restr_4(model,N,R,C,mapObj_x,nvar);

model = gera_restr_5(model,R,C,T,mapObj_y,nvar);

fprintf('Modelo estiva criado\n');
model.writeModel('model.lp');
%model.Param.mip.strategy.search.Cur=4;
model.solve();

% Display solution
fprintf ('\nSolution status = %s\n',model.Solution.statusstring);
fprintf ('Valor da Funcao Objetivo: %f\n', model.Solution.objval);
%fprintf ('Numero de remanejamentos: %f\n', sum(model.Solution.x(1:nx)));

Navio = obterNavio(model,mapObj_y,mapObj_x,R,C,N);
nmov=model.Solution.objval;