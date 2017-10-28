 create procedure DMG_SOAddrSlsperSelected
	@CustID		varchar(15),
	@ShipToID	varchar(10)
as
	select	ltrim(rtrim(SlsperID)) SlsPerID,
		CreditPct
	from	SOAddrSlsper (NOLOCK)
	where	CustID = @CustID
	and	ShipToID = @ShipToID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOAddrSlsperSelected] TO [MSDSL]
    AS [dbo];

