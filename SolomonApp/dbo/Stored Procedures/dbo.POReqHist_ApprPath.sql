 CREATE PROCEDURE POReqHist_ApprPath
	@parm1 varchar( 1 )
AS
	SELECT *
	FROM POReqHist
	WHERE ApprPath LIKE @parm1
	ORDER BY ApprPath

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReqHist_ApprPath] TO [MSDSL]
    AS [dbo];

