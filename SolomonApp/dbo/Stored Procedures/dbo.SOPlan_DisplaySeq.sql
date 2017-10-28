 CREATE PROCEDURE SOPlan_DisplaySeq
	@parm1 varchar( 36 )
AS
	SELECT *
	FROM SOPlan
	WHERE DisplaySeq LIKE @parm1
	ORDER BY DisplaySeq

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOPlan_DisplaySeq] TO [MSDSL]
    AS [dbo];

