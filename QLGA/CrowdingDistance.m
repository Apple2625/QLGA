function z = CrowdingDistance(pop)

Rank = P2Array(pop,'Rank');
Value(:,1) = P2Array(pop,'Leng');
Value(:,2) = P2Array(pop,'Time');
[N,M] = size(Value);
Fmax  = max(Value,[],1);
Fmin = min(Value,[],1);

for i = 1 : N
    pop(i).CrwDist = 0;
end

for i = 1 : M
    [~,rank] = sortrows(Value(:,i));
    pop(rank(1)).CrwDist   = inf;
    pop(rank(end)).CrwDist = inf;
    for j = 2 : N-1
        pop(rank(j)).CrwDist = pop(rank(j)).CrwDist+(Value(rank(j+1),i)-Value(rank(j-1),i))/(Fmax(i)-Fmin(i));
    end
end
[~,index]=sort(Rank);
pop = pop(index);
z = pop;