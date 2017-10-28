 CREATE PROCEDURE CustEDD_CustID @parm1 varchar(15), @parm2 varchar(2)
AS
	SELECT *
	FROM CustEDD
	WHERE CustID = @parm1 AND DocType like @parm2
	ORDER BY CustID, DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CustEDD_CustID] TO [MSDSL]
    AS [dbo];

