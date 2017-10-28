 CREATE PROCEDURE
	smFlatCategory_All
		@parm1	varchar(10)
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
    ON OBJECT::[dbo].[smFlatCategory_All] TO [MSDSL]
    AS [dbo];

