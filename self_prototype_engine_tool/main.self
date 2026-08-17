"""
Self Prototype Engine Tool
A robust Self metaprogramming environment leveraging prototypal inheritance
and dynamic object modification for flexible software design.
"""

"""
Define a basic ObjectPrototype as the root of our hierarchy
"""
ObjectPrototype clone named: 'RootObject'.
RootObject printIt: [:| self |
    self print.
].

"""
Define a PrototypeManager to handle creation and modification
"""
PrototypeManager := Object clone.

PrototypeManager createPrototype: [:| name superPrototype |
    self print: 'Creating prototype: ' .. name printString.
    newPrototype := superPrototype clone.
    newPrototype setName: name.
    self prototypes append: newPrototype.
    newPrototype.
].

PrototypeManager prototypes := List new.
PrototypeManager setName: [:| name |
    self name: name.
].
PrototypeManager getName: [:| |
    self name.
].

"""
Define a dynamic MessageHandler
"""
MessageHandler := Object clone.
MessageHandler handle: [:| messageArg arguments |
    self print: 'Handling message: ' .. messageArg printString.
    self print: 'With arguments: ' .. arguments printString.
    "Simulate dynamic behavior adjustment"
    result := 'Processed: ' .. messageArg printString.
    result.
].

"""
Simulation Loop
"""
simulateSystem: [:|
    manager := PrototypeManager clone.
    obj1 := manager createPrototype: 'DynamicObject1' superPrototype: ObjectPrototype.
    obj2 := manager createPrototype: 'DynamicObject2' superPrototype: ObjectPrototype.
    
    handler := MessageHandler clone.
    
    "Iterate and modify" 
    1 to: 5 do: [:i |
        | msg | 
        msg := 'Event_' .. i printString.
        obj1 handle: msg arguments: List clone.
        handler handle: msg arguments: List clone.
    ].
    
    "Demonstrate dynamic method replacement"
    obj1 printIt: [:| | 
        self print: 'Object overridden behavior triggered!'.
    ].
    obj1 printIt.
    
    self print: 'Simulation complete.'. 
].

"""
Run Simulation
"""
simulateSystem.
