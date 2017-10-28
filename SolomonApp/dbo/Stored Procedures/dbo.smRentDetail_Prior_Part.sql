 CREATE PROCEDURE
	smRentDetail_Prior_Part
		@parm1 	varchar(10)
		,@parm2	varchar(10)
		,@parm3	varchar(10)
		,@parm4	varchar(1)
AS
	SELECT
		*
	FROM
		smRentDetail
	WHERE
		BillingDate < @parm1
			AND
		BillStatus = 'P'
			AND
		BranchID LIKE @parm2
			AND
		RentalID LIKE @parm3
			AND
		Frequency LIKE @parm4
			AND
		Void = 0
	ORDER BY
		CustID
		,SiteId
		,TransID
		,LineId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentDetail_Prior_Part] TO [MSDSL]
    AS [dbo];

