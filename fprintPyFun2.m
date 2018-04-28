function fprintPyFun2(file_name, arg_name, var_sym, max_expression_len)
%FPRINTPYFUN2 Prints symbolic expressions as callable python scripts
%  Extension to fprintPyFun: Straps down longer equations with more than
%  max_expression_len characters
% Author: tkorthals@cit-ec.uni-bielefeld.de
% Input
%  file_name                The file name
%  arg_name                 Arguments of symbolic expressions
%  var_sym                  Matrix of symbolic expressions
%  max_expression_len       Maximum lenght of symbolic expression
% Example
%  syms a b c d k; fprintPyFun2('test', {'a', 'b', 'c', 'd', 'k'}, a*b^k+c+d, 0)
%  Result in test.py:
%  def test(a, b, c, d, k):
%      _1 = c
%      _2 = d
%      _4 = a
%      _6 = b
%      _7 = k
%      _5 = _6^_7
%      _3 = _4*_5
%      _0 = _1+_2+_3
%      return _0

    fileID = fopen([file_name,'.py'],'w');
    fprintf(fileID,'def %s(',file_name);
    for idx = 1 : numel(arg_name)
        fprintf(fileID,'%s',arg_name{idx});
        if idx ~= numel(arg_name)
            fprintf(fileID,', ');
        end
    end
    fprintf(fileID,'):\n');
    cnt = 0;
    fprintPyFun2_split(fileID, cnt, var_sym, max_expression_len);
    fprintf(fileID,'    return _0\n');
    fclose(fileID);
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
    fprintf(fileID,'    _%s = %s\n', num2str(cnt), strrep(strrep(strrep(char(var_sym), 'conj', ''), '^', '**'), '.', ''));
end
end
