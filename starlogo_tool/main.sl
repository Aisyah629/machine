globals [
  world-width world-height
  num-agents
  agent-color
]

turtles-own [
  speed
  direction
]

turtles-own [
  energy
]

turtles-own [
  x-velocity
  y-velocity
]

turtles-own [
  id
]

setup-turtles creates num-agents turtles
foreach range num-agents [ i ->
  ask turtle i [
    set x-velocity random 2 - 1
    set y-velocity random 2 - 1
    set energy 100
    set id i
  ]
]

ask turtles [
  setxy random-xcor random-ycor
  set direction random 360
  set speed random 2 + 1
]

go {
  clear-turtles
  setup-turtles
  stop
}

ask turtles [
  let new-xcor xcor + x-velocity
  let new-ycor ycor + y-velocity
  if (new-xcor > world-width / 2 or new-xcor < -world-width / 2) [
    set x-velocity (-x-velocity)
  ]
  if (new-ycor > world-height / 2 or new-ycor < -world-height / 2) [
    set y-velocity (-y-velocity)
  ]
  setxy new-xcor new-ycor
  set energy energy - 1
  if energy <= 0 [ die ]
]

create-turtles creates num-agents turtles
foreach range num-agents [ i ->
  ask turtle i [
    set x-velocity random 2 - 1
    set y-velocity random 2 - 1
    set energy 100
    set id i
  ]
]

ask turtles [
  setxy random-xcor random-ycor
  set direction random 360
  set speed random 2 + 1
]

go {
  clear-turtles
  create-turtles
  stop
}

ask turtles [
  let new-xcor xcor + x-velocity
  let new-ycor ycor + y-velocity
  if (new-xcor > world-width / 2 or new-xcor < -world-width / 2) [
    set x-velocity (-x-velocity)
  ]
  if (new-ycor > world-height / 2 or new-ycor < -world-height / 2) [
    set y-velocity (-y-velocity)
  ]
  setxy new-xcor new-ycor
  set energy energy - 1
  if energy <= 0 [ die ]
]
