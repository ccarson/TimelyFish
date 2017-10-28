 create procedure DMG_GetCurrencyPrecision
	@CuryID	varchar(4),
	@DecPl	smallint OUTPUT
as
	select	@DecPl = DecPl
	from	Currncy (NOLOCK)
	where	CuryID = @CuryID

	if @@ROWCOUNT = 0 begin
		set @DecPl = 0
		return 0	--Failure
	end
	else begin
		--select @DecPl
		return 1	--Success
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetCurrencyPrecision] TO [MSDSL]
    AS [dbo];

