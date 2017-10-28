 create procedure INTran_BatNbr_LineRef
	@parm1		varchar(10),
	@parm2		varchar(5) as

	Select * from INTran
		Where	Batnbr = @parm1 and
			LineRef = @parm2
    	Order by BatNbr, LineId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr_LineRef] TO [MSDSL]
    AS [dbo];

