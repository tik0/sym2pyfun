function fprintPyFun2(fileID, fun_name, arg_name, var_sym, max_expression_len)
%FPRINTPYFUN2 Prints symbolic expressions as callable python scripts
%  Extension to fprintPyFun: Straps down longer equations with more than
%  max_expression_len characters
% Author: tkorthals@cit-ec.uni-bielefeld.de
% Input
%  fileID                   The file ID
%  fun_name                 Name of the function
%  arg_name                 Arguments of symbolic expressions
%  var_sym                  Matrix of symbolic expressions
%  max_expression_len       Maximum lenght of symbolic expression

    fprintf(fileID,'def %s(',fun_name);
    for idx = 1 : numel(arg_name)
        fprintf(fileID,'%s',arg_name{idx});
        if idx ~= numel(arg_name)
            fprintf(fileID,', ');
        end
    end
    fprintf(fileID,'):\n');
    cnt = 0;
    fprintPyFun2_split(fileID, cnt, var_sym, max_expression_len);
    fprintf(fileID,'    return _0\n\n');
end

function cnt_next = fprintPyFun2_split(fileID, cnt, var_sym, max_expression_len)
%FPRINTPYFUN2_SPLIT Split long symbolic equations and print them to a file
% Input
%  fileId                   The file ID
%  cnt                      Internal counter for internal variable naming
%  var_sym                  Matrix of symbolic expressions
%  max_expression_len       Maximum lenght of symbolic expression

[childs, issum, isprod, ispow, ~] = children2(var_sym);
cnt_next = cnt;
if (numel(childs) > 1 && numel(char(var_sym)) > max_expression_len)
    term = '';
    for idx = 1 : numel(childs)
        cnt_next = fprintPyFun2_split(fileID, cnt_next + 1, childs(idx), max_expression_len);
        if issum
            term = sprintf("%s+_%s", term, num2str(cnt_next));
        elseif isprod
            term = sprintf("%s*_%s", term, num2str(cnt_next));
        elseif ispow
            term = sprintf("%s**_%s", term, num2str(cnt_next));
        end
        % elseif isfun % should  not happen, because the returning child
        % has numel == 1
    end
    extractAfter = 1;
    if ispow
        extractAfter = 2;
    end
    fprintf(fileID,'    _%s = %s\n', num2str(cnt), term.extractAfter(extractAfter));
    cnt_next = cnt;
else
    fprintf(fileID,'    _%s = %s\n', num2str(cnt), sym2py(var_sym));
end
end
