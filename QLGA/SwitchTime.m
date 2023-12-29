function z = SwitchTime(pop)

global CityArray
global TimeTable
global CityTools

if isstruct(pop)
    n = length(pop);
    for i = 1 : n
        chrom=pop(i).Path;
        SWT=0;
        Tbox = zeros(1,size(CityArray,1)); 
        for j = 1 : numel(chrom)
            if j >=2
                LastTool = CityTools(chrom(j-1),Tbox(chrom(j-1)));
                Tbox(chrom(j)) = Tbox(chrom(j)) + 1;
                NextTool = CityTools(chrom(j),Tbox(chrom(j)));
                SWT = SWT + TimeTable(LastTool, NextTool);
            else
                Tbox(chrom(j)) = Tbox(chrom(j)) + 1;
            end
            
        end
        pop(i).SwitchTime = SWT;
    end
    z = pop;
else
    chrom = pop;
    SWT = 0;
    Tbox = zeros(1,size(CityArray,1)); 
    for j = 1 : numel(chrom)
        
        if j >=2
            LastTool = CityTools(chrom(j-1),Tbox(chrom(j-1)));
            Tbox(chrom(j)) = Tbox(chrom(j)) + 1;
            NextTool = CityTools(chrom(j),Tbox(chrom(j)));
            SWT = SWT + TimeTable(LastTool, NextTool);
        else
            Tbox(chrom(j)) = Tbox(chrom(j)) + 1;
        end
        
    end
    
    z=SWT;
end
