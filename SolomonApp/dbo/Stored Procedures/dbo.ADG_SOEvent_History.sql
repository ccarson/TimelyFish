 CREATE PROCEDURE ADG_SOEvent_History
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@ShipperID	varchar(15)
AS
	select	*
	from	SOEvent
	where	CpnyID = @CpnyID
	and	OrdNbr like @OrdNbr
	and	ShipperID like @ShipperID
	order by EventID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


