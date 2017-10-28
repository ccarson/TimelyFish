 CREATE PROCEDURE
	smModel_Manuf_Search
		@parm1	varchar(10)
		,@parm2 varchar(40)
AS
	SELECT
		*
	FROM
		smModel
	WHERE
		ManufId  LIKE @parm1
			AND
		ModelID LIKE @parm2
	ORDER BY
		ManufId
		,ModelID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smModel_Manuf_Search] TO [MSDSL]
    AS [dbo];

