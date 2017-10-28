 CREATE PROCEDURE WOPJTran_Filter
   @Project       varchar( 16 ),
   @Task          varchar( 32 ),
   @Acct          varchar( 16 ),
   @TranDateBeg   smalldatetime,
   @TranDateEnd   smalldatetime,
   @Employee      varchar ( 10 ),
   @Vendor_Num    varchar ( 15 )

AS
   SELECT      *
   FROM        PJTran LEFT JOIN PJTranEx
               ON PJTran.FiscalNo = PJTranEx.FiscalNo and
               PJTran.System_CD = PJTranEx.System_CD and
               PJTran.Batch_ID = PJTranEx.Batch_ID and
               PJTran.Detail_Num = PJTranEx.Detail_Num
   WHERE       PJTran.Project = @Project and
               PJTran.PJT_Entity LIKE @Task and
               PJTran.Acct LIKE @Acct and
               PJTran.Trans_Date BETWEEN @TranDateBeg and @TranDateEnd and
               PJTran.Employee LIKE @Employee and
               PJTran.Vendor_Num LIKE @Vendor_Num
   ORDER BY    PJTran.Trans_Date DESC, PJTran.System_CD, PJtran.Batch_ID, PJTran.Detail_Num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJTran_Filter] TO [MSDSL]
    AS [dbo];

