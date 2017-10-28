 CREATE PROCEDURE ADG_CRTSH_GetSOLot
	@CpnyID varchar( 10 ),
	@OrdNbr varchar( 15 ),
	@LineRef varchar( 5 ),
	@SchedRef varchar( 5 ),
	@LotSerRef varchar( 5 )
AS
		SELECT *
		FROM SOLot
		WHERE CpnyID = @CpnyID
		   AND OrdNbr = @OrdNbr
		   AND LineRef = @LineRef
		   AND SchedRef = @SchedRef
		   AND LotSerRef = @LotSerRef

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


