function z=pathLength(pop)

global Distance

if isstruct(pop)
    n = length(pop);
    for i = 1 : n
        chrom=pop(i).Path;
        Length=0;
        for j = 1 : numel(chrom)-1
            k=Distance(chrom(j),chrom(j+1));
            Length=Length+k;
        end
        pop(i).Length = Length;
    end
    z = pop;
else
    chrom = pop;
    Length=0;
    for j = 1 : numel(chrom)-1
        k=Distance(chrom(j),chrom(j+1));
        Length=Length+k;
    end
    z = Length;
end

