 CREATE PROCEDURE smContract_All
	@parm1 varchar(10)
AS
	SELECT * FROM smContract
	WHERE 	ContractId LIKE @parm1
	ORDER BY
		ContractId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContract_All] TO [MSDSL]
    AS [dbo];

