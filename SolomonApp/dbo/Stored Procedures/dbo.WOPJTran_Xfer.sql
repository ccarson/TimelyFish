 CREATE PROCEDURE WOPJTran_Xfer
   @Project    	varchar( 16 ),
   @Task       	varchar( 32 ),
   @Acct       	varchar( 16 )

AS
   SELECT      	*
   FROM        	PJTran LEFT JOIN PJTranEx
               	ON PJTran.FiscalNo = PJTranEx.FiscalNo and
               	PJTran.System_CD = PJTranEx.System_CD and
               	PJTran.Batch_ID = PJTranEx.Batch_ID and
               	PJTran.Detail_Num = PJTranEx.Detail_Num
               	LEFT JOIN INTran
               	ON PJTranEx.Invtid = INTran.InvtID and
               	PJTranEx.SiteID = INTran.SiteID and
               	PJTran.CpnyID = INTran.CpnyID and
               	Cast(PJTranEx.LotSerNbr as Int) = INTran.RecordID
   WHERE       	PJTran.Project = @Project
   		and PJTran.PJT_Entity LIKE @Task
   		and PJTran.Acct LIKE @Acct
   		and PJTranEx.InvtID <> ''
   ORDER BY    	PJTranEx.InvtID, PJTranEx.SiteID, PJTran.Trans_Date DESC, PJTran.Batch_ID DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJTran_Xfer] TO [MSDSL]
    AS [dbo];

