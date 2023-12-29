function [z1,z2] = Diversity(pop)

Length = P2Array(pop,'Leng');
Time = P2Array(pop,'Time');

div1 = DivC(Length);
div2 = DivC(Time);
z1 = div1;
z2 = div2;
end

function Z = DivC (X)
global popSize
X = X / sum(X); 
ave = mean(X);
best = min(X);
D = 0;
for i = 1: numel(X)
    k = sum(X== X(i));
    D = D + k -1;
end
div = exp(-(ave*D/(popSize*(ave - best))));
if div == inf
    div = 0;
end
Z = div;
end

