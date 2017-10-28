 create proc ADG_UpdtShip_ZeroQtyShip
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	update	SOShipLine
	set	QtyShip = 0,
		LUpd_DateTime = GetDate(),
		LUpd_Prog = 'SQL40400',
		LUpd_User = 'SQL40400'

	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

	update	SOShipLot
	set	QtyShip = 0,
		LUpd_DateTime = GetDate(),
		LUpd_Prog = 'SQL40400',
		LUpd_User = 'SQL40400'

	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

	update	SOSched
	set		LotSerialEntered = 1,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = 'SQL40400',
			LUpd_User = 'SQL40400'
	from	SOShipLot
		join	SOSched
	on		SOSched.CpnyID = SOShipLot.CpnyID
	and		SOSched.OrdNbr = SOShipLot.OrdNbr
	and		SOSched.LineRef = SOShipLot.OrdLineRef
	and		SOSched.SchedRef = SOShipLot.OrdSchedRef

	where	SOShipLot.CpnyID = @CpnyID
	  and	SOShipLot.ShipperID = @ShipperID

	update	SOLot
	set		Status = 'O',
			LUpd_DateTime = GetDate(),
			LUpd_Prog = 'SQL40400',
			LUpd_User = 'SQL40400'
	from	SOShipLot
		join	SOLot
	on		SOLot.CpnyID = SOShipLot.CpnyID
	and		SOLot.OrdNbr = SOShipLot.OrdNbr
	and		SOLot.LineRef = SOShipLot.OrdLineRef
	and		SOLot.SchedRef = SOShipLot.OrdSchedRef
	and		SOLot.LotSerRef = SOShipLot.OrdLotSerRef

	where	SOShipLot.CpnyID = @CpnyID
	  and	SOShipLot.ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


