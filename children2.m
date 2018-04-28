function [childs, issum, isprod, ispow, isfun] = children2(parent)
%CHILDREN2 Returns the children plus meta info. of math. concatenation
% Author: tkorthals@cit-ec.uni-bielefeld.de
% Input
%  parent                   Symbolic expression
% Output
%  childs                   Vector of symbolic expression
%  issum                    True if parent is sum of children
%  isprod                   True if parent is product of children
%  ispow                    True if parent is power of children
%  isfun                    True if parent is some function's argument

childs = children(parent);
issum = false; isprod = false; ispow = false; isfun = false;

if numel(childs) == 1
    if ~isequaln(childs,parent) % functions were removed
        isfun = true;
    end
    return
end

if numel(childs) == 2
    if isequaln(childs(1)^childs(2),parent) % pow
        ispow = true;
        return
    elseif isequaln(childs(1)/childs(2),parent) % div
        childs = parent;
        return
    end
end

if isequaln(prod(childs),parent) % prod
    isprod = true;
    return
end

if isequaln(sum(childs),parent) % sum
    issum = true;
    return
end

error('children2: Undefined behaviour for more than two children')

end
