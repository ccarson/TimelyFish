 CREATE PROCEDURE
	smTMDetail_CallComp2
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smTMDetail
	WHERE
		ServiceCallID = @parm1
			AND
		LineTypes IN  ('I' , 'M' , 'N')

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smTMDetail_CallComp2] TO [MSDSL]
    AS [dbo];

