 CREATE PROCEDURE
	sm_ArTran_InvcNbr
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		ARTran
	WHERE
		ArTran.RefNbr = @parm1
			AND
		TranType = 'IN'
			AND
		DRCR = 'C'
	ORDER BY
		RefNbr
		,TranType
		,LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


