 CREATE PROCEDURE WOHeader_WOType_All
   @WOType1    varchar( 1 ),
   @WOType2    varchar( 1 ),
   @WONbr      varchar( 16 )
AS
   SELECT      *
   FROM        WOHeader
   WHERE       ProcStage IN (' ','R') and
               (WOType = @WOType1 or WOType = @WOType2) and
               WONbr LIKE @WONbr
   ORDER BY    WONbr


