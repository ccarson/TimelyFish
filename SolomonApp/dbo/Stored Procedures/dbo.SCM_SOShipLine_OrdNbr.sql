 CREATE PROCEDURE SCM_SOShipLine_OrdNbr
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
AS
	select	L.*
	from	SOShipLine L, SOShipHeader H
	where	L.CpnyID = H.CpnyID
	and	L.ShipperID = H.ShipperID
	and	L.CpnyID = @CpnyID
	and	L.OrdNbr = @OrdNbr
	and	H.Cancelled = 0
		order by L.OrdNbr, L.OrdLineRef, L.ShipperID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_SOShipLine_OrdNbr] TO [MSDSL]
    AS [dbo];

