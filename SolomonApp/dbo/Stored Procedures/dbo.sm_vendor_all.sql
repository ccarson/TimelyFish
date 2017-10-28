 CREATE PROCEDURE
	sm_vendor_all
		@parm1 	varchar(15)
AS
	SELECT
		*
	FROM
		Vendor
	WHERE
		vendid LIKE @parm1
	ORDER BY
		vendid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


