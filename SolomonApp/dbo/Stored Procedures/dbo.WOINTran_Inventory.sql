 CREATE PROCEDURE WOINTran_Inventory
   @BatNbr     varchar( 10 ),
   @TranType   varchar( 2  )

AS
   SELECT      *
   FROM        INTran LEFT JOIN Inventory
               ON INTran.InvtID = Inventory.InvtID
   WHERE       INTran.Rlsed = 1 and
               INTran.TranType = @TranType and
               INTran.BatNbr = @BatNbr
   ORDER BY    INTran.BatNbr, INTran.LineNbr


