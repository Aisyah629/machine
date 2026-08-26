with Ada.Text_IO;

package body Spark_Data_Engine is

   pragma Precondition (Vector'Length <= 1_000_000);

   procedure Initialize
     (Vector      : in out Data_Vector)
   is
   begin
      Vector.Clear;
   end Initialize;

   procedure Add_Element
     (Vector      : in out Data_Vector;
      Element     :        Data_Element)
   is
   begin
      pragma Assert (Verify_Element (Element));
      Vector.Append (Element);
   end Add_Element;

   function Verify_Element
     (Element     : Data_Element)
      return Boolean
   is
   begin
      return Element > -2_147_483_648 and then Element < 2_147_483_647;
   end Verify_Element;

   function Process_Data
     (Vector      :        Data_Vector)
      return Processing_Result
   is
      Result      : Processing_Result := (Success => (Kind => Success, Processed_Elements => 0), Failure => (others => <>));
      Sum         : Long_Integer := 0;
      Count       : Natural := Natural'Last;
   begin
      if Vector.Length = 0 then
         Result := (Kind => Failure, Error_Message => (1 .. 14 => 'I', 15 .. 256 => ' '), -1);
         return Result;
      end if;

      if Vector.Length > Count then
         Result := (Kind => Failure, Error_Message => (1 .. 19 => 'E', 20 .. 256 => ' '), -2);
         return Result;
      end if;

      Count := Vector.Length;
      for I in Vector.First_Index .. Vector.Last_Index loop
         declare
            Element : constant Data_Element := Vector.Element (I);
         begin
            pragma Assert (Verify_Element (Element));
            Sum := Sum + Element;
            Result.Processed_Elements := Result.Processed_Elements + 1;
         end;
      end loop;

      return Result;
   end Process_Data;

   function Sum_Elements
     (Vector      :        Data_Vector)
      return Data_Element
   is
      Sum : Long_Integer := 0;
   begin
      for I in Vector.First_Index .. Vector.Last_Index loop
         Sum := Sum + Vector.Element (I);
      end loop;
      return Sum;
   end Sum_Elements;

   function Mean_Element
     (Vector      :        Data_Vector)
      return Data_Element
   is
   begin
      if Vector.Length = 0 then
         return 0;
      end if;
      return Sum_Elements (Vector) / Vector.Length;
   end Mean_Element;

   function Is_Valid_Vector
     (Vector      :        Data_Vector)
      return Boolean
   is
   begin
      --  In a full SPARK tool, this would include invariants
      return Vector.Length >= 0;
   end Is_Valid_Vector;

   procedure Safe_Clear
     (Vector      : in out Data_Vector)
   is
   begin
      Vector.Clear;
   end Safe_Clear;

end Spark_Data_Engine;
