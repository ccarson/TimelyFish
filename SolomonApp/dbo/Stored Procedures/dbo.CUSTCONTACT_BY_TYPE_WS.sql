 CREATE PROCEDURE CUSTCONTACT_BY_TYPE_WS
	@parm1 varchar(15),
	@parm2 varchar(2),
	@parm3 varchar(10)
AS
	SELECT ContactID, Name
	FROM CustContact
	WHERE CustID = @parm1
	   AND Type = @parm2
	   AND ContactID = @parm3


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CUSTCONTACT_BY_TYPE_WS] TO [MSDSL]
    AS [dbo];

