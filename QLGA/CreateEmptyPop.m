function pop=CreateEmptyPop(n)

if nargin<1
    n=1;
end

empty_indiv.Path = [];
empty_indiv.Length = [];
empty_indiv.SwitchTime = [];
empty_indiv.Rank = [];
empty_indiv.CrwDist = 0;
pop=repmat(empty_indiv,n,1);
end