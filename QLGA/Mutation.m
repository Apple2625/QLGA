function z = Mutation(pop,~)

global pM

n=length(pop);
if nargin == 1
    for i  = 1 : n
        chrom=pop(i).Path;
        if rand < pM
            pick = randperm(numel(chrom),2);
            a = chrom(pick(1));
            b = chrom(pick(2));
            chrom(pick(1)) = b;
            chrom(pick(2)) = a;
        end
        pop(i).Path = chrom;
    end
elseif nargin == 2
    for i  = 1 : n
        chrom=pop(i).Path;
        pick = randperm(numel(chrom),2);
        a = chrom(pick(1));
        b = chrom(pick(2));
        chrom(pick(1)) = b;
        chrom(pick(2)) = a;
        pop(i).Path = chrom;
    end
    
end
z=pop;


