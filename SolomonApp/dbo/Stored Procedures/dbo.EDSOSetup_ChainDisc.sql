 Create Proc EDSOSetup_ChainDisc As
Select ChainDiscEnabled From SOSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOSetup_ChainDisc] TO [MSDSL]
    AS [dbo];

