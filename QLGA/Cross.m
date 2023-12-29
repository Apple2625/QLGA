function z = Cross(popSon,X) 

global pC
global popSizeSon

Box=popSon(1); 

for i = 1 : round(popSizeSon/2) 
    pick = rand(1,2);
    while prod(pick)==0
        pick = rand(1,2);
    end
    pick = ceil(pick.*popSizeSon);
    if rand < pC
        [A,B]=CrossPN(popSon(pick(1)),popSon(pick(2)),X,'Order');
    else
        A = popSon(pick(1));
        B = popSon(pick(2));
    end
    Box(end+1)=A;
    Box(end+1)=B; %#ok<*AGROW>
end
Box(1)=[];
z =Box;
