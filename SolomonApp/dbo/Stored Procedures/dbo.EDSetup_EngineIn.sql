 Create Proc EDSetup_EngineIn As
Select EngineIn From EDSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSetup_EngineIn] TO [MSDSL]
    AS [dbo];

