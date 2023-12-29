function z=P2Array(pop,what)

k = 3 ;
if nargin > 1
    if what == 'Leng' %#ok<*BDSCA> 
        cell=struct2cell(pop);
        z=cell2mat(cell(end-k,:));
    elseif what == 'Time'
        cell=struct2cell(pop);
        z=cell2mat(cell(end-k+1,:));
    elseif what == 'Rank'
        cell=struct2cell(pop);
        z=cell2mat(cell(end-k+2,:));
    elseif what == 'Dist'
        cell=struct2cell(pop);
        z=cell2mat(cell(end-k+3,:));
    end
else 
    cell=struct2cell(pop);
    z=cell2mat(cell(end-k+1,:));
end