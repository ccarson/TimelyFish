 CREATE PROCEDURE ADG_SOShipHeader_ShipperIDInvcNbr
	@CpnyID varchar(10),
	@InvcNbr varchar(10)
AS
	SELECT ShipperID
	FROM SOShipHeader
	WHERE CpnyID = @CpnyID AND
		InvcNbr = @InvcNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipHeader_ShipperIDInvcNbr] TO [MSDSL]
    AS [dbo];

