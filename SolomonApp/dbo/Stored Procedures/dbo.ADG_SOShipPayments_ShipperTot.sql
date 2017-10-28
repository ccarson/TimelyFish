 create proc ADG_SOShipPayments_ShipperTot
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select	sum(CuryPmtAmt),
		sum(PmtAmt)

	from	SOShipPayments
	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID
	group by
		CpnyID,
		ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipPayments_ShipperTot] TO [MSDSL]
    AS [dbo];

