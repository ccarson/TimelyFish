 CREATE PROC LCCode_Method_Code
	@parm1 VARCHAR(01),
	@parm2 VARCHAR(10)
AS
	SELECT *
	FROM lccode
	WHERE Applmethod in ('B',@parm1)
	and  lccode like @parm2
	ORDER BY lccode

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


