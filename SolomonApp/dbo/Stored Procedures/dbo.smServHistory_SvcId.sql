 CREATE PROCEDURE
	smServHistory_SvcId
		@parm1	varchar(10)
		,@parm2	varchar(10)
AS
	SELECT
		*
	FROM
		smServHistory
	WHERE
		ServiceCallID LIKE @parm1
			AND
		CallStatus LIKE @parm2
	ORDER BY
		ServiceCallID
		,ChangedDate DESC
		,ChangedTime DESC
		,CallStatus

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


