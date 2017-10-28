 CREATE PROCEDURE ADG_SOHeader_UpdateAdminHold
	@CpnyID		varchar (10),
	@OrdNbr 	varchar (15)

AS

	UPDATE	SOHeader
	  SET	AdminHold = 1
	WHERE	CpnyID = @CpnyID
 	  AND	OrdNbr = @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


