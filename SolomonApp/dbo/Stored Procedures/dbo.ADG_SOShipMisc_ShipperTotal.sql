 create proc ADG_SOShipMisc_ShipperTotal
	@cpnyid		varchar(10),
	@shipperid	varchar(15)
as
	select		coalesce(sum(CuryMiscChrg), 0),
			coalesce(sum(MiscChrg), 0)
	from		SOShipMisc
	where		CpnyID = @cpnyid
	  and		ShipperID = @shipperid
	group by	CpnyID, ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipMisc_ShipperTotal] TO [MSDSL]
    AS [dbo];

