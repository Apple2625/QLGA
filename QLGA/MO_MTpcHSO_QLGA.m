% MO-MTpcHSO QLGA
% created by Desong Zhang, email: z.desong@foxmail.com
clear
maxtime = 1; % independently run maxtime times
close all
for time = 1 : maxtime
    clearvars -except time maxtime
    clc
    
    %% global parameters for QLGA
    global M ; M  =2 ; %#ok<*TLEV> % number of objectives
    global popSize ; popSize =40; % population size can not be set to 1
    global MaxGen ; MaxGen =20 * popSize ; % maximum of iteration
    global ArchiveSize ; ArchiveSize = popSize; % size of external archive
    global popSizeSon ; popSizeSon = popSize; % size of subpopulation
    global tournament ; tournament = 0.25 ; % tournament selection coefficient
    global pC ; pC = 0.8; % probability of crossover
    global pM ; pM = 0.02; % probability of mutation

    %% parameters for q-learning
    global Q ; Q = zeros(4,3); % size of Q-table
    global alpha ; alpha = 0.9; % learning rate
    global gamma ; gamma = 0.9; % discount 
    global epsilon ; epsilon = 0.1;  % epsilon 

    %% environment (assigned in "load")
    global CityArray % coordinates of holes
    global CityTools  %#ok<NUSED> % required tools of each hole
    global TimeTable %#ok<NUSED> % switching time of tool positions
    global Distance % distance among holes
    load('W12') % popSize =40
    Distance = pdist2(CityArray,CityArray);
    
    %% initialize
    pop = CreateEmptyPop(popSize);
    pop = Random_initialize(pop); 
    global Archive ; Archive = [];
    global div_QLGA ; div_QLGA = zeros(MaxGen,2);
    
    %% creat a waitbar, can be closed anytime
    Pbar = waitbar(0,'please wait'); 
    
    %% main loop
    STR = ['-----------------------Time ', num2str(time), '/', num2str(maxtime),  ' main loop begins -----------------------'];
    disp(STR)
    tic
    global Gen ; Gen = 1; % current generation
    while Gen <= MaxGen
        if isvalid(Pbar) 
            str=[ num2str(Gen) ' / ' num2str(MaxGen) ' (' num2str(100*Gen/MaxGen,'%4.1f') '%) . Now ' num2str(time) ' / ' num2str(maxtime) ' times. Spent ',num2str(toc,'%4.0f'),' seconds.'];
            waitbar(Gen/MaxGen,Pbar,str) 
        else
            disp(['Generation ' num2str(Gen) ' / ' num2str(MaxGen) ' (' num2str(100*Gen/MaxGen,'%4.1f') '%) completed. Spent ',num2str(toc,'%4.0f'),' seconds.']);
        end
        pop = Evolution(pop);
        Archive = ArchiveUpdate(Archive,pop);
        Gen = Gen + 1;
    end
    [div_QLGA(Gen,1),div_QLGA(Gen,2)] = Diversity(pop); 
    if isvalid(Pbar)
        close(Pbar)
    end    
    disp(['Time ' num2str(time) ' Finished'])
end
