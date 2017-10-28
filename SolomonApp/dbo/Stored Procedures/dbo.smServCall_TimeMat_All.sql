
CREATE PROCEDURE
	smServCall_TimeMat_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smServCall
	WHERE
		ServiceCallId LIKE @parm1 AND
		cmbInvoiceType = 'T'
	ORDER BY
		ServiceCallId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


