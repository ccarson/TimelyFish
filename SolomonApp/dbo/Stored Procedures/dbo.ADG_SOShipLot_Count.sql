 CREATE PROCEDURE ADG_SOShipLot_Count
	@CpnyID 		varchar(10),
	@ShipperID 		varchar(15),
	@LineRef 		varchar(5)
AS

	SELECT 	count(*)
	FROM 	SOShipLot
	WHERE 	SOShipLot.CpnyID = @CpnyID
	  AND	SOShipLot.ShipperID LIKE @ShipperID
	  AND	SOShipLot.LineRef LIKE @LineRef
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipLot_Count] TO [MSDSL]
    AS [dbo];

