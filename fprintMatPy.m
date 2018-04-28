function fprintMatPy(file_name, arg_name, var_sym)
%FPRINTMATPY Prints symbolic expressions of 2D-matrix as callable python scripts
% Author: tkorthals@cit-ec.uni-bielefeld.de
% Input
%  file_name                The file name
%  arg_name                 Arguments of symbolic expressions
%  var_sym                  Matrix of symbolic expressions
% Example
%  syms a b c; fprintMatPy('test.py', {'a', 'b', 'c'}, a*b+c)

    if numel(var_sym) == 1
        fprintPyFun(file_name, arg_name, var_sym);
    else
        for row = 1 : size(var_sym, 1)
            for col = 1 : size(var_sym, 2)
                fprintPyFun([file_name, '_', num2str(row), '_', num2str(col)], arg_name, var_sym(row, col));
            end
        end
    end
end

