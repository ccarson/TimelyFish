 CREATE PROCEDURE
	smLBDetail_CallComp2
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smLBDetail
	WHERE
		ServiceCallID = @parm1
			AND
		LineTypes IN ( 'I', 'M', 'N')

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smLBDetail_CallComp2] TO [MSDSL]
    AS [dbo];

