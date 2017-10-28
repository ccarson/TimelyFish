CREATE   Proc pCF500InvTran_pv
	@parm1 varchar(2)
as
	Select * From cftPGInvTType
	WHERE TranTypeID = @parm1
	Order by TranTypeID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF500InvTran_pv] TO [MSDSL]
    AS [dbo];

