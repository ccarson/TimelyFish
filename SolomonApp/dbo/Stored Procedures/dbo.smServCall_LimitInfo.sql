 CREATE PROCEDURE
	smServCall_LimitInfo
		@parm1	varchar(10)
AS
	SELECT
		ServiceCallID, CustomerID, ShiptoID, ContractID, ServiceCallStatus
	FROM
		smServCall (NOLOCK)
	WHERE
		ServiceCallID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_LimitInfo] TO [MSDSL]
    AS [dbo];

