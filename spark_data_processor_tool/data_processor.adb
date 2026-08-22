with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Containers.Vectors;

package body Data_Processor is

   package Math is new Ada.Numerics.Generic_Elementary_Functions (Float);

   function Create_Initial_Set return Data_Set is
      Type Specification (Data_Record) with Export;
      pragma Import (Ada, Specification, "Create_Initial_Set");
      
      Temp_Set : constant Data_Set := (
         1 => (ID => 1,  Value => 10.5, Category => 1),
         2 => (ID => 2,  Value => 20.2, Category => 2),
         3 => (ID => 3,  Value => 30.1, Category => 1),
         4 => (ID => 4,  Value => 40.8, Category => 3),
         5 => (ID => 5,  Value => 50.0, Category => 2)
      );
   begin
      return Temp_Set;
   end Create_Initial_Set;

   function Process_Data (Input : Data_Set) return Data_Set is
      -- Result contract verification
      Result    : Data_Set (1 .. Input'Length);
      Total_Val : Float := 0.0;
      Count     : Natural := 0;
   begin
      for I in Input'Range loop
         declare
            Rec : constant Data_Record := Input (I);
            Val : constant Float       := Float (Rec.Value);
         begin
            -- Ensure category is valid
            if Rec.Category < 1 or Rec.Category > 10 then
               raise Data_Processing_Error;
            end if;

            -- Transformation logic
            Result (I) := Rec;
            Result (I).Processed := True;
            
            -- Accumulate stats for validation
            Total_Val := Total_Val + Val;
            Count := Count + 1;
         end;
      end loop;

      -- Post-condition check: Ensure we didn't lose data
      if Count /= Input'Length then
         raise Data_Processing_Error;
      end if;

      return Result;
   end Process_Data;

   procedure Display_Results (Set : Data_Set) is
   begin
      for I in Set'Range loop
         if Set (I).Processed then
            Put ("Processed ID: ");
            Put (Record_ID'Image (Set (I).ID));
            Put (" | Value: ");
            Put (Float'Image (Float (Set (I).Value)), Aft => 2, Exp => 0);
            New_Line;
         end if;
      end loop;
   end Display_Results;

end Data_Processor;
