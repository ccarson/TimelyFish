CREATE   Procedure pXF211FeedOrder
	 @parmMill As Char(6), @parmdate smalldatetime, @parmsite AS varchar(6), 
	 @parmbio As varchar(1)

----------------------------------------------------------------------------------------
--	Purpose: Select all oders that need a manual load built-SAFGRID2
--	Author: Sue Matter
--	Date: 8/1/2006
--	Program Usage: XF211
--	Parms: @parmmill Mill Id
--	Parms: @parmdate Date Requested
--	Parms: @parmsite Site Id for Load
--	Parms: @parmbio BioSecurity setting
----------------------------------------------------------------------------------------

AS
Select fo.*, c.*, s.*,st.*,ct.*
From cftFeedOrder fo
JOIN cftContact c ON fo.ContactID=c.ContactID AND ContactTypeID='04'
JOIN cftOrderStatus s ON fo.Status=s.Status
JOIN cftSite st ON c.ContactID=st.ContactID
JOIN cftOrderType tp ON fo.OrdType=tp.OrdType
LEFT JOIN cftComments ct ON fo.CommentID=ct.CommentID
--LEFT JOIN cftFeedLoad fl ON fo.OrdNbr=fl.OrdNbr
Where fo.DateReq=@parmdate AND fo.MillId=@parmMill 
--Where fo.DateReq='20060715' AND fo.MillId='001327'
AND s.RelFlg=1 AND tp.RationFC='Y'
--AND (st.FeedOrderComments LIKE '%Prewash%' OR fo.CF09=3) AND fo.CF09<>1
AND fo.CF09=3
AND st.FeedOrderComments LIKE (CASE @parmbio
	WHEN '1' THEN
	'%Prewash%'
	ELSE
	'%'
	END)
AND fo.ContactID LIKE (CASE LEFT(@parmsite,1)
	WHEN '%' THEN
	'%'
	ELSE 
	@parmsite
	END)
Order by fo.ContactID, fo.DateReq, fo.OrdNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF211FeedOrder] TO [MSDSL]
    AS [dbo];

