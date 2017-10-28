 CREATE PROCEDURE
	smMarkBreaks_MarkupID_Limit
		@parm1	varchar(10)
		,@parm2	float
AS
	SELECT
		*
	FROM
		smMarkBreaks
	WHERE
		MarkupBreakId = @parm1
			AND
		 MarkupBreakLimit >= @parm2
	ORDER BY
		MarkupBreakId
		,MarkupBreakLimit

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


