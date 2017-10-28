 CREATE PROCEDURE OptDepExcl_DepExclOpt_DepExclF
	@parm1 varchar( 30 ),
	@parm2 varchar( 4 )
AS
	SELECT *
	FROM OptDepExcl
	WHERE DepExclOpt LIKE @parm1
	   AND DepExclFtr LIKE @parm2
	ORDER BY DepExclOpt,
	   DepExclFtr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[OptDepExcl_DepExclOpt_DepExclF] TO [MSDSL]
    AS [dbo];

