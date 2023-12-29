function z = Reverse(pop)

global popSize

popOLD = pop;
ValueOLD(:,1) = P2Array(pop,'Leng');
ValueOLD(:,2) = P2Array(pop,'Time');
Le = numel(pop(1).Path);

for i = 1 : popSize
    Path = pop(i).Path;
    pick = sort(randperm(Le,2));
    Fra = Path(pick(1):pick(2));
    Path(pick(1):pick(2)) = fliplr(Fra);
    pop(i).Path = Path;
end

pop = pathLength(pop);
pop = SwitchTime(pop);

ValueNEW(:,1) = P2Array(pop,'Leng');
ValueNEW(:,2) = P2Array(pop,'Time');

popEnd = popOLD;
for i = popSize
    if sum(ValueNEW(i,:) < ValueOLD(i,:)) == 2
        popEnd(i) = pop(i);
    elseif sum(ValueNEW(i,:) < ValueOLD(i,:)) == 1
        if rand < 0.5
            popEnd(i) = pop(i);
        end
    end
end
z = popEnd;
