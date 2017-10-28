 CREATE PROCEDURE ADG_SOSplitLine_Delete
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@LineRef varchar(5),
	@SlsPerID varchar(10)
AS
	DELETE FROM SOSplitLine
	WHERE CpnyID LIKE @CpnyID AND
		OrdNbr LIKE @OrdNbr AND
		LineRef LIKE @LineRef AND
		SlsPerID LIKE @SlsPerID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOSplitLine_Delete] TO [MSDSL]
    AS [dbo];

