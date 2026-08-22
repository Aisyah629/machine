# distutils: language = c
# cython: boundscheck=False, wraparound=False

import cython
from libc.stdlib cimport malloc, free
from libc.string cimport memcpy, memset
from libc.math cimport sqrt, pow

import numpy as np
cimport numpy as np


@cython.boundscheck(False)
@cython.wraparound(False)
cdef double _compute_mean(double[:] data, Py_ssize_t n) noexcept:
    """Compute the mean of a numeric array."""
    cdef double sum_val = 0.0
    cdef Py_ssize_t i
    for i in range(n):
        sum_val += data[i]
    return sum_val / n


@cython.boundscheck(False)
@cython.wraparound(False)
cdef double _compute_std_dev(double[:] data, Py_ssize_t n, double mean) noexcept:
    """Compute the standard deviation of a numeric array."""
    cdef double sum_sq_diff = 0.0
    cdef Py_ssize_t i
    for i in range(n):
        sum_sq_diff += (data[i] - mean) * (data[i] - mean)
    return sqrt(sum_sq_diff / n)


class DataProcessor:
    """A Cython-based data processor for numerical operations."""

    def __init__(self):
        self.name = "CythonDataProcessor"
        self.version = "1.0.0"

    def process(self, np.ndarray[np.float64_t, ndim=1] data):
        """
        Perform statistical processing on the input data.
        
        Args:
            data (np.ndarray): A 1D array of float64 values.
            
        Returns:
            dict: Dictionary containing mean, std_dev, and processed count.
        """
        cdef Py_ssize_t n = data.shape[0]
        cdef double mean_val
        cdef double std_val

        if n == 0:
            raise ValueError("Data array cannot be empty.")

        mean_val = _compute_mean(data, n)
        std_val = _compute_std_dev(data, n, mean_val)

        # Normalize data
        cdef np.ndarray[np.float64_t, ndim=1] normalized = np.empty(n, dtype=np.float64)
        for i in range(n):
            if std_val > 0:
                normalized[i] = (data[i] - mean_val) / std_val
            else:
                normalized[i] = 0.0

        return {
            "mean": mean_val,
            "std_dev": std_val,
            "count": n,
            "normalized_sample": normalized[0] if n > 0 else 0.0
        }

    def batch_process(self, np.ndarray[np.float64_t, ndim=2] data):
        """
        Process each row in a 2D array.
        
        Args:
            data (np.ndarray): A 2D array of float64 values.
            
        Returns:
            list: List of results for each row.
        """
        cdef Py_ssize_t num_rows = data.shape[0]
        cdef np.ndarray[np.float64_t, ndim=1] row
        cdef list results = []
        cdef int i

        for i in range(num_rows):
            row = data[i]
            results.append(self.process(row))
            
        return results
