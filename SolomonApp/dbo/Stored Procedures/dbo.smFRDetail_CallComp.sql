 CREATE PROCEDURE
	smFRDetail_CallComp
		@parm1	varchar(10)
		,@parm2 smallint
AS
	SELECT
		*
	FROM
		smFRDetail
	WHERE
		ServiceCallID LIKE @parm1
			AND
		FlatRateLineNbr = @parm2
	 ORDER BY
		ServiceCallID
		,FlatRateLineNbr
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smFRDetail_CallComp] TO [MSDSL]
    AS [dbo];

