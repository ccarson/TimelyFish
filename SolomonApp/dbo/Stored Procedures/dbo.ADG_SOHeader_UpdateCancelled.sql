 CREATE PROCEDURE ADG_SOHeader_UpdateCancelled
	@CpnyID		varchar (10),
	@OrdNbr 	varchar (15)

AS

	UPDATE	SOHeader
	  SET	Cancelled = 1,
		DateCancelled = GETDATE()
	WHERE	CpnyID = @CpnyID
 	  AND	OrdNbr = @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOHeader_UpdateCancelled] TO [MSDSL]
    AS [dbo];

