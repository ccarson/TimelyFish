 CREATE PROCEDURE DMG_OrdNbr_AddrVendAddress
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@VendID varchar(15),
	@OrdFromID varchar(10)
AS
	select	distinct POAddress.*
	from	POAddress
	join	SOSched ON SOSched.S4Future11 = POAddress.OrdFromID and SOSched.ShipVendID = POAddress.VendID
	where	SOSched.CpnyID = @CpnyID
	and	SOSched.OrdNbr = @OrdNbr
	and	POAddress.VendID = @VendID
	and	POAddress.OrdFromID like @OrdFromID
	order by POAddress.VendID, POAddress.OrdFromID


