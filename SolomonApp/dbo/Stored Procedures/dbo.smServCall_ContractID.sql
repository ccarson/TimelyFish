 CREATE PROCEDURE
	smServCall_ContractID
		@parm1	varchar(10)
	       ,@parm2  varchar(10)
AS
	SELECT
		*
	FROM
		smServCall (NOLOCK)
	WHERE
		ContractID = @parm1
			AND
		ServiceCallID LIKE @parm2
	ORDER BY
		ServiceCallId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_ContractID] TO [MSDSL]
    AS [dbo];

