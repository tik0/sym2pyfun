function fprintMatPy2(file_name, arg_name, var_sym, max_expression_len)
%FPRINTMATPY2 Prints symbolic expressions of 2D-matrix as callable python scripts
% Author: tkorthals@cit-ec.uni-bielefeld.de
% Input
%  file_name                The file name
%  arg_name                 Arguments of symbolic expressions
%  var_sym                  Matrix of symbolic expressions
%  max_expression_len       Maximum lenght of symbolic expression

    if numel(var_sym) == 1
        fprintPyFun2(file_name, arg_name, var_sym, max_expression_len);
    else
        for row = 1 : size(var_sym, 1)
            for col = 1 : size(var_sym, 2)
                fprintPyFun2([file_name, '_', num2str(row), '_', num2str(col)], arg_name, var_sym(row, col), max_expression_len);
            end
        end
    end
end

