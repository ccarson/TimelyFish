 CREATE PROCEDURE
	smFRDetail_CallID
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smFRDetail
 	WHERE
		ServiceCallID = @parm1
	ORDER BY
		ServiceCallID
		,FlatRateLineNbr
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smFRDetail_CallID] TO [MSDSL]
    AS [dbo];

