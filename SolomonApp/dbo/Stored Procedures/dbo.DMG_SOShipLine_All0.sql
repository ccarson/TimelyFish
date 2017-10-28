 CREATE PROCEDURE DMG_SOShipLine_All0
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5)
AS
	SELECT	*
	FROM	SOShipLine
	WHERE	CpnyID = @CpnyID
	  AND	ShipperID = @ShipperID
	  AND	LineRef = @LineRef

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipLine_All0] TO [MSDSL]
    AS [dbo];

