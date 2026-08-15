implementation module main

import StdEnv

:: Main = "Hello, World!" >> !World

start world = main world >> !world
