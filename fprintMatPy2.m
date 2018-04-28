function fprintMatPy2(file_name, arg_name, var_sym, max_expression_len)
%FPRINTMATPY2 Prints symbolic expressions of 2D-matrix as callable python scripts
% Author: tkorthals@cit-ec.uni-bielefeld.de
% Input
%  file_name                The file name
%  arg_name                 Arguments of symbolic expressions
%  var_sym                  Matrix of symbolic expressions
%  max_expression_len       Maximum lenght of symbolic expression
% Example
%  syms a b c d k; fprintMatPy2('test', {'a', 'b', 'c', 'd', 'k'}, a*b^k+c+d, 0)
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
    if numel(var_sym) == 1
        fprintPyFun2(fileID, file_name, arg_name, var_sym, max_expression_len);
    else
        for row = 1 : size(var_sym, 1)
            for col = 1 : size(var_sym, 2)
                fprintPyFun2(fileID, [file_name, '_', num2str(row), '_', num2str(col)], arg_name, var_sym(row, col), max_expression_len);
            end
        end
    end
    fclose(fileID);
end
