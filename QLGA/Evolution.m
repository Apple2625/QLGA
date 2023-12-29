function z = Evolution(pop)

global Q
global div_QLGA
global Gen 
global MaxGen
global alpha
global gamma
global epsilon

%% Diversity calculation
[div1,div2] = Diversity(pop);
div_QLGA(Gen,1) = div1; 
div_QLGA(Gen,2) = div2;
Value(:,1) = P2Array(pop,'Leng');
Value(:,2) = P2Array(pop,'Time');
meanValue = mean(Value);

Dist = P2Array(pop,'Dist');
Dist = Dist(Dist~=inf);
meanDist = mean(Dist);
interval = 0.5;
if div1 <= interval && div2 <= interval
    S = 1 ;
elseif div1 <= interval && div2 > interval
    S = 2 ;
elseif div1 > interval && div2 <=interval
    S = 3 ;
else
    S = 4;
end

%% Q-learning
row = Q(S,:);
if rand < epsilon
    A = randi(3);
else
    A = find(row==max(row));
    if numel(A)>1
        A = A(randi(numel(A)));
    end
end

pop = GA_process(pop,A);
z = pop;

% Reward
% Rdiv
[NEW_div1,NEW_div2] = Diversity(pop);
Rdiv = 0.5 * (NEW_div1+NEW_div2-div1-div2);

% Rcon
NEW_Value(:,1) = P2Array(pop,'Leng');
NEW_Value(:,2) = P2Array(pop,'Time');
meanNEW_Value = mean(NEW_Value);

if meanNEW_Value(1) < meanValue(1)
    R21 = 1 + Gen / MaxGen;
else
    R21 = -2 + Gen / MaxGen;
end

if meanNEW_Value(2) < meanValue(2)
    R22 = 1 + Gen / MaxGen;
else
    R22 = -2 + Gen / MaxGen;
end
Rcon = R21 + R22;

% Rdis
NEW_Dist = P2Array(pop,'Dist');
NEW_Dist = NEW_Dist(NEW_Dist~=inf);
meanNEW_Dist = mean(NEW_Dist);

if meanNEW_Dist > meanDist
    Rdis = 1 ;
else 
    Rdis = -1;
end

% Rt
if Rcon + Rdis > 0
    R = (Rcon + Rdis) / (1 - Rdiv);
else
    R = (Rcon + Rdis) / (1 + Rdiv);
end

%% update Q-table
if div1 <= interval && div2 <= interval
    S1 = 1 ;
elseif div1 <= interval && div2 > interval
    S1 = 2 ;
elseif div1 > interval && div2 <=interval
    S1 = 3 ;
else
    S1 = 4;
end

row1 = Q(S1,:);
if rand < epsilon
    A1 = randi(3);
else
    A1 = find(row1==max(row1));
    if numel(A1)>1
        A1 = A1(randi(numel(A1)));
    end
end

Q(S,A) = (1-alpha)*Q(S,A) + alpha*(R + gamma*Q(S1,A1));
