CREATE PROC dbo.pAutoPigAcctBatch
AS
Select LastBatNbr
From
cftPigAccountingSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pAutoPigAcctBatch] TO [MSDSL]
    AS [dbo];

