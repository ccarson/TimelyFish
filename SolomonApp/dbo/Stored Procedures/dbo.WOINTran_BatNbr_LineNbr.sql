 CREATE PROCEDURE WOINTran_BatNbr_LineNbr
   @BatNbr    varchar( 10 ),
   @TranType  varchar( 2 )
AS
   SELECT     *
   FROM       INTran
   WHERE      BatNbr =  @BatNbr and
              TranType = @TranType
   ORDER BY   BatNbr, LineNbr


