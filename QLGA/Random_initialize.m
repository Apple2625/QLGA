function z = Random_initialize(pop)

global CityTools

ToolSum = sum(CityTools~=0,2); 

for i = 1 : size (pop,1)
    Code = zeros(1);
    for j = 1 : numel(ToolSum)
        Code(end+1:end+ToolSum(j))=j;
    end
    Code(Code==0)=[];
    Code = Code(randperm(numel(Code)));
    pop(i).Path = Code;
    
end

%% length calculation
pop = pathLength(pop);

%% switching time calculation
pop = SwitchTime(pop);

%% non-dominate rank
pop = Dominate(pop);

%% crowding distance calculation
pop = CrowdingDistance(pop);

z=pop;