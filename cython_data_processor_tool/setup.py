from setuptools import setup, Extension
from Cython.Build import cythonize
import numpy

extensions = [
    Extension(
        "data_processor_tool",
        ["data_processor_tool.pyx"],
        include_dirs=[numpy.get_include()],
    )
]

setup(
    name="cython_data_processor_tool",
    ext_modules=cythonize(extensions),
)
