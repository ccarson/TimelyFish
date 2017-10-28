 CREATE PROCEDURE
	smLBDetail_CallComp
		@parm1	varchar(10)
		,@parm2	varchar(1)
AS
	SELECT
		*
	FROM
		smLBDetail
	WHERE
		ServiceCallID = @parm1
			AND
		LineTypes = @parm2

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


