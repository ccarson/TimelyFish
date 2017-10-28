 create proc DMG_GLWildcard_SOSetup_Selected
	@ErrorAcct	varchar(10) OUTPUT,
	@ErrorSub	varchar(24) OUTPUT
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
		return 1	--Success


