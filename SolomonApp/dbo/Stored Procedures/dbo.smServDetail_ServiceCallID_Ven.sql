 --:message Creating procedure ..
CREATE PROCEDURE
	smServDetail_ServiceCallID_Ven
		@parm1 varchar( 10 ),
		@parm2 varchar( 15 ),
		@parm3min smalldatetime, @parm3max smalldatetime
AS
	SELECT
		*
	FROM
		smServDetail
	WHERE
		ServiceCallID LIKE @parm1
	   		AND
	   	VendID LIKE @parm2
	   		AND
	   	PODate BETWEEN @parm3min AND @parm3max
	ORDER BY
		ServiceCallID,
	   	VendID,
	   	PODate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


