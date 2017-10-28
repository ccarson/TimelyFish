 CREATE PROCEDURE
	sm_Country_All
		@parm1 	varchar(3)
AS
	SELECT
		*
	FROM
		Country
	WHERE
		CountryId LIKE @parm1
	ORDER BY
		CountryId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


