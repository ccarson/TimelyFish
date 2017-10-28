 CREATE PROCEDURE EDContainer_BOLNbr
	@parm1 varchar( 20 )
AS
	SELECT *
	FROM EDContainer
	WHERE BOLNbr LIKE @parm1
	ORDER BY BOLNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_BOLNbr] TO [MSDSL]
    AS [dbo];

