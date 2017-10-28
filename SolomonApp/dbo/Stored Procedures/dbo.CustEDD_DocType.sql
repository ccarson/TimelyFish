 CREATE PROCEDURE CustEDD_DocType @parm1 varchar(2)
AS
	SELECT *
	FROM CustEDD
	WHERE DocType = @parm1
	ORDER BY DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CustEDD_DocType] TO [MSDSL]
    AS [dbo];

