 CREATE PROCEDURE smSCQueue_Grid
	@parm1 smalldatetime
	,@parm2 varchar(10)
AS
SELECT *
FROM smServCall
	left outer join SOAddress
		on smServCall.CustomerId = SOAddress.Custid
			and smServCall.ShiptoId = SOAddress.Shiptoid
WHERE smServCall.ServiceCallDate <= @parm1
	AND smServCall.ServiceCallCompleted = 0
	AND smServCall.ServiceCallDuration = 'S'
	AND smServCall.ServiceCallStatus = 'R'
	AND smServCall.ServiceCallID LIKE @parm2
ORDER BY ServiceCallID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smSCQueue_Grid] TO [MSDSL]
    AS [dbo];

