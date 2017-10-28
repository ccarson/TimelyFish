 Create Proc EDSetup_OutDataDir As
Select OutDataDir From EDSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSetup_OutDataDir] TO [MSDSL]
    AS [dbo];

