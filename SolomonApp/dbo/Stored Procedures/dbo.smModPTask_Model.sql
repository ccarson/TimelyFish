 CREATE PROCEDURE
	smModPTask_Model
		@parm1 	varchar(10)
		,@parm2	varchar(40)
AS
	SELECT
		*
	FROM
		smModPTask
	WHERE
		Manuf LIKE @parm1
			AND
		Model LIKE @parm2
	ORDER BY
		smModPTask.Manuf
		,smModPTask.Model
		,smModPTask.PMCode

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smModPTask_Model] TO [MSDSL]
    AS [dbo];

