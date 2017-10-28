 CREATE PROCEDURE WOHeader_WO_Active
   @WONbr      varchar( 16 )
AS
   SELECT      *
   FROM        WOHeader
   WHERE       Status = 'A' and
               ProcStage IN ('P','F','R') and
               WONbr LIKE @WONbr
   ORDER BY    WONbr


