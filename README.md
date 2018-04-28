# sym2pyfun
Convert Matlab symbolic functions to python function

`fprintPyFun2` contains the main functionality which actually converts a
symbolic expression to a python function. For more details look at the
scripts' explainations. 

## Examples

`syms a b c d k; fprintPyFun2('test', {'a', 'b', 'c', 'd', 'k'}, a*b^k+c+d, 5)`
produces output to `test.py`:
  def test(a, b, c, d, k):
      _1 = c
      _2 = d
      _3 = a*b**k
      _0 = _1+_2+_3
      return _0

`syms a b c d k; fprintPyFun2('test2', {'a', 'b', 'c', 'd', 'k'}, a*b^k+c+d, 0)`
produces output to `test2.py`:
  def test(a, b, c, d, k):
      _1 = c
      _2 = d
      _4 = a
      _6 = b
      _7 = k
      _5 = _6**_7
      _3 = _4*_5
      _0 = _1+_2+_3
      return _0
