 CREATE PROCEDURE
	sm_SalesPrice
		@parm1	varchar(30)
		,@parm2	varchar(10)
		,@parm3	varchar(6)
		,@parm4 float
AS
	SELECT
		*
	FROM
		SalesPrice
	WHERE
		SalesPrice.InvtId = @parm1
			AND
		SalesPrice.PrcLvlId = @parm2
			AND
		SalesPrice.SlsUnit = @parm3
			AND
		SalesPrice.QtyBreak <= @parm4
	ORDER BY
		SalesPrice.InvtId DESC
		,SalesPrice.PrcLvlId DESC
		,SalesPrice.SlsUnit DESC
		,SalesPrice.QtyBreak DESC

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


