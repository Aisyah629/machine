with Ada.Text_IO;
with Ada.Strings.Unbounded;

procedure Text_Cleaning_Tool is

   -- Constants for configuration
   Max_Char_Codes : constant Natural := 255;
   Min_Char_Code : constant Natural := 32;

   type Char_Set_Type is array (Natural range 0 .. Max_Char_Codes) of Boolean;
   Valid_Char_Set : Char_Set_Type := (others => False);

   procedure Initialize_Valid_Set (Chars_To_Keep : in String) is
      -- SPARK proof hint: ensures only printable ASCII + common whitespace are kept
      Keep_All : constant Boolean := (Chars_To_Keep'Length = 0);
   begin
      if not Keep_All then
         for C of Chars_To_Keep loop
            Valid_Char_Set (Character'Pos (C)) := True;
         end loop;
      else
         -- Default: keep letters, digits, spaces, newlines, tabs
         for I in Min_Char_Code .. Max_Char_Codes loop
            Valid_Char_Set (I) := True;
         end loop;
         Valid_Char_Set (Character'Pos (' ')) := True;
         Valid_Char_Set (Character'Pos (ASCII.LF)) := True;
         Valid_Char_Set (Character'Pos (ASCII.CR)) := True;
         Valid_Char_Set (Character'Pos (ASCII.HT)) := True;
      end if;
   end Initialize_Valid_Set;

   function Is_Valid_Char (C : Character) return Boolean is
   begin
      return Valid_Char_Set (Character'Pos (C));
   end Is_Valid_Char;

   function Clean_Line (Input_Line : in String) return Ada.Strings.Unbounded.Unbounded_String is
      Output_Str : Ada.Strings.Unbounded.Unbounded_String;
      Last_In_Word : Boolean := False;
   begin
      Ada.Strings.Unbounded.Set_Unbounded_String (Output_Str, "");
      for I in Input_Line'Range loop
         if Input_Line (I) = ' ' or Input_Line (I) = ASCII.HT then
            if Last_In_Word then
               Ada.Strings.Unbounded.Append (Output_Str, " ");
               Last_In_Word := False;
            end if;
         else
            Ada.Strings.Unbounded.Append (Output_Str, Input_Line (I));
            Last_In_Word := True;
         end if;
      end loop;
      -- Remove trailing space if any
      declare
         Len : Natural := Ada.Strings.Unbounded.Length (Output_Str);
      begin
         if Len > 0 and then
            Ada.Strings.Unbounded.To_String (Output_Str, Len) = " " then
            Ada.Strings.Unbounded.Truncate (Output_Str, Len - 1);
         end if;
      end;
      return Output_Str;
   end Clean_Line;

   Input_Lines : constant String := "  Hello   World  !  
Another Line...
   SPARK   is   great

Invalid Chars: <>&\n";
   Cleaned_Lines : constant Ada.Strings.Unbounded.Unbounded_String := Clean_Line (Input_Lines);
   Result_String : constant String := Ada.Strings.Unbounded.To_String (Cleaned_Lines);

begin
   Ada.Text_IO.Put_Line ("Original:");
   Ada.Text_IO.Put_Line (Input_Lines);
   Ada.Text_IO.Put_Line ("Cleaned:");
   Ada.Text_IO.Put_Line (Result_String);

end Text_Cleaning_Tool;
