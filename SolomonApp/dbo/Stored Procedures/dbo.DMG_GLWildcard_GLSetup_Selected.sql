 create proc DMG_GLWildcard_GLSetup_Selected
	@ValidateAcctSub	smallint OUTPUT,
	@ValidateAtPosting	smallint OUTPUT
as
	select	@ValidateAcctSub = ValidateAcctSub,
		@ValidateAtPosting = ValidateAtPosting
	from	GLSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @ValidateAcctSub = 0
		set @ValidateAtPosting = 0
		return 0	--Failure
	end
	else
		return 1	--Success


