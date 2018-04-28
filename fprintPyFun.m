function fprintPyFun(file_name, arg_name, var_sym)
%FPRINTPYFUN Prints symbolic expressions as callable python scripts
% Author: tkorthals@cit-ec.uni-bielefeld.de
% Input
%  file_name                The file name
%  arg_name                 Arguments of symbolic expressions
%  var_sym                  Matrix of symbolic expressions
% Example
%  syms a b c; fprintPyFun('test.py', {'a', 'b', 'c'}, a*b+c)

    fileID = fopen([file_name,'.py'],'w');
    fprintf(fileID,'def %s(',file_name);
    for idx = 1 : numel(arg_name)
        fprintf(fileID,'%s',arg_name{idx});
        if idx ~= numel(arg_name)
            fprintf(fileID,', ');
        end
    end
    fprintf(fileID,'):\n');
    fprintf(fileID,'    return %s\n', strrep(strrep(strrep(char(var_sym), 'conj', ''), '^', '**'), '.', ''));
    fclose(fileID);
end
