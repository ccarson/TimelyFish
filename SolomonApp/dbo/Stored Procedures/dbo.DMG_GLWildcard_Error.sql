 create proc DMG_GLWildcard_Error
	@ErrorAcct	varchar(10) OUTPUT,
	@ErrorSub	varchar(30) OUTPUT
as
	select	@ErrorAcct = ltrim(rtrim(ErrorAcct)),
		@ErrorSub = ltrim(rtrim(ErrorSub))
	from	SOSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @ErrorAcct = ''
		set @ErrorSub = ''
		return 0	--Failure
	end
	else
		--select @ErrorAcct,@ErrorSub
		return 1	--Success


