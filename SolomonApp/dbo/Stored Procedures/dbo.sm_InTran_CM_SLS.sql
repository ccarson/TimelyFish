 CREATE PROCEDURE
	sm_InTran_CM_SLS
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		INTran
	WHERE
		Refnbr = @parm1
	-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


