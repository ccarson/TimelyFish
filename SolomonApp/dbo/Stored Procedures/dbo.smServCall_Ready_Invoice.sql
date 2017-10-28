 CREATE PROCEDURE
	smServCall_Ready_Invoice
		@parm1	varchar(1)
		,@parm2 varchar(10)
		,@parm3 varchar(10)
		,@parm4 varchar(10)
AS
	SELECT
		*
	FROM
		smServCall
	WHERE
		ServiceCallCompleted = CONVERT(int,@parm1)
		AND CpnyID = @parm2
		AND InvoiceFlag = 0
		AND InvoiceHandling = 'A'
		AND InvoiceStatus IN ('O','P')
		AND (PostToPeriod = @parm3 OR PostToPeriod = '')
		AND ServiceCallId LIKE @parm4
	ORDER BY
		ServiceCallId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_Ready_Invoice] TO [MSDSL]
    AS [dbo];

