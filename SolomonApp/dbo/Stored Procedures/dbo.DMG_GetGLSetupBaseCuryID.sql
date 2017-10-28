 create procedure DMG_GetGLSetupBaseCuryID
	@BaseCuryID	varchar(4) OUTPUT
as
	select	@BaseCuryID = ltrim(rtrim(BaseCuryID))
	from	GLSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @BaseCuryID = ''
		return 0	--Failure
	end
	else begin
		--select @BaseCuryID
		return 1	--Success
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetGLSetupBaseCuryID] TO [MSDSL]
    AS [dbo];

