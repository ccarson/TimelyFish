 CREATE PROCEDURE DMG_SOShipLineSplit_All0
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5),
	@SlsperID	varchar(10)
AS
	SELECT	*
	FROM	SOShipLineSplit
	WHERE	CpnyID = @CpnyID
	  AND	ShipperID = @ShipperID
	  AND	LineRef = @LineRef
	  AND	SlsperID = @SlsperID

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipLineSplit_All0] TO [MSDSL]
    AS [dbo];

