function fprintPyFun(fileID, fun_name, arg_name, var_sym)
%FPRINTPYFUN Prints symbolic expressions as callable python scripts
% Author: tkorthals@cit-ec.uni-bielefeld.de
% Input
%  fileID                   The file ID
%  fun_name                 Name of the function
%  arg_name                 Arguments of symbolic expressions
%  var_sym                  Matrix of symbolic expressions

    fprintf(fileID,'def %s(',fun_name);
    for idx = 1 : numel(arg_name)
        fprintf(fileID,'%s',arg_name{idx});
        if idx ~= numel(arg_name)
            fprintf(fileID,', ');
        end
    end
    fprintf(fileID,'):\n');
    fprintf(fileID,'    return %s\n\n', sym2py(var_sym));
end
