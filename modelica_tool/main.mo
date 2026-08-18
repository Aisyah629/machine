block modelica_tool
  parameter Real initialVelocity = 0;
  parameter Real gravity = 9.81;
  Real position(start = 0);
  Real velocity(start = initialVelocity);
  Real acceleration;
equation
  acceleration = -gravity;
  der(velocity) = acceleration;
  der(position) = velocity;
end modelica_tool;

modelica_tool modelica_tool_instance(initialVelocity=10, gravity=9.81);
