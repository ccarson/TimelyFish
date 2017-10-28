 CREATE	PROCEDURE SCM_Delete_INUpdateQty_Wrk
	@ComputerName	VARCHAR (21)
AS
	IF @ComputerName = '%'
		DELETE FROM INUpdateQty_Wrk WHERE ComputerName = @ComputerName	/* Computer Name */
	ELSE
		DELETE FROM INUpdateQty_Wrk WHERE ComputerName LIKE @ComputerName



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Delete_INUpdateQty_Wrk] TO [MSDSL]
    AS [dbo];

