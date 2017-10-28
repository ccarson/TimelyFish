 create procedure DMG_GetCompanyBaseCuryID
	@CpnyID		varchar(10),
	@BaseCuryID	varchar(4) OUTPUT

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	select	@BaseCuryID = ltrim(rtrim(BaseCuryID))
	from	vs_Company (NOLOCK)
	where	CpnyID = @CpnyID

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
    ON OBJECT::[dbo].[DMG_GetCompanyBaseCuryID] TO [MSDSL]
    AS [dbo];

