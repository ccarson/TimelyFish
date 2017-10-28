 CREATE PROCEDURE
	sm_Terms_All
		@parm1	varchar(2)
AS
	SELECT
		*
	FROM
		Terms
	WHERE
		TermsId LIKE @parm1
	ORDER BY
		TermsId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


