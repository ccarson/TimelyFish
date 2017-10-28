 CREATE PROCEDURE
	smPagerTemplate_TemplateID
		@parm1 varchar(10)
AS
	SELECT
		*
	FROM
		smPagerTemplate
	WHERE
		TemplateID LIKE @parm1
	ORDER BY
		TemplateID
		,FieldOrder

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smPagerTemplate_TemplateID] TO [MSDSL]
    AS [dbo];

