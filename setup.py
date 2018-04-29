#!/usr/bin/python
# Run with './setup.py  build_ext --inplace' to build *so files
from distutils.core import setup
from Cython.Build import cythonize

setup(
    ext_modules = cythonize("*.py")
)
