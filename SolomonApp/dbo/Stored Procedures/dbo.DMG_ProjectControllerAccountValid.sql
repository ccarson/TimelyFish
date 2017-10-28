 create procedure DMG_ProjectControllerAccountValid
	@gl_acct	varchar(10)
as
	if (
	select	count(*)
	from	PJ_Account (NOLOCK)
	where	gl_acct = @gl_acct
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success


