function z = popMerge(A,B)

global popSize
global press

Zero_num = round(popSize * press);
B = B'; 
C = [A;B];
C = Dominate(C);
C = CrowdingDistance(C);
z = A(1);

Rank = P2Array(C,'Rank');
[~,index]=sort(Rank);
C = C(index);
currentRank = 1;

k = 0;
while k < popSize
    NowC = C(Rank == currentRank);
    Dist = P2Array(NowC,'Dist');
    [~,index]=sort(Dist,'descend');
    NowC = NowC(index);
    z = [z;NowC]; %#ok<AGROW>
    currentRank = currentRank + 1;
    k = numel(z)-1;
end

z(1)=[];
if numel(z) > popSize
    z(popSize+1:end) = [];
end

z = CrowdingDistance(z);
DistZ = P2Array(z,'Dist');
DistZ = DistZ == 0;
N = sum(DistZ);
if N > Zero_num
    pick = find(DistZ == 1);
    pick = pick(randperm(numel(pick),N - Zero_num));
    for i = pick
        z(i) = Mutation(z(i),1); 
    end
end



