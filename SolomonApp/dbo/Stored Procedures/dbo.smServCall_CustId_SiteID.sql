 CREATE PROCEDURE
	smServCall_CustId_SiteID
		@parm1	varchar(15)
		,@parm2	varchar(10)
		,@parm3 varchar(10)
AS
	SELECT
		*
	FROM
		smServCall (NOLOCK)
	WHERE
		CustomerId = @parm1
			AND
		ShiptoId = @parm2
			AND
		ServiceCallCompleted = 1
			AND
		smServCall.ServiceCallID LIKE @parm3
	ORDER BY
		ServiceCallDate DESC

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_CustId_SiteID] TO [MSDSL]
    AS [dbo];

