 CREATE PROCEDURE DMG_OrdNbr_AddrVendor
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@VendID varchar(15)
AS
	select	distinct Vendor.*
	from	Vendor
	join	SOSched ON SOSched.ShipVendID = Vendor.VendID
	where	SOSched.CpnyID = @CpnyID
	and	SOSched.OrdNbr = @OrdNbr
	and	Vendor.VendID like @VendID
	order by Vendor.VendID


