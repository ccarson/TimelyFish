 create proc ADG_UpdtShip_OpenShipperLineCnt
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@OrdLineRef	varchar(5),
	@OrdSchedRef	varchar(5),
	@ShipperID	varchar(15)		-- Current ShipperID (for exclusion).
as
	select	count(*)

	from	SOShipLine L join SOShipSched S
	on	L.CpnyID = S.CpnyID
	and	L.ShipperID = S.ShipperID
	and	L.LineRef = S.ShipperLineRef

	where	L.CpnyID = @CpnyID
	  and	L.OrdNbr = @OrdNbr
	  and	L.OrdLineRef = @OrdLineRef
	  and	S.OrdSchedRef = @OrdSchedRef
	  and	L.ShipperID <> @ShipperID
	  and	L.Status = 'O'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


