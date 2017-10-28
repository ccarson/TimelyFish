 CREATE PROCEDURE VendEDD_DocType @parm1 varchar(2)
AS
	SELECT *
	FROM VendEDD
	WHERE DocType = @parm1
	ORDER BY DocType


