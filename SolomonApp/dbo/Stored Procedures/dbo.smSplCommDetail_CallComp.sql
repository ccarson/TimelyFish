 CREATE PROCEDURE
	smSplCommDetail_CallComp
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smSplCommDetail
	WHERE
		ServiceCallID = @parm1
	ORDER BY
		ServiceCallid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


