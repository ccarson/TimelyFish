 create proc DMG_UpdateShipper_QueueInvt_CPSOff
	@CpnyID		varchar(10),
	@ShipperID   	varchar(15)
as
	select
		h.BuildInvtID,
		h.SiteID,
		l.InvtID,
		l.SiteID

	from	SOShipLine	l

  	  join	SOShipHeader	h
	  on	h.CpnyID = l.CpnyID
	  and	h.ShipperID = l.ShipperID

	where	l.CpnyID = @CpnyID and
		l.ShipperID = @ShipperID

	order by l.invtid, l.siteid

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


