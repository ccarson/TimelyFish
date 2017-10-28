
Create Procedure WS_ExpenseApproverHdr
		@parm1 varchar(10),
		@parm2 varchar(500)
AS
	DECLARE @szSelect	varchar(600)
	DECLARE @szFrom		varchar(500)
	DECLARE @szWhere	varchar(600)

	SELECT @szSelect = 'SELECT docnbr'
	SELECT @szFrom = ' FROM PJEXPHDR'
	SELECT @szWhere = ' WHERE docnbr = ' + @parm1 + ' AND ' + RTRIM(@parm2)
	
	EXEC (@szSelect + @szFrom + @szWhere)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_ExpenseApproverHdr] TO [MSDSL]
    AS [dbo];

