 CREATE PROCEDURE
	smConMaster_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smConMaster
		,Customer
	WHERE
		MasterId LIKE @parm1
			AND
		smConMaster.CustId = Customer.CustId
	ORDER BY
		MasterId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


