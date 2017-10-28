 CREATE PROCEDURE
	smContract_SD200
		@parm1 	varchar(10)
AS
	SELECT
		PrimaryTech, SecondTech
	FROM
		smContract (NOLOCK)
	WHERE
		ContractID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContract_SD200] TO [MSDSL]
    AS [dbo];

