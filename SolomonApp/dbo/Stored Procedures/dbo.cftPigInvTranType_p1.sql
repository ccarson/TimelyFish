
Create Proc dbo.cftPigInvTranType_p1
		@parm1 char

as
	Select * from dbo.cftPigInvTranType
		Where PigInvTranTypeID = @parm1
	Order by PigInvTranTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[cftPigInvTranType_p1] TO [MSDSL]
    AS [dbo];

