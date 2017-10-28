 CREATE PROCEDURE
	smMediaBuys_All
		@parm1 varchar(10)
AS
	SELECT
		*
	FROM
		smMediaBuys
	WHERE
		MediaBuyId LIKE @parm1
	ORDER BY
		MediaBuyId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


