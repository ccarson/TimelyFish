 CREATE PROCEDURE
	sm_Salesper_SlsperId
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		Salesperson
	WHERE
		SlsperId LIKE @parm1
	ORDER BY
		SlsperId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


