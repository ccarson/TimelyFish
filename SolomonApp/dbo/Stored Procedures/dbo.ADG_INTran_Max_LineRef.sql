 CREATE PROCEDURE ADG_INTran_Max_LineRef @parm1 varchar( 10 ), @parm2 varchar ( 10 ) AS
	SELECT CAST(MAX(LineRef) As SmallInt)
	FROM INTran
	WHERE 	BatNbr = @parm1 And
		CpnyID = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_Max_LineRef] TO [MSDSL]
    AS [dbo];

