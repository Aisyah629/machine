package Data_Processor with Preelaborable_Initialization is
   type Record_ID is new Integer range 1 .. 10_000;
   type Metric_Value is new Float range -1_000_000.0 .. 1_000_000.0;

   type Data_Record is record
      ID         : Record_ID;
      Value      : Metric_Value;
      Category   : Integer;
      Processed  : Boolean := False;
   end record;

   type Data_Set is array (Positive range <>) of Data_Record;

   type Data_Processing_Error is exception;

   function Create_Initial_Set return Data_Set;
   pragma Contract_Coverage (Create_Initial_Set);

   function Process_Data (Input : Data_Set) return Data_Set;
   pragma Contract_Coverage (Process_Data);

   procedure Display_Results (Set : Data_Set);

end Data_Processor;
