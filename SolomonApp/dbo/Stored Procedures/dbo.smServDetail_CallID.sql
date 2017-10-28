 --:message Creating procedure ...
CREATE PROCEDURE
	smServDetail_CallID
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smServDetail
 	WHERE
		ServiceCallID = @parm1
	ORDER BY
		ServiceCallID
		,FlatRateLineNbr
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


