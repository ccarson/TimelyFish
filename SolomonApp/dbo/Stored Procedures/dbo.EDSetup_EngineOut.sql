 Create Proc EDSetup_EngineOut As
Select EngineOut From EDSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSetup_EngineOut] TO [MSDSL]
    AS [dbo];

