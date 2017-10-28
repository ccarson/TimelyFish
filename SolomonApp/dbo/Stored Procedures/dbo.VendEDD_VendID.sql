 CREATE PROCEDURE VendEDD_VendID @parm1 varchar(15), @parm2 varchar(2)
AS
	SELECT *
	FROM VendEDD
	WHERE VendID = @parm1 AND DocType like @parm2
	ORDER BY VendID, DocType


