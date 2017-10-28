 CREATE PROCEDURE WOHeader_PJProj_All
   @Status     varchar( 1 )
AS
   SELECT      *
   FROM        WOHeader LEFT JOIN PJProj
               ON WOHeader.WONbr = PJProj.Project
   WHERE       WOHeader.ProcStage = 'C' and
               WOHeader.Status LIKE @Status
   ORDER BY    WOHeader.WONbr


