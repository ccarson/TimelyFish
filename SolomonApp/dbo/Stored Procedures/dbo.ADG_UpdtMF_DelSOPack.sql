 create proc ADG_UpdtMF_DelSOPack
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	delete		SOShipPack
	where		CpnyID = @CpnyID
	  and		ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


