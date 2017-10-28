 CREATE PROCEDURE SOSplitDefaults_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM SOSplitDefaults
	WHERE CpnyID = @parm1
	   AND OrdNbr LIKE @parm2
	   AND SlsperId LIKE @parm3
	ORDER BY CpnyID,
	   OrdNbr,
	   SlsperId

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOSplitDefaults_all] TO [MSDSL]
    AS [dbo];

