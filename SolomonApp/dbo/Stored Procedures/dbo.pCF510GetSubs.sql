
/****** Object:  Stored Procedure dbo.pCF510GetSubs    Script Date: 9/22/2004 9:31:14 AM ******/

/****** Object:  Stored Procedure dbo.pCF510GetSubs    Script Date: 8/19/2004 1:04:59 PM ******/
CREATE      Proc pCF510GetSubs
	@parm1 varchar(10)
as
	Select sb.SubTypeID, sb.Description
	From cftPGInvTSub sb
	LEFT JOIN cftPGInvTType tp ON sb.TranTypeID=sb.TranTypeID
	LEFT JOIN cftPGTTypeScr sc on sb.TranTypeID=sc.TranTypeID
	WHERE sc.ScreenNbr = @parm1
	Group by sb.SubTypeID, sb.Description




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF510GetSubs] TO [MSDSL]
    AS [dbo];

