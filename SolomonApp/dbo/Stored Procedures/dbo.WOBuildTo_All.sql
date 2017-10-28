 CREATE PROCEDURE WOBuildTo_All
   @WONbr      varchar( 16 ),
   @Status     varchar( 1 )
AS
   SELECT      *
   FROM        WOBuildTo
   WHERE       WONbr = @WONbr and
               Status LIKE @Status
   ORDER BY    WONbr, Status, LineNbr


