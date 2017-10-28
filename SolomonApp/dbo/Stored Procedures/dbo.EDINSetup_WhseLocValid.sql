 Create Proc EDINSetup_WhseLocValid As
Select WhseLocValid From INSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDINSetup_WhseLocValid] TO [MSDSL]
    AS [dbo];

