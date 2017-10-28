 CREATE PROCEDURE WOHeader_WOType_Active
   @WOType     varchar( 1 ),
   @WONbr      varchar( 16 )
AS
   SELECT      *
   FROM        WOHeader
   WHERE       ProcStage IN ('P','F','R',' ') and
               Status = 'A' and
               WOType = @WOType and
               WONbr LIKE @WONbr
   ORDER BY    WONbr


