function Navio = obterNavio(model,mapObj_y,mapObj_x,R,C,N)

Navio = cell(1,N-1);

    for i=1:N-1
        Navio{i}=zeros(R,C);
        for r=1:R
            for c=1:C 
                if model.Solution.x(mapObj_y(strcat('y_',int2str(i),'_',int2str(r),'_',int2str(c)))) == 1
                    for k = 1:i
                      for j = i+1:N
                          for v = i+1:j
                              if model.Solution.x(mapObj_x(strcat('x_',int2str(k),'_',int2str(j),'_',int2str(v),'_',int2str(r),'_',int2str(c)))) == 1
                                 Navio{i}(r,c)=j;
                              end
                          end
                      end                                             
                    end
        
                end                            
            end        
        end    
    end

end