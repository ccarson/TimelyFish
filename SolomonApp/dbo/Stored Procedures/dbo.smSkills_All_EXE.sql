 CREATE PROCEDURE
	smSkills_All_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smSkills
	WHERE
		SkillsId LIKE @parm1
	ORDER BY
		SkillsId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


