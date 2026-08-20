model modelica_interactive_diagnostic_tool
  "Interactive diagnostic tool for Modelica systems"
  parameter Real threshold = 5.0 "Diagnostic threshold";
  parameter Real timeConstant = 1.0 "Time constant for system response";
  Real x(start=1);
  Real dx_dt;
  Boolean alert;
  Real diagnosticValue;
  annotation(
    uses(Modelica(version="4.0.0"))
  );
  equation
    dx_dt = -x / timeConstant;
    x' = dx_dt;
    diagnosticValue = x;
    alert = x > threshold;
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6),
    diagram(
      animation(
        text(string(x), extent = {{-100, -100}, {100, 100}})
      )
    )
  );
end modelica_interactive_diagnostic_tool;
