 CREATE PROCEDURE
	smRentBilling_TransID
		@parm1	varchar(10)
		,@parm2	varchar(10)
AS
	SELECT
		*
	FROM
		smRentBilling
	WHERE
		TransID = @parm1
			AND
		OrdNbr LIKE @parm2
	ORDER BY
		TransID,
		OrdNbr DESC

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentBilling_TransID] TO [MSDSL]
    AS [dbo];

