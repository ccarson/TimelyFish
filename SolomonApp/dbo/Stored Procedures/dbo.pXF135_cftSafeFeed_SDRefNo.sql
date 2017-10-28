


CREATE   Procedure pXF135_cftSafeFeed_SDRefNo 
	@parm1 varchar (6) as 
	Select * 
	from cftSafeFeed 
	Where StatusFlg = 'O' and SDRefNo Like @parm1
	Order by DateReq


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF135_cftSafeFeed_SDRefNo] TO [MSDSL]
    AS [dbo];

