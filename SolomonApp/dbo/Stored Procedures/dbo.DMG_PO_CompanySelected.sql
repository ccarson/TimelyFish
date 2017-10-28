 create procedure DMG_PO_CompanySelected
	@CpnyID		varchar(10),
	@CpnyCOA	varchar(10) OUTPUT,
	@CpnySub	varchar(10) OUTPUT

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	select	@CpnyCOA = ltrim(rtrim(CpnyCOA)),
		@CpnySub = ltrim(rtrim(CpnySub))
	from	VS_COMPANY (NOLOCK)
	where	CpnyID = @CpnyID

	if @@ROWCOUNT = 0 begin
		set @CpnyCOA = ''
		set @CpnySub = ''
		return 0	--Failure
	end
	else
		return 1	--Success


