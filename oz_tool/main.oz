* Main Entry Point for Oz Constraint Logic Programming Solver
* Language: Oz

functor
import
 Application
 System
import
 solver_module
open System (Message) 

declare
 Solver = {Solver.createSolver}

{Solver.addConstraint 'eq(X,Y)'}
{Solver.addConstraint 'lt(Y,Z)'}
{Solver.addConstraint 'gt(X,Z)'}

{Solver.addVariable X}
{Solver.addVariable Y}
{Solver.addVariable Z}

if {Solver.solve}
 then Message.show('Constraint logic programming solver found a solution!')
else Message.show('Constraint logic programming solver found no solution.')
end
end
