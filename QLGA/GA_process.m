function z = GA_process(pop,A)

popSon = Select(pop) ;
popSon = Cross(popSon,A); 
popSon = Mutation(popSon); 
popSon = pathLength(popSon);
popSon = SwitchTime(popSon);
popSon = Reverse(popSon);
popSon = Dominate(popSon);
popSon = CrowdingDistance(popSon);
pop = popMerge(pop,popSon);
pop = Dominate(pop);
pop = CrowdingDistance(pop);
z=pop;