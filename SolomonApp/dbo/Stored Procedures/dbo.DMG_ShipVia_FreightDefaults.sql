 create proc DMG_ShipVia_FreightDefaults
	@CpnyID		varchar(10),
	@ShipViaID	varchar(10),
	@DfltFrtAmt	decimal(25,9) OUTPUT,
	@DfltFrtMthd	varchar(1) OUTPUT
as
	select	@DfltFrtAmt = DfltFrtAmt,
		@DfltFrtMthd = ltrim(rtrim(DfltFrtMthd))
	from	ShipVia (NOLOCK)
	where	CpnyID = @CpnyID
	  and	ShipViaID = @ShipViaID

	if @@ROWCOUNT = 0 begin
		set @DfltFrtAmt = 0
		set @DfltFrtMthd = ''
		return 0	--Failure
	end
	else
		--select @DfltFrtAmt, @DfltFrtMthd
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ShipVia_FreightDefaults] TO [MSDSL]
    AS [dbo];

