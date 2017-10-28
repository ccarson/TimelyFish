CREATE PROC pCF507AutoTest
As
Select LastBatNbr
From
cftPigAccountingSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF507AutoTest] TO [MSDSL]
    AS [dbo];

