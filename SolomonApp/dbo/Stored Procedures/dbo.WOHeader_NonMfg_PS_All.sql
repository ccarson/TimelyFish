 CREATE PROCEDURE WOHeader_NonMfg_PS_All
   @ProcStage  varchar( 1 ),
   @WONbr      varchar( 16 )
AS
   SELECT      *
   FROM        WOHeader
   WHERE       WOType = 'P' and
               ProcStage LIKE @ProcStage and
               WONbr LIKE @WONbr
   ORDER BY    WONbr


