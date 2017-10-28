 CREATE PROCEDURE
	sm_INTran_Refnbr_SLS
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		INTran
	WHERE
		RefNbr = @parm1
	-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


