 CREATE PROCEDURE WOPJTran_BatchType_LineRef
   @Project    varchar( 16 ),
   @Task       varchar( 32 ),
   @LineRef    varchar( 5 ),      -- Ties back to WOMatlReq.LineRef
   @Acct       varchar( 16 ),
   @Batch_Type varchar( 4 ),
   @CommCode   varchar( 4 )       -- Comment code - type of txn

As
   SELECT      *
   FROM        PJTran, PJTranEX
   WHERE       PJTran.FiscalNo = PJTranEx.FiscalNo and
               PJTran.System_CD = PJTranEx.System_CD and
               PJTran.Batch_ID = PJTranEx.Batch_ID and
               PJTran.Detail_Num = PJTranEx.Detail_Num and
               PJTran.Project = @Project and
               PJTran.PJT_Entity = @Task and
               PJTran.Acct LIKE @Acct and
               PJTran.Batch_Type = @Batch_Type and
               Substring(PJTranEx.tr_id15,1,5) = @LineRef and
               Substring(PJTran.User1,1,4) LIKE @CommCode
   ORDER BY    PJTran.Crtd_DateTime DESC, PJTran.batch_id DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJTran_BatchType_LineRef] TO [MSDSL]
    AS [dbo];

