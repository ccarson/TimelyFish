 CREATE PROCEDURE DMG_SOLine_All2
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
AS
	SELECT	*
	FROM	SOLine
	WHERE	CpnyID = @CpnyID
	  AND	OrdNbr = @OrdNbr

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOLine_All2] TO [MSDSL]
    AS [dbo];

