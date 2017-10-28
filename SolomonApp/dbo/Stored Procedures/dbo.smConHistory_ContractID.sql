 CREATE PROCEDURE
	smConHistory_ContractID
		@parm1	varchar(10)
		,@parm2	smallint
		,@parm3	smallint
		,@parm4	smallint
		,@parm5	smallint
AS
	SELECT
		*
	FROM
		smConHistory
 	WHERE
		ContractId = @parm1
			AND
		HistYear  BETWEEN @parm2 AND @parm3
			AND
		HistMonth BETWEEN @parm4 AND @parm5
	ORDER BY
		ContractID
		,HistYear
		,HistMonth

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


