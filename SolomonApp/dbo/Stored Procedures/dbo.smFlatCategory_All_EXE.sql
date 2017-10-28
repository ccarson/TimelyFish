 CREATE PROCEDURE
	smFlatCategory_All_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smFlatCategory
	WHERE
		FlatCategoryId LIKE @parm1
	ORDER BY
		FlatCategoryId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smFlatCategory_All_EXE] TO [MSDSL]
    AS [dbo];

