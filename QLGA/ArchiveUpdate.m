function z = ArchiveUpdate(Archive,pop)

global ArchiveSize

Rank = P2Array(pop,'Rank');
pop = pop(Rank==1);

A = [Archive;pop];
A = Dominate(A);
A = CrowdingDistance(A);
RankA = P2Array(A,'Rank');
[~,index]=sort(RankA);
A = A(index);

A (RankA > 1 ) = [];
if numel(A) > ArchiveSize
    DistA = P2Array(A,'Dist');
    [~,index]=sort(DistA,'descend');
    A = A(index);
    A(ArchiveSize+1:end)=[];
end

z = A;

