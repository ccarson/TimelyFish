 CREATE PROCEDURE
	smEmpClass_GDB
AS
	SELECT
		EmpClassID
	FROM
		smEmpClass



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmpClass_GDB] TO [MSDSL]
    AS [dbo];

