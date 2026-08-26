with Ada.Containers.Vectors;
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package Spark_Data_Engine is
   pragma Elaborate_All;

   --  Type definitions
   subtype Data_Element is Long_Integer;
   type Data_Vector is new Ada.Containers.Indexed_Vectors
     (Index_Type   => Positive,
      Element_Type => Data_Element)
   with Pack;

   --  Processing Result
   type Processing_Result (Kind : Result_Kind) is record
      case Kind is
         when Success =>
            Processed_Elements : Natural := 0;
         when Failure =>
            Error_Message      : String (1 .. 256) := (others => '\0');
            Error_Code         : Integer;  --  -1 for internal error
      end case;
   end record;

   type Result_Kind is (Success, Failure);

   --  Core Engine Operations
   procedure Initialize
     (Vector      : in out Data_Vector);

   procedure Add_Element
     (Vector      : in out Data_Vector;
      Element     :        Data_Element);

   function Process_Data
     (Vector      :        Data_Vector)
      return Processing_Result;

   function Sum_Elements
     (Vector      :        Data_Vector)
      return Data_Element;

   function Mean_Element
     (Vector      :        Data_Vector)
      return Data_Element;

   function Is_Valid_Vector
     (Vector      :        Data_Vector)
      return Boolean;

private
   --  Internal helper functions for formal verification
   function Verify_Element
     (Element     : Data_Element)
      return Boolean;
   
   procedure Safe_Clear
     (Vector      : in out Data_Vector);
end Spark_Data_Engine;
