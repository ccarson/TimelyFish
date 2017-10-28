CREATE   Proc cftPigInvTranSub_p1
	@parm1 varchar(2), @parm2 varchar(2)
as
	Select * From cftPigInvTranSub
	WHERE PigInvTranTypeID = @parm1
		AND PigInvSubTypeID LIKE @parm2
	Order by PigInvTranTypeID, PigInvSubTypeID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cftPigInvTranSub_p1] TO [MSDSL]
    AS [dbo];

