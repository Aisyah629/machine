with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;
with Data_Processor;          use Data_Processor;

procedure Main is
   Input_Data : Data_Set := Create_Initial_Set;
   Result     : Data_Set;
begin
   Put_Line("Starting Spark Data Processor...");
   
   begin
      Result := Process_Data (Input_Data);
      Display_Results (Result);
      Put_Line("Processing complete.");
   exception
      when E : Data_Processing_Error =>
         Put_Line ("Data Processing Error: " & Ada.Exceptions.Exception_Information (E));
   end;
end Main;
