function var_py = sym2py(var_sym)
%SYM2PY Parse symbolic function to python equivalent
% NOTE: It is assumed that all values are real and thus 'conj' is removed
% Author: tkorthals@cit-ec.uni-bielefeld.de
% Input
%  var_sym                  Symbolic expression

var_py = strrep(strrep(strrep(char(var_sym), 'conj', ''), '^', '**'), '.', '');
