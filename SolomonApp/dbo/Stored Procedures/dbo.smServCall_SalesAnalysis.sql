 CREATE PROCEDURE
	smServCall_SalesAnalysis
		@parm1	smalldatetime
		,@parm2	smalldatetime
		,@parm3 varchar(10)
AS
	SELECT
		*
	FROM
		smServCall
		,Customer
	WHERE
		completeDate BETWEEN  @parm1 AND @parm2
		AND
		(ServiceCallCompleted = 1 OR cmbCODInvoice = 'P')
        	AND
	        smServCall.CustomerId = Customer.CustId
		AND
		smServCall.BranchId LIKE @parm3
	 ORDER BY
		ServiceCallID


