 CREATE PROCEDURE ADG_INTran_Max_LineID @parm1 varchar( 10 ) AS
	SELECT MAX(LineID)
	FROM INTran
	WHERE BatNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_Max_LineID] TO [MSDSL]
    AS [dbo];

