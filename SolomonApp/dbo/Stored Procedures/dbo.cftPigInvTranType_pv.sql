/****** Object:  Stored Procedure dbo.cftPigInvTranType_pv    Script Date: 7/28/2004 2:42:23 PM ******/
CREATE  Proc dbo.cftPigInvTranType_pv
		@parm1 varchar(2)
	as
	Select * from cftPigInvTranType
		Where PigInvTranTypeID Like @parm1
	Order by PigInvTranTypeID




GO
GRANT CONTROL
    ON OBJECT::[dbo].[cftPigInvTranType_pv] TO [MSDSL]
    AS [dbo];

