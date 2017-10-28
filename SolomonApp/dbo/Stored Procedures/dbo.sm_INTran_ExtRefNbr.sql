 CREATE PROCEDURE
	sm_INTran_ExtRefNbr
		@parm1 varchar(15)
AS
	SELECT
		*
	FROM
		INTran
	WHERE
		ExtRefNbr = @parm1
	-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


