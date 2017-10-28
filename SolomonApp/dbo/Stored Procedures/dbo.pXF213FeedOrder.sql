CREATE   Procedure [dbo].[pXF213FeedOrder]
	 @parmMill As Char(6), @Bparmdate smalldatetime, @Eparmdate smalldatetime, @parmbio AS varchar(1)
----------------------------------------------------------------------------------------
--	Purpose: Select the feed orders ready to build loads
--	Author: Sue Matter
--	Date: 7/20/2006
--	Program Usage: XF213
--	Parms: @Bparmdate Beginning date
--	Parms: @Eparmdate Ending date
--	Parms: @parmMill feed mill id
----------------------------------------------------------------------------------------

/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2015-01-08  Doran Dahle Added Biosecurity protocol
===============================================================================
*/
--SafGrid2
AS
Select fo.*, c.*, s.*,st.*,cmt.*,(mm.OneWayHours*2) As TravelHours, blp.Protocol as Protocol 
From cftFeedOrder fo
JOIN cftContact c ON fo.ContactID=c.ContactID AND ContactTypeID='04'
JOIN cftOrderStatus s ON fo.Status=s.Status
JOIN vCF401Miles mm  ON fo.ContactID=mm.ContactID AND fo.MillId=mm.MillID	
JOIN cftSite st ON c.ContactID=st.ContactID
LEFT JOIN cftSiteBio stb (nolock) ON st.ContactID=stb.ContactID and st.SiteID = stb.SiteID
LEFT JOIN cftBioLevelProtocol blp (nolock) ON stb.BioSecurityLevel = blp.BioSecurityLevel and blp.Department like 'Feed' and blp.Type like 'NonContact'
JOIN cftOrderType tp ON fo.OrdType=tp.OrdType
LEFT JOIN cftComments cmt ON fo.CommentId=cmt.CommentId
--LEFT JOIN cftFeedLoad fl ON fo.OrdNbr=fl.OrdNbr
Where (fo.DateReq >= @Bparmdate AND fo.DateReq <= @EparmDate) AND fo.MillId=@parmMill 
AND s.RelFlg=1 AND tp.RationFC='Y'
--AND fo.CF09<>1 AND fo.CF09<>2
--Only show orders that have went through prebuild in feed order entry
AND fo.CF09=3
AND st.FeedOrderComments LIKE (CASE @parmbio
	WHEN '1' THEN
	'%Prewash%'
	ELSE
	'%'
	END)
Order by fo.ContactID, fo.DateReq, fo.InvtIDOrd

