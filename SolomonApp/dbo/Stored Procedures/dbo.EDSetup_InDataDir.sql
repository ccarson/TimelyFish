 Create Proc EDSetup_InDataDir As
Select InDataDir From EDSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSetup_InDataDir] TO [MSDSL]
    AS [dbo];

