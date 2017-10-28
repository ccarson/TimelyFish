CREATE Proc pCF500TranandSub_p1
	@parm1 varchar(2), @parm2 varchar(2)
as
	Select cftPGInvTSub.* 
	From cftPGInvTSub, cftPGInvTType
	WHERE cftPGInvTType.TranTypeID=cftPGInvTSub.TranTypeID
	AND cftPGInvTSub.TranTypeID = @parm1 And cftPGInvTSub.SubTypeID Like @parm2
	Order by cftPGInvTSub.TranTypeID, cftPGInvTSub.SubTypeID 




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF500TranandSub_p1] TO [MSDSL]
    AS [dbo];

