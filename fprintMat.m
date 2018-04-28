function fprintMat(fileID, var_name, var_sym)
%FPRINTMAT Prints content of 2D-matrix to a file
% Author: tkorthals@cit-ec.uni-bielefeld.de
% Input
%  fileID                   The file ID
%  var_name                 Arbitrary variable name
%  var_sym                  Matrix of symbolic expressions
    
    if numel(var_sym) == 1
        % Print just a single variable
        fprintf(fileID,'%s = %s;\n',var_name, char(var_sym));
    else
        % Print multiple variables indexed by row and col
        for row = 1 : size(var_sym, 1)
            for col = 1 : size(var_sym, 2)
                fprintf(fileID,'%s_%d_%d = %s;\n',var_name, row, col, char(var_sym(row, col)));
            end
        end
    end
end