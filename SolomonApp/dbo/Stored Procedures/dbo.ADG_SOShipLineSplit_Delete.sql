 CREATE PROCEDURE ADG_SOShipLineSplit_Delete
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5),
	@SlsPerID	varchar(10)
AS
	IF @CpnyID <> '%' and @ShipperID <> '%'
		DELETE	FROM SOShipLineSplit
		WHERE	CpnyID = @CpnyID
		AND	ShipperID = @ShipperID
		AND	LineRef + '' LIKE @LineRef
		AND	SlsPerID + '' LIKE @SlsPerID
	ELSE
		DELETE	FROM SOShipLineSplit
		WHERE	CpnyID LIKE @CpnyID
		AND	ShipperID LIKE @ShipperID
		AND	LineRef LIKE @LineRef
		AND	SlsPerID LIKE @SlsPerID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipLineSplit_Delete] TO [MSDSL]
    AS [dbo];

