CREATE   Procedure pXF211FeedLoad
	@parmMill As Char(6), @parmdate smalldatetime

----------------------------------------------------------------------------------------
--	Purpose: Select all oders that need to be built for this date-SAFGRID1
--	Author: Sue Matter
--	Date: 8/1/2006
--	Program Usage: XF211
--	Parms: @parmmill Mill Id
--	Parms: @parmdate Date Requested
----------------------------------------------------------------------------------------

AS
Select fo.*, c.* ,s.*, st.*,ct.*--, fl.*,fc.*
From cftFeedOrder fo
JOIN cftContact c ON fo.ContactID=c.ContactID AND ContactTypeID='04'
JOIN cftOrderStatus s ON fo.Status=s.Status
JOIN cftSite st ON c.ContactID=st.ContactID
JOIN cftOrderType tp ON fo.OrdType=tp.OrdType
LEFT JOIN cftComments ct ON fo.CommentID=ct.CommentID
--LEFT JOIN cftFeedLoad fl ON fo.OrdNbr = fl.OrdNbr
--LEFT JOIN cftFeedTrDrCab fc ON fl.TrDrCabId=fc.TrDrCabId
Where fo.DateReq=@parmdate AND fo.MillId=@parmMill AND s.RelFlg=1 
AND fo.CF09=0 AND tp.RationFC='Y'
--AND st.FeedOrderComments NOT LIKE '%Prewash%'
Order by c.ContactName, fo.BinNbr, st.FeedGrouping


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF211FeedLoad] TO [MSDSL]
    AS [dbo];

