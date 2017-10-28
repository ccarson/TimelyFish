 CREATE PROCEDURE smNotesTemplate_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM smNotesTemplate
	WHERE TemplateID LIKE @parm1
	ORDER BY TemplateID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smNotesTemplate_all] TO [MSDSL]
    AS [dbo];

