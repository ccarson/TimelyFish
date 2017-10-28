 CREATE PROCEDURE
	smRateDetail_CallComp
		@parm1 varchar(10)
AS
	SELECT
		*
	FROM
		smRateDetail
	WHERE
		FlatRateId = @parm1
	ORDER BY
		FlatRateID
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRateDetail_CallComp] TO [MSDSL]
    AS [dbo];

