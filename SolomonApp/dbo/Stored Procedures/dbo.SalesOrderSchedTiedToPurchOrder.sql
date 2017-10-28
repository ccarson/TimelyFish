
Create PROC SalesOrderSchedTiedToPurchOrder @OrdNbr VarChar(15), @CpnyID VarChar(10), @LineRef VarChar(5), @SchedRef VarChar(5)
AS
    SELECT PONbr
    FROM   POAlloc p With(nolock)
    WHERE p.SOOrdNbr = @OrdNbr
      AND p.CpnyID = @CpnyID
      AND p.SOLineRef = @LineRef
      AND p.SOSchedRef = @SchedRef


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SalesOrderSchedTiedToPurchOrder] TO [MSDSL]
    AS [dbo];

