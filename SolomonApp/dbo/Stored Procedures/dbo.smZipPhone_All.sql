 CREATE PROCEDURE
	smZipPhone_All
		@parm1	varchar(10)
		,@parm2 varchar(20)
AS
	SELECT
		*
	FROM
		smZipPhone
	WHERE
		ZipId = @parm1
			AND
		ZipPhoneType LIKE @parm2
	ORDER BY
		ZipId
		,ZipPhoneType

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smZipPhone_All] TO [MSDSL]
    AS [dbo];

