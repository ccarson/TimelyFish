 CREATE PROCEDURE ADG_SOSplitDefaults_Delete
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@SlsPerID varchar(10)
AS
	DELETE FROM SOSplitDefaults
	WHERE CpnyID LIKE @CpnyID AND
		OrdNbr LIKE @OrdNbr AND
		SlsPerID LIKE @SlsPerID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOSplitDefaults_Delete] TO [MSDSL]
    AS [dbo];

