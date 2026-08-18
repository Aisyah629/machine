#!/usr/bin/env sed -f
# main.sed
#
# Stream-based text transformation and log parsing workflows.
# Strictly written in Sed.

# Example: Replace 'foo' with 'bar'
s/foo/bar/g

# Example: Remove all comments (lines starting with #)
/^#/d

# Example: Print lines containing 'error' (case-insensitive)
/error/Ip

# Example: Add line numbers to the output
=' LINE:'
