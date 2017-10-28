﻿ CREATE PROCEDURE
	smPTHeader_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smPTHeader
	WHERE
		TemplateID LIKE @parm1
	ORDER BY
		TemplateID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smPTHeader_All] TO [MSDSL]
    AS [dbo];

