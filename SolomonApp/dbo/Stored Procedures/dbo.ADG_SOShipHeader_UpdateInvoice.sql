 CREATE PROCEDURE ADG_SOShipHeader_UpdateInvoice
	@CpnyID 	varchar( 10 ),
	@ShipperID 	varchar( 15 ),
	@InvcNbr	varchar( 15 ) = null,
	@InvcDate	smalldatetime = null,
	@PerPost	varchar( 6 ) = null
AS
	UPDATE 	SOShipHeader
	SET 	InvcNbr = coalesce(@InvcNbr, InvcNbr), InvcDate = coalesce(@InvcDate, InvcDate), PerPost = coalesce(@PerPost, PerPost)
	WHERE 	CpnyID = @CpnyID
	  AND	ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipHeader_UpdateInvoice] TO [MSDSL]
    AS [dbo];

