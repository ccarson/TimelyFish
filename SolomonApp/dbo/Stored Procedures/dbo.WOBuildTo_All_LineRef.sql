 CREATE PROCEDURE WOBuildTo_All_LineRef
   @WONbr      varchar( 16 ),
   @Status     varchar( 1 ),
   @LineRef    varchar( 5 )
AS
   SELECT      *
   FROM        WOBuildTo
   WHERE       WONbr = @WONbr and
               Status LIKE @Status and
               LineRef LIKE @LineRef
   ORDER BY    WONbr, Status, LineRef


