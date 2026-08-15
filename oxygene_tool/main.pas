namespace oxygene_tool;

interface

uses
  System.Console,
  System.Linq,
  System.Collections.Generic;

type
  Program = class
    public
      class method Main(args: array of String): Integer;
  end;

implementation

class method Program.Main(args: array of String): Integer;
var
  message: String;
  numbers: List<Integer>;
  sum: Integer;
begin
  message := 'Welcome to the Oxygene Tool!';
  Console.WriteLine(message);
  Console.WriteLine('--------------------------');
  
  // Demonstrating LINQ and List operations
  numbers := new List<Integer>(Array.Create(1, 2, 3, 4, 5, 6, 7, 8, 9, 10));
  
  var evenNumbers := from n in numbers where n Mod 2 = 0 select n;
  var sumEven := evenNumbers.Sum();
  
  Console.WriteLine('Even numbers in the list:');
  for each n in evenNumbers do
    Console.Write(n + ' ');
  Console.WriteLine();
  
  Console.WriteLine('Sum of even numbers: ' + sumEven.ToString());
  
  // Demonstrating a custom class instance
  var worker := new TaskWorker('OxygeneEngine');
  worker.Execute();
  
  Console.WriteLine('--------------------------');
  Console.WriteLine('Execution completed successfully.');
  
  Console.ReadKey();
  exit 0;
end;

type
  TaskWorker = class
  private
    f_name: String;
  public
    constructor Create(name: String);
    method Execute();
  end;

implementation

constructor TaskWorker.Create(name: String);
begin
  f_name := name;
end;

method TaskWorker.Execute();
begin
  Console.WriteLine('Worker initialized: ' + f_name);
  Console.WriteLine('Processing data on ' + Environment.MachineName + '...');
end;

end.
