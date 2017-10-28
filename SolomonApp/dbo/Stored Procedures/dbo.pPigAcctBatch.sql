CREATE PROC pPigAcctBatch
AS
Select LastBatNbr
From
cftPigAccountingSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pPigAcctBatch] TO [MSDSL]
    AS [dbo];

