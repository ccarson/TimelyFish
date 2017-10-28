
CREATE PROCEDURE
	smServCall_FlatRate_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smServCall
	WHERE
		ServiceCallId LIKE @parm1 AND
		cmbInvoiceType = 'F'
	ORDER BY
		ServiceCallId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_FlatRate_All] TO [MSDSL]
    AS [dbo];

