 CREATE PROCEDURE smServCall_Open_Entry_CpnyID
	@parm1 varchar(15)
	,@parm2 varchar(10)
	,@parm3 varchar(10)
AS
SELECT * FROM smServCall
	WHERE
		CustomerId = @parm1 AND
		ShiptoId = @parm2 AND
		CpnyId = @parm3 AND
        		ServiceCallCompleted =  0
        	ORDER BY
			ServiceCallID,
			ServiceCallDateProm

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_Open_Entry_CpnyID] TO [MSDSL]
    AS [dbo];

