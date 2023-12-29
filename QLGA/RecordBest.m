function z = RecordBest(trace,pop)
% record the best 
fitness = P2Array(pop);
new = min(fitness);
if trace(1) == 0
    trace(1) = new;
else
    if trace(end)>new
        trace(end+1) = new;
    else
        trace(end+1)=trace(end);
    end
end
z=trace;