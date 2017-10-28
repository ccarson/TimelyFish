 CREATE PROCEDURE
	sm_Customer_All
		@parm1	varchar(15)
AS
	SELECT
		*
	FROM
		Customer
	WHERE
		CustId LIKE @parm1
	ORDER BY
		custid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


