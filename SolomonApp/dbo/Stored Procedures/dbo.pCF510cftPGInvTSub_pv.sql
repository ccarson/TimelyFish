
/****** Object:  Stored Procedure dbo.pCF510cftPGInvTSub_pv    Script Date: 8/19/2004 1:04:59 PM ******/
CREATE    Proc pCF510cftPGInvTSub_pv
	@parm1 varchar(2), @parm2 varchar(2)
as
	Select *
	From cftPGInvTSub
	WHERE TranTypeID = @parm1
		AND SubTypeID LIKE @parm2
	Order by TranTypeID, SubTypeID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF510cftPGInvTSub_pv] TO [MSDSL]
    AS [dbo];

