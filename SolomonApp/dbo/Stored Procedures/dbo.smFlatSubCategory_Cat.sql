 CREATE PROCEDURE
	smFlatSubCategory_Cat
		@parm1 varchar(10)
		,@parm2 varchar(10)
AS
	SELECT
		*
	FROM
		smFlatSubCategory
	WHERE
		FlatSubCategoryCatId = @parm1
			AND
		FlatSubCategoryId LIKE @parm2
	ORDER BY
	FlatSubCategoryCatId
	,FlatSubCategoryId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smFlatSubCategory_Cat] TO [MSDSL]
    AS [dbo];

