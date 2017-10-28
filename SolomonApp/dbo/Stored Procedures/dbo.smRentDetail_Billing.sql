 CREATE PROCEDURE
	smRentDetail_Billing
		@parm1 	smalldatetime
		,@parm2	varchar(10)
		,@parm3	varchar(10)
		,@parm4	varchar(1)
AS
	SELECT
		*
	FROM
		smRentDetail
	WHERE
		StartDate <= @parm1
			AND
		BillStatus IN ('P', 'N')
			AND
		BranchID LIKE @parm2
			AND
		RentalID LIKE @parm3
			AND
		Frequency LIKE @parm4
			AND
		BillingDate < @parm1
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
    ON OBJECT::[dbo].[smRentDetail_Billing] TO [MSDSL]
    AS [dbo];

