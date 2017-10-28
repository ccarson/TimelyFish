 --:message Creating procedure ..

CREATE PROCEDURE
	smServDetail_all
		@parm1 varchar( 10 ),
		@parm2 varchar( 1 ),
		@parm3min smallint, @parm3max smallint,
		@parm4min smallint, @parm4max smallint
AS
	SELECT
		*
	FROM
		smServDetail
	WHERE
		ServiceCallID LIKE @parm1
	   		AND
	   	BillingType LIKE @parm2
	   		AND
	   	FlatRateLineNbr BETWEEN @parm3min AND @parm3max
	   		AND
	   	LineNbr BETWEEN @parm4min AND @parm4max
	ORDER BY
		   ServiceCallID,
		   BillingType,
		   FlatRateLineNbr,
		   LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


