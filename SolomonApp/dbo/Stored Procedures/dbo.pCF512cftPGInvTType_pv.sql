
/****** Object:  Stored Procedure dbo.pCF512cftPGInvTType_pv   Script Date: 9/14/2004 12:23:21 PM ******/
CREATE    Proc dbo.pCF512cftPGInvTType_pv
		@parm1 varchar(16),
		@parm2 varchar(2)

	as
	Select * from cftPGInvTType
		Where acct = @parm1
		AND TranTypeID Like @parm2
	Order by acct, TranTypeID





