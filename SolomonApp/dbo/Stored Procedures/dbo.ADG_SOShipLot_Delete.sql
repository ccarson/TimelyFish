 CREATE PROCEDURE ADG_SOShipLot_Delete
		@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5),
	@LotSerRef	varchar(5)
AS
	IF @CpnyID <> '%' AND @ShipperID <> '%'
		DELETE FROM SOShipLot
		WHERE	CpnyID = @CpnyID AND
			ShipperID = @ShipperID AND
			LineRef + '' LIKE @LineRef AND
			LotSerRef + '' LIKE @LotSerRef
	ELSE
		DELETE FROM SOShipLot
		WHERE	CpnyID LIKE @CpnyID AND
			ShipperID LIKE @ShipperID AND
			LineRef LIKE @LineRef AND
			LotSerRef LIKE @LotSerRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipLot_Delete] TO [MSDSL]
    AS [dbo];

