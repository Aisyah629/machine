with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Spark_Data_Engine;
use Spark_Data_Engine;

procedure Main is
   Engine      : Data_Vector;
   Result      : Processing_Result;
   Val         : Data_Element;
begin
   --  Initialize the engine
   Initialize (Engine);

   --  Add some sample data
   Add_Element (Engine, 10);
   Add_Element (Engine, 20);
   Add_Element (Engine, 30);
   Add_Element (Engine, 40);

   --  Process data
   Result := Process_Data (Engine);

   if Result.Kind = Success then
      Ada.Text_IO.Put_Line ("Processing Successful.");
      Ada.Text_IO.Put ("Processed Elements: ");
      Ada.Integer_Text_IO.Put (Item => Result.Processed_Elements, Width => 2);
      Ada.Text_IO.Put_Line (".");
   else
      Ada.Text_IO.Put_Line ("Processing Failed.");
      Ada.Text_IO.Put_Line ("Error: " & Result.Error_Message);
   end if;

   --  Compute Sum
   Val := Sum_Elements (Engine);
   Ada.Text_IO.Put ("Sum: ");
   Ada.Integer_Text_IO.Put (Item => Val, Width => 10);
   Ada.Text_IO.New_Line;

   --  Compute Mean
   Val := Mean_Element (Engine);
   Ada.Text_IO.Put ("Mean: ");
   Ada.Integer_Text_IO.Put (Item => Val, Width => 10);
   Ada.Text_IO.New_Line;

end Main;
