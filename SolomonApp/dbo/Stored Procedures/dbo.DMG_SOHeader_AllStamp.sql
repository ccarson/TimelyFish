 CREATE PROCEDURE DMG_SOHeader_AllStamp
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
AS
	SELECT	*,
		convert(int, tstamp)
	FROM	SOHeader
	WHERE	CpnyID = @CpnyID
	  AND	OrdNbr = @OrdNbr

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOHeader_AllStamp] TO [MSDSL]
    AS [dbo];

