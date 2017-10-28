 CREATE PROCEDURE
	smResolution_all
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smResolution
	WHERE
		ResolutionID LIKE @parm1
	ORDER BY
		ResolutionID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smResolution_all] TO [MSDSL]
    AS [dbo];

