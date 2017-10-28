
/****** Object:  Stored Procedure dbo.pXF135_cftSafeFeed_UnProc    Script Date: 1/27/2006 9:39:05 AM ******/
CREATE  Procedure pXF135_cftSafeFeed_UnProc as 
	Select * from cftSafeFeed Where StatusFlg <> 'P' 
	Order by DateReq


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF135_cftSafeFeed_UnProc] TO [MSDSL]
    AS [dbo];

