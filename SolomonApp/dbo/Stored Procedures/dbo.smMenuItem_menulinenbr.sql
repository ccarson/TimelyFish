 CREATE PROCEDURE
	smMenuItem_menulinenbr
		@parm1	smallint
		,@parm2beg	smallint
		,@parm2end	smallint
AS
	SELECT
		*
	FROM
		smMenuItem
	WHERE
		menulinenbr = @parm1
	   		AND
	   	linenbr BETWEEN @parm2beg AND @parm2end
	ORDER BY
		menulinenbr
		,linenbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


