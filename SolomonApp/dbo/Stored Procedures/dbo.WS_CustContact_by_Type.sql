 CREATE PROCEDURE WS_CustContact_by_Type
	@parm1 varchar(15),
	@parm2 varchar(2),
	@parm3 varchar(10)
AS
	SELECT ContactID,Name,POReqdAmt
	FROM CustContact
	WHERE CustID LIKE @parm1
	   AND Type LIKE @parm2
	   AND ContactID LIKE @parm3
	ORDER BY CustID,
	   ContactID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_CustContact_by_Type] TO [MSDSL]
    AS [dbo];

