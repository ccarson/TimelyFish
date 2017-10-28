 Create Proc LCDelete_INTran
	@RcptNbr varchar(15)
as
Delete FROM INTran
WHERE
	JrnlType = 'LC'
	and crtd_Prog LIKE '61200%'
	AND Rlsed = 0
	and RcptNbr = @rcptnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCDelete_INTran] TO [MSDSL]
    AS [dbo];

