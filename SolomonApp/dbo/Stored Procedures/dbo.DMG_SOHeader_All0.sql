 CREATE PROCEDURE DMG_SOHeader_All0
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
AS
	SELECT	*
	FROM	SOHeader
	WHERE	CpnyID = @CpnyID
	  AND	OrdNbr = @OrdNbr

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOHeader_All0] TO [MSDSL]
    AS [dbo];

