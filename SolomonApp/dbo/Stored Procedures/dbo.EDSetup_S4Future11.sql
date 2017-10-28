 Create Proc EDSetup_S4Future11 As
Select S4Future11 From EDSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSetup_S4Future11] TO [MSDSL]
    AS [dbo];

