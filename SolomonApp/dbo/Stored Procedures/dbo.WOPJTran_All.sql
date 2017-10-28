 CREATE PROCEDURE WOPJTran_All
   @Project    varchar( 16 ),
   @Task       varchar( 32 ),
   @Acct       varchar( 16 )

AS
   SELECT      *
   FROM     PJTran LEFT JOIN PJTranEx
            ON PJTran.FiscalNo = PJTranEx.FiscalNo and
            PJTran.System_CD = PJTranEx.System_CD and
            PJTran.Batch_ID = PJTranEx.Batch_ID and
            PJTran.Detail_Num = PJTranEx.Detail_Num
   WHERE    PJTran.Project = @Project and
            PJTran.PJT_Entity LIKE @Task and
            PJTran.Acct LIKE @Acct
   ORDER BY PJTran.Trans_Date DESC, PJTran.System_CD, PJtran.Batch_ID, PJTran.Detail_Num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJTran_All] TO [MSDSL]
    AS [dbo];

