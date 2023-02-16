function opt2 = set_options(opt1)
if isequal(opt1,[])
    opt2.verbose = false;
    opt2.solver = 'mosek';
    opt2.precision = 'default';
else
    opt2 = opt1;
    if ~isfield(opt1,'verbose')
        opt2.verbose = false;
    end
    if ~isfield(opt1,'solver')
        opt2.solver = 'mosek';
    end
    if ~isfield(opt1,'precision')
        opt2.precision = 'default';
    end
end
