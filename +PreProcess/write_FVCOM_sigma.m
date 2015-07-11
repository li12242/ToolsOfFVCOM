function write_FVCOM_sigma(casename, type, nsiglev)
% write sigma file
% INPUT:
% 
% 
fileName = [casename, '_sigma.dat'];
fig = fopen(fileName, 'w');
fprintf(fig, '%s %d\n', 'NUMBER OF SIGMA LEVELS = ', nsiglev);
switch type
    case 'Uniform'
        fprintf(fig, '%s\n', 'SIGMA COORDINATE TYPE = UNIFORM');
end

fclose(fig);
end