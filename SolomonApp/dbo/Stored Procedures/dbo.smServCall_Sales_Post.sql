 CREATE PROCEDURE
	smServCall_Sales_Post
		@parm1	varchar(6)
		,@parm2	varchar(6)
		,@parm3 varchar(10)
AS
	SELECT
		*
	FROM
		smServCall
		,Customer
	WHERE
		PostToPeriod BETWEEN  @parm1 AND @parm2
		AND
		(ServiceCallCompleted = 1 OR cmbCODInvoice = 'P')
        	AND
        	smServCall.CustomerId = Customer.CustId
		AND
		smServCall.Branchid Like @parm3
	 ORDER BY
		ServiceCallID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_Sales_Post] TO [MSDSL]
    AS [dbo];

