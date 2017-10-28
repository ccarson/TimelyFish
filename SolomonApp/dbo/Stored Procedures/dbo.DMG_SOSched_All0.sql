 CREATE PROCEDURE DMG_SOSched_All0
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5)
AS
	SELECT	*
	FROM	SOSched
	WHERE	CpnyID = @CpnyID
	  AND	OrdNbr = @OrdNbr
	  AND	LineRef = @LineRef
	  AND	SchedRef = @SchedRef

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOSched_All0] TO [MSDSL]
    AS [dbo];

