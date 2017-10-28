 CREATE PROCEDURE
	sm_Subacct_Sub_Active
		@parm1	varchar(24)
AS
	SELECT
		*
	FROM
		Subacct
	WHERE
		Sub LIKE @parm1
			AND
		Active = 1
	ORDER BY
		Sub

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


