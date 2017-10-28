CREATE   Proc dbo.pCF510cftPGInvTType_pv
		@parm1 varchar(2)
	as
	Select * from cftPGInvTType
		Where TranTypeID Like @parm1
	Order by TranTypeID





GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF510cftPGInvTType_pv] TO [MSDSL]
    AS [dbo];

