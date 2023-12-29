function z = Select(pop)

global popSize
global popSizeSon
global tournament

popSon = [];
pick = round(popSize * tournament);

while numel(popSon) < popSizeSon
    pick_index = sort(randperm(popSize,pick));
    pick_indiv = pop(pick_index);
    pick_rank = P2Array(pick_indiv,'Rank');
    pick_indiv = pick_indiv(pick_rank == min(pick_rank));
    pick_dist = P2Array(pick_indiv,'Dist');
    best = pick_indiv(pick_dist == max(pick_dist));
    popSon = [popSon;best]; %#ok<AGROW>
end
z = popSon;