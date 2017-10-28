 CREATE PROCEDURE ADG_SOShipHeader_InvcNbr
	@CpnyID varchar(10),
	@InvcNbr varchar(10)
AS
	SELECT *
	FROM SOShipHeader
	WHERE CpnyID = @CpnyID AND
		InvcNbr LIKE @InvcNbr
	ORDER BY InvcNbr, CustID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


