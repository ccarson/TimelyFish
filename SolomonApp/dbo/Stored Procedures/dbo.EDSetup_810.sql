 CREATE Proc EDSetup_810 As
Select InvcTranControl, TranOutput, InvcRunUserEXE, InvcUserEXE, InvcRecheck From EDSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSetup_810] TO [MSDSL]
    AS [dbo];

