 CREATE PROCEDURE DMG_OrdNbr_AddrOther
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@AddrID varchar(10)
AS
	select	distinct Address.*
	from	Address
	join	SOSched ON SOSched.ShipAddrID = Address.AddrID
	where	SOSched.CpnyID = @CpnyID
	and	SOSched.OrdNbr = @OrdNbr
	and	Address.AddrID like @AddrID
	order by Address.AddrID


