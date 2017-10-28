 CREATE PROCEDURE DMG_SOShipLineSplit_All3
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5)
AS
	SELECT	*
	FROM	SOShipLineSplit
	WHERE	CpnyID = @CpnyID
	  AND	ShipperID = @ShipperID
	  AND	LineRef = @LineRef
	order by CreditPct

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipLineSplit_All3] TO [MSDSL]
    AS [dbo];

