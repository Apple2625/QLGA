function pop = Dominate(pop)

global M
N = length(pop);
if isstruct(pop)
    Value(:,1) = P2Array(pop,'Leng');
    Value(:,2) = P2Array(pop,'Time');
else
    Value(:,1)=pop(:,1);
    Value(:,2)=pop(:,2);
end
pareto_rank=1;
F(pareto_rank).ss=[];
p=[];

for i=1:N
    p(i).n=0; %#ok<AGROW>
    p(i).s=[];%#ok<AGROW> 
    for j=1:N
        less=0;
        equal=0;
        greater=0;
        for k=1:M
            if(Value(i,k)<Value(j,k))
                less = less+1;
            elseif(Value(i,k)==Value(j,k))
                equal = equal+1;
            else
                greater = greater+1;
            end
        end
        
        if(less == 0 && equal ~= M) 
            p(i).n=p(i).n+1; 
        elseif(greater==0 && equal~=M)
            p(i).s=[p(i).s j];
        end
    end
    
    if(p(i).n==0) 
        if isstruct (pop)
            pop(i).Rank = 1;
        else
            pop(i,3)=1;
        end
        F(pareto_rank).ss=[F(pareto_rank).ss i];
    end
end

while ~isempty(F(pareto_rank).ss)
    temp=[];
    for i=1:length(F(pareto_rank).ss)
        if ~isempty(p(F(pareto_rank).ss(i)).s)
            for j=1:length(p(F(pareto_rank).ss(i)).s)
                p(p(F(pareto_rank).ss(i)).s(j)).n=p(p(F(pareto_rank).ss(i)).s(j)).n - 1;%#ok<AGROW> 
                if p(p(F(pareto_rank).ss(i)).s(j)).n==0
                    if isstruct (pop)
                        pop(p(F(pareto_rank).ss(i)).s(j)).Rank=pareto_rank+1;
                    else
                        pop(p(F(pareto_rank).ss(i)).s(j),3)=pareto_rank+1;
                    end
                    temp=[temp p(F(pareto_rank).ss(i)).s(j)]; %#ok<AGROW>
                end
            end
        end
    end
    pareto_rank=pareto_rank+1;
    F(pareto_rank).ss=temp;
end
