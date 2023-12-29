function [z,y] = CrossPN(A,B,what_insert,what_choose)

PathA = A.Path;
PathB = B.Path;
pick = sort(randperm(numel(PathA),2)); 
FragAtoB = PathA(pick(1):pick(2));
PathA(pick(1):pick(2)) = 0;
FragBtoA = PathB(pick(1):pick(2));
PathB(pick(1):pick(2)) = 0;
[PathA,LackA] = PathTest(PathA,FragBtoA,pick,what_choose);
[PathB,LackB] = PathTest(PathB,FragAtoB,pick,what_choose);
PathA(pick(1):pick(2)) = FragBtoA;
PathB(pick(1):pick(2)) = FragAtoB;
A.Path = INSERT(PathA,LackA,what_insert);
B.Path = INSERT(PathB,LackB,what_insert);

z = A ;
y = B ;

end

function [path_out,lack]= PathTest(Path,Frag,where,CASE)

global CityTools
Citys = length(CityTools);
PathLength = numel(Path);
lack = zeros(1,Citys);

ToolSum = sum(CityTools~=0,2); 
PathForPosition = [Path Path]; 
for i = 1 : Citys
    num_path = sum(Path == i);
    num_frag = sum(Frag == i);
    possess = num_path + num_frag;
    if possess > ToolSum(i) 
        switch CASE
            case 'Order' 
                located = find(PathForPosition== i);
                located = located(located >where(2));
                located = located(1:possess - ToolSum(i));
                located(located > PathLength) = located(located > PathLength) - PathLength;
                Path(located) = 0;
            case 'Random' 
                located = find(Path== i);
                located = located(randperm(numel(located),possess - ToolSum(i)));
                Path(located) = 0;
        end
        lack(i) = 0;
    else 
        lack(i) = ToolSum(i) - possess;
    end
end
path_out = Path;
end

function path_whole = INSERT(Path,Lack,CASE)

IN = find(Lack~=0);
IN = IN (randperm(numel(IN))); 
switch CASE
    case 1 
        for i = IN
            Zero_located = find(Path == 0);
            pickzero =Zero_located(randperm(numel(Zero_located),Lack(i)));
            Path(pickzero) = i;
        end   
    case 2 
        for i = IN
            Path = Min_INSERT(Path,i,Lack(i),'Leng');
        end    
    case 3 
        for i = IN
            Path = Min_INSERT(Path,i,Lack(i),'Time');
        end       
end
path_whole = Path;
end

function z = Min_INSERT(Path,Gene,number,what)
for i = 1 : number
    PathBox = [];
    ValueBox = [];
    located = find(Path==0);
    for j = 1 : numel(located)
        PathNew = Path;
        PathNew(located(j)) = Gene;
        PathBox(j,:) = PathNew;
        PathWithoutZero = PathNew(PathNew~=0);
        switch what
            case 'Leng'
                ValueBox(j) = pathLength(PathWithoutZero); %#ok<*AGROW>
            case 'Time'
                ValueBox(j) = SwitchTime(PathWithoutZero);
        end
    end
    minValue = find(ValueBox == min(ValueBox));
    if numel(minValue) >1
        minValue = minValue(randi(numel(minValue)));
    end
    Path = PathBox(minValue,:);
end
z = Path;
end


