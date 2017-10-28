 Create Proc EDGLSetup_GetBaseCuryId As
Select BaseCuryId From GLSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDGLSetup_GetBaseCuryId] TO [MSDSL]
    AS [dbo];

