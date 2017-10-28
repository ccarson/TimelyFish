 CREATE PROCEDURE WOHeader_PJProj_PS_All
   @ProcStage  varchar( 1 ),
   @WONbr      varchar( 16 )
AS
   SELECT      *
   FROM        WOHeader LEFT JOIN PJProj
               ON WOHeader.WONbr = PJProj.Project
   WHERE       ProcStage LIKE @ProcStage and
               WONbr LIKE @WONbr
   ORDER BY    WOHeader.WONbr


