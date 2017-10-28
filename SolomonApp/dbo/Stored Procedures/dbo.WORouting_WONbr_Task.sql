 CREATE PROCEDURE WORouting_WONbr_Task
   @WONbr      varchar( 16 ),
   @Task       varchar( 32 ),
   @LineNbrbeg smallint,
   @LineNbrend smallint
AS
   SELECT      *
   FROM        WORouting LEFT JOIN Operation
               ON WORouting.OperationID = Operation.OperationID
   WHERE       WORouting.WONbr = @WONbr and
               Task = @Task and
               LineNbr Between @LineNbrbeg and @LineNbrend
   ORDER BY    WORouting.WONbr, WORouting.Task, WORouting.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WORouting_WONbr_Task] TO [MSDSL]
    AS [dbo];

