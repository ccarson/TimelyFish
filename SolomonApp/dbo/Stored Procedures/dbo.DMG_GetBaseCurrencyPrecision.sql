 create procedure DMG_GetBaseCurrencyPrecision
	@CpnyID	varchar(10),
	@DecPl	smallint OUTPUT

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	select	@DecPl = DecPl
	from	Currncy (NOLOCK)
	where	CuryID in (select BaseCuryID from vs_Company (NOLOCK) where CpnyID = @CpnyID)

	if @@ROWCOUNT = 0 begin
		set @DecPl = 0
		return 0	--Failure
	end
	else begin
		--select @Decpl
		return 1	--Success
	end


