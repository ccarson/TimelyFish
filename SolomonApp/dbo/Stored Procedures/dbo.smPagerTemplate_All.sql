 CREATE PROCEDURE
	smPagerTemplate_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smPagerTemplate
	WHERE
		TemplateID LIKE @parm1
	ORDER BY
		TemplateID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smPagerTemplate_All] TO [MSDSL]
    AS [dbo];

