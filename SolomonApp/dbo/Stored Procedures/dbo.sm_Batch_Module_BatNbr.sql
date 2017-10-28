 CREATE PROCEDURE
	sm_Batch_Module_BatNbr
	@parm1	varchar(2)
	,@parm2	varchar(10)
AS
	SELECT
		*
	FROM
		Batch
	WHERE
		Module = @parm1
	   		AND
	   	BatNbr = @parm2
	ORDER BY
		Module
		,BatNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


