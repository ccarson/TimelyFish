CREATE   Proc dbo.cftPGInvTType_pv
		@parm1 varchar(2)
	as
	Select * from cftPGInvTType
		Where TranTypeID Like @parm1
	Order by TranTypeID




