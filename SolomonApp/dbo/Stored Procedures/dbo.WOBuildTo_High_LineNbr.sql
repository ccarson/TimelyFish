 CREATE PROCEDURE WOBuildTo_High_LineNbr
   @WONbr       varchar( 16 ),
   @Status      varchar( 1 )
AS
   SELECT TOP 1 LineNbr
   FROM         WOBuildTo
   WHERE        WONbr = @WONbr
   		and Status = @Status
   ORDER BY     WONbr, Status, LineNbr DESC


