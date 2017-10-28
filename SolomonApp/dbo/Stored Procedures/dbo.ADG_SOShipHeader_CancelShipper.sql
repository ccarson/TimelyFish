 CREATE PROCEDURE ADG_SOShipHeader_CancelShipper
	@CpnyID varchar( 10 ),
	@ShipperID varchar( 15 ),
	@NextFunctionID varchar( 8 ),
	@NextFunctionClass varchar( 4 ),
	@Cancelled integer
AS
	UPDATE 	SOShipHeader
	SET 	NextFunctionID = @NextFunctionID,
		NextFunctionClass = @NextFunctionClass,
		Cancelled = @Cancelled,
		DateCancelled = GETDATE()
	WHERE 	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipHeader_CancelShipper] TO [MSDSL]
    AS [dbo];

